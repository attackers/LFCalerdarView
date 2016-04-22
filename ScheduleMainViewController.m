//
//  ScheduleMainViewController.m
//  LFCalendar
//
//  Created by lifu on 16/4/6.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import "ScheduleMainViewController.h"
#import "ScheduleViewController.h"
@interface ScheduleMainViewController ()

@end

@implementation ScheduleMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self addweekLabel];
    ScheduleViewController *scheduleVC = [ScheduleViewController new];
    scheduleVC.view.frame = CGRectMake(0, 34, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self addChildViewController:scheduleVC];
    [self.view addSubview:scheduleVC.view];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}
- (void)addweekLabel
{
    NSInteger w =  [UIScreen mainScreen].bounds.size.width/7;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w*7, 34)];

    for (int i = 0; i < 7; i++) {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(w*i, 0, w-1, CGRectGetHeight(view.frame))];
        weekLabel.textColor = [UIColor lightGrayColor];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.font = [UIFont systemFontOfSize:13];
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
        weekLabel.backgroundColor = [UIColor clearColor];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
       
        view.center = CGPointMake(self.view.center.x, view.center.y);
        [view addSubview:weekLabel];
    }
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
