//
//  ScheduleViewController.m
//  LFCalendar
//
//  Created by lifu on 16/4/5.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import "ScheduleViewController.h"
#import "CalerdarViewController.h"
static NSString *const defaultCell = @"defaultCell";
#define itemWidth (NSInteger)[UIScreen mainScreen].bounds.size.width/7

@interface ScheduleViewController ()<UITableViewDelegate,UITableViewDataSource,CalerdarViewDelegate>
{
    UITableView *_tableview;
    CalerdarViewController *calerdarview;
    UIView *calerbackView;
}
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.translucent = NO;
    calerdarview = [[CalerdarViewController alloc]init];
    CGFloat hight = [CalerdarViewController returnCalerdarviewHight];
    calerdarview.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    calerdarview.delegate = self;
    calerdarview.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:calerdarview];
    [self.view addSubview:calerdarview.view];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, hight-itemWidth-7, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - hight) style:UITableViewStylePlain];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:defaultCell];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
    [self.view addSubview:_tableview];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 13;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 13)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return lineView;
    
    
}
- (void)changeDate:(NSString *)stg
{
    
}
- (void)calerdarviewHight:(CGFloat)hight
{
    calerdarview.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), hight);
    [_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    CGRect rect = _tableview.frame;
    rect.origin.y = hight - itemWidth - 7;
    _tableview.frame = rect;
    
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint *point = targetContentOffset;
    NSLog(@"velocity y = %f  targetcontentoffset y %f",velocity.y,point->y);
    if (velocity.y>0.1) {
        [calerdarview changeCollectionviewLayout:YES];
    }else{
        [calerdarview changeCollectionviewLayout:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
