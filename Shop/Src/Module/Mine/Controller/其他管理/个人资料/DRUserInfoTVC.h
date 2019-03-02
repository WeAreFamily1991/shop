//
//  DRUserInfoTVC.h
//  Shop
//
//  Created by 解辉 on 2019/3/2.
//  Copyright © 2019年 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRUserInfoModel;

@interface DRUserInfoTVC : UITableViewController

@property (nonatomic, strong) DRUserInfoModel *user;

@property (nonatomic, copy) void (^changeInfo)();

@end
