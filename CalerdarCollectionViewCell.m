//
//  CalerdarCollectionViewCell.m
//  LFCalendar
//
//  Created by lifu on 16/3/29.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import "CalerdarCollectionViewCell.h"
#import "DateObject.h"
@implementation CalerdarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.value.layer setCornerRadius:CGRectGetHeight(self.value.frame)/2];
    self.value.clipsToBounds = YES;
}
- (void)setContentInfo:(NSDictionary *)sender
{

    self.value.text = [sender objectForKey:@"day"];
    BOOL inMonth = [[sender objectForKey:@"currentMonth"] boolValue];
    if (!inMonth) {
        
        self.value.textColor = [UIColor lightGrayColor];
        
    }else{
        
        self.value.textColor = [UIColor blackColor];
    }
    NSString *dateStg = [[sender objectForKey:@"dateInfo"] componentsSeparatedByString:@" "][0];
    NSString *today = [[DateObject stringForDate:[NSDate date]] componentsSeparatedByString:@" "][0];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[cd] %@",today];
    if ([predicate evaluateWithObject:dateStg]) {
        self.value.backgroundColor = [UIColor redColor];
    }else{
        self.value.backgroundColor = [UIColor whiteColor];
        
    }
    
    if ([sender objectForKey:@"hightGray"]) {
        self.value.backgroundColor = [UIColor lightGrayColor];
    }

}

@end
