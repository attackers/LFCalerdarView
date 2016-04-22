//
//  CalerdarViewController.m
//  LFCalendar
//
//  Created by lifu on 16/3/29.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import "CalerdarViewController.h"
#import "CalerdarCollectionViewCell.h"
#import "CalerdarCollectionReusableView.h"
#import "LFCalendarValueInfo.h"
#import "DateObject.h"
static NSString *const CalerdarCell = @"CalerdarCell";
static NSString *const ReusableCell = @"ReusableCell";
#define itemWidth (NSInteger)[UIScreen mainScreen].bounds.size.width/7
@interface CalerdarViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionview;
    NSInteger howManyDay;
    NSInteger howManyWeek;
    NSInteger howManyDaysInbeforeMonth;
    
    NSInteger firstDateWeekFormMonth;
    NSInteger lastDateInWeekFormMonth;
    
    NSInteger howManyItem;
    NSMutableArray *dayArray;
    
    NSInteger currentMonth;
    NSInteger currentYear;
    
    NSString *showDateStg;
    BOOL  theHorizontal;
}
@end

@implementation CalerdarViewController
-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    NSDictionary *dateDic = [DateObject stringCalendarFromString:[DateObject stringForDate:[NSDate date]]];
    currentYear = [[dateDic objectForKey:@"year"]integerValue];
    currentMonth = [[dateDic objectForKey:@"month"]integerValue];
    [self getValue:[NSDate date]];
    [self collectionviewInit];
    [self changeCollectionviewLayout:NO];
}
- (void)collectionviewInit{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 1;
    CGFloat itemSize = itemWidth;
    flowLayout.itemSize = CGSizeMake(itemSize-1, itemSize-1);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, itemWidth*7, itemWidth) collectionViewLayout:flowLayout];
    
    [_collectionview registerNib:[UINib nibWithNibName:@"CalerdarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CalerdarCell];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    
    _collectionview.scrollEnabled = YES;
    _collectionview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _collectionview.contentSize = CGSizeMake(itemWidth*7, itemWidth*howManyWeek);
    _collectionview.pagingEnabled = YES;
    [self.view addSubview:_collectionview];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_collectionview addGestureRecognizer:swipe];
    UISwipeGestureRecognizer *swipe3 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    swipe3.direction = UISwipeGestureRecognizerDirectionLeft;
    [_collectionview addGestureRecognizer:swipe3];
    
};
- (void)changeCollectionviewLayout:(BOOL)horizontal
{
    theHorizontal = horizontal;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemSize = itemWidth;
    flowLayout.itemSize = CGSizeMake(itemSize, itemSize);

    CGFloat hight = 0;
    if (horizontal) {
        
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
        _collectionview.frame = CGRectMake(0, 0, itemWidth*7, itemWidth);
        hight = itemWidth+46;
        
    }else{
        
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
        flowLayout.itemSize = CGSizeMake(itemSize, itemSize);
        _collectionview.frame = CGRectMake(0, 0, itemWidth*7, (howManyWeek+1)*itemWidth+howManyWeek);
        hight = (howManyWeek+1)*itemWidth+howManyWeek;
        
    }
    _collectionview.collectionViewLayout = flowLayout;
    _collectionview.center = CGPointMake(self.view.center.x, _collectionview.center.y);
    _collectionview.contentSize = CGSizeMake(itemWidth*7, itemWidth*howManyWeek);
    
    if ([self.delegate respondsToSelector:@selector(calerdarviewHight:)]) {
        [self.delegate calerdarviewHight:hight];
    }
}
- (void)getValue:(NSDate*)date
{
    dayArray = [NSMutableArray array];
    howManyDay = [LFCalendarValueInfo getHowManyDaysInMonth:date];
    howManyWeek = [LFCalendarValueInfo getHowManyWeekInMonth:date];
    firstDateWeekFormMonth = [LFCalendarValueInfo getFirstDayInWeekDays:date];
    lastDateInWeekFormMonth = [LFCalendarValueInfo getLastDayInWeekDays:date];
    howManyDaysInbeforeMonth = [LFCalendarValueInfo getHowManyDaysInBeforeMonth:date];
    
    NSDictionary *dic = [DateObject stringCalendarFromString:[DateObject stringForDate:date]];
    NSString *year = [dic objectForKey:@"year"];
    NSString *month = [dic objectForKey:@"month"];
    
    NSString *monthUser= [[DateObject stringForDate:date] substringToIndex:7];
    NSString *monthSys = [[DateObject stringForDate:[NSDate date]] substringToIndex:7];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[cd] %@",monthSys];
    
    for (NSInteger i = firstDateWeekFormMonth - 1; i>=0; i--) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"%lu",howManyDaysInbeforeMonth - i] forKey:@"day"];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:@"currentMonth"];
        NSString *dateStg = nil;
        if ([month isEqualToString:@"1"]) {
            dateStg = [NSString stringWithFormat:@"%lu-%02d-%02lu",[year integerValue] - 1,12,howManyDaysInbeforeMonth - i];
        }else{
            dateStg = [NSString stringWithFormat:@"%lu-%02lu-%02lu",[year integerValue] - 1,[month integerValue] -1,howManyDaysInbeforeMonth - i];
        }
        [dic setObject:dateStg forKey:@"dateInfo"];
        [dayArray addObject:dic];
    }
    
    for (NSInteger i = 1; i<=howManyDay; i++) {
        NSString *dateStg = nil;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"%lu",(long)i] forKey:@"day"];
        [dic setObject:[NSNumber numberWithBool:YES] forKey:@"currentMonth"];
        dateStg = [NSString stringWithFormat:@"%lu-%02lu-%02lu",[year integerValue],[month integerValue],i];
        [dic setObject:dateStg forKey:@"dateInfo"];
        
        if (![predicate evaluateWithObject:monthUser]) {
            
            if (i == 1) {
                [dic setObject:@"hightGray" forKey:@"hightGray"];
            }
        }
        
        [dayArray addObject:dic];
    }
    
    NSInteger endDate = (7 - lastDateInWeekFormMonth);
    
    for (NSInteger i = 1; i<=endDate; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"%lu",(long)i] forKey:@"day"];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:@"currentMonth"];
        
        NSString *dateStg = nil;
        if ([month isEqualToString:@"12"]) {
            dateStg = [NSString stringWithFormat:@"%lu-%02d-%02lu",[year integerValue] + 1,1,i];
        }else{
            dateStg = [NSString stringWithFormat:@"%@-%02lu-%02lu",year,[month integerValue] + 1,i];
        }
        [dic setObject:dateStg forKey:@"dateInfo"];
        
        [dayArray addObject:dic];
    }
    
    showDateStg = [DateObject stringFromString:[DateObject stringForDate:date] showStyle:showYM_style];
    
    if ([self.delegate respondsToSelector:@selector(changeDate:)]) {
        [self.delegate changeDate:showDateStg];
    }
    
    self.title = showDateStg;
    howManyItem =  howManyWeek*7+firstDateWeekFormMonth + (7 - lastDateInWeekFormMonth);
    [self changeCollectionviewLayout:theHorizontal];
    _collectionview.center = CGPointMake(self.view.center.x, _collectionview.center.y);
    [_collectionview reloadData];
    
}
- (void)swipeAction:(UISwipeGestureRecognizer*)swipe
{

    CGPoint point = _collectionview.contentOffset;
    CGSize size = _collectionview.contentSize;
    
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        {
            if (theHorizontal) {
                CGRect rect = CGRectZero;
                CGFloat y = (point.y/itemWidth - 1)*itemWidth;
                rect.origin = CGPointMake(point.x, y);
                rect.size = size;
                [_collectionview scrollRectToVisible:rect animated:YES];
                break;
            }
            
            if (currentMonth==1) {
                currentMonth = 12;
                currentYear--;
            }else{
                currentMonth--;
            }
            
            [UIView transitionWithView:_collectionview duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
                
            } completion:nil];
        }
            break;
        case UISwipeGestureRecognizerDirectionLeft:
        {
            if (theHorizontal) {
                break;
            }
            if (currentMonth==12) {
                currentMonth = 1;
                currentYear++;
            }else{
                currentMonth++;
            }
            [UIView transitionWithView:_collectionview duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
                
            } completion:nil];
        }
            break;
            
        default:
            break;
    }
    NSString *dateStg = [NSString stringWithFormat:@"%lu-%02lu-01 12:00:00",currentYear,currentMonth];
    NSLog(@"%lu-%lu",currentYear,currentMonth);
    NSDate *date = [DateObject dateForString:dateStg];
    [self getValue:date];

    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dayArray.count;
    
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CalerdarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CalerdarCell forIndexPath:indexPath];
    NSDictionary *dicInfo = dayArray[indexPath.row];
    [cell setContentInfo:dicInfo];
    
    CGPoint point = [collectionView convertPoint:CGPointZero fromView:cell];
    NSLog(@"point.x %f   point.y  %f",point.x,point.y);
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CalerdarCollectionViewCell *cell = (CalerdarCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSArray *arrayCell = collectionView.subviews;
    for (id vCell in arrayCell) {
        if ([vCell isKindOfClass:[CalerdarCollectionViewCell class]]) {
            CalerdarCollectionViewCell *defaultV = (CalerdarCollectionViewCell*)vCell;
            if (defaultV.value.backgroundColor != [UIColor redColor]) {
                defaultV.value.backgroundColor = [UIColor whiteColor];
            }
            
        }
    }
    [dayArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = (NSMutableDictionary*)obj;
        if ([dic objectForKey:@"hightGray"]) {
            [dic removeObjectForKey:@"hightGray"];
        }
    }];
    
    NSMutableDictionary *dic = dayArray[indexPath.row];
    [dic setObject:@"hightGray" forKey:@"hightGray"];
    [dayArray setObject:dic atIndexedSubscript:indexPath.row];
    if (cell.value.backgroundColor != [UIColor redColor]) {
        cell.value.backgroundColor = [UIColor grayColor];
    }
    NSLog(@"%@",[dic objectForKey:@"dateInfo"]);
}


+ (CGFloat)returnCalerdarviewHight
{
    NSInteger w =  [UIScreen mainScreen].bounds.size.width/7;
    NSInteger  Weeks = [LFCalendarValueInfo getHowManyWeekInMonth:[NSDate date]];

    return  (Weeks+1)*w+Weeks+7;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
