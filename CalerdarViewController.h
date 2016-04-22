//
//  CalerdarViewController.h
//  LFCalendar
//
//  Created by lifu on 16/3/29.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalerdarViewController;
@protocol CalerdarViewDelegate <NSObject>
- (void)changeDate:(NSString*)stg;
- (void)calerdarviewHight:(CGFloat)hight;
@end

@interface CalerdarViewController : UIViewController
@property (nonatomic,assign)id<CalerdarViewDelegate>delegate;
+ (CGFloat)returnCalerdarviewHight;
- (void)changeCollectionviewLayout:(BOOL)horizontal;
@end
