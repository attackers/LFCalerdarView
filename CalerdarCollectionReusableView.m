//
//  CalerdarCollectionReusableView.m
//  LFCalendar
//
//  Created by lifu on 16/3/30.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import "CalerdarCollectionReusableView.h"

@implementation CalerdarCollectionReusableView

- (void)addContentView
{
    NSInteger w =  [UIScreen mainScreen].bounds.size.width/7;
    
    for (int i = 0; i < 7; i++) {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(w*i, 0, w , CGRectGetHeight(self.frame))];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
                weekLabel.text = @"日";
                break;
            case 1:
                weekLabel.text = @"一";
                break;
            case 2:
                weekLabel.text = @"二";
                break;
            case 3:
                weekLabel.text = @"三";
                break;
            case 4:
                weekLabel.text = @"四";
                break;
            case 5:
                weekLabel.text = @"五";
                break;
            case 6:
                weekLabel.text = @"六";
                break;
            default:
                break;
        }
        [self addSubview:weekLabel];
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
   
}

@end
