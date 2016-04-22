//
//  CalerdarCollectionViewCell.h
//  LFCalendar
//
//  Created by lifu on 16/3/29.
//  Copyright © 2016年 lifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalerdarCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UILabel *actionInfo;
- (void)setContentInfo:(NSDictionary*)sender;
@end
