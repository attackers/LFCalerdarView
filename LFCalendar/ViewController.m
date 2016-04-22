//
//  ViewController.m
//  LFCalendar
//
//  Created by lifu on 16/3/29.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import "ViewController.h"
#import "CalerdarViewController.h"
#import "ScheduleMainViewController.h"
@interface ViewController ()<CalerdarViewDelegate>
{
    UILabel *titleLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(00, 400, CGRectGetWidth(self.view.frame), 20)];
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
  

    
}
- (IBAction)pushview:(id)sender {
    
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Schedule" bundle:nil];
    ScheduleMainViewController *vc = [story instantiateViewControllerWithIdentifier:@"ScheduleMain"];
    
    
//    ScheduleViewController *cView = [[ScheduleViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)changeDate:(NSString *)stg
{
    titleLabel.text = stg;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
