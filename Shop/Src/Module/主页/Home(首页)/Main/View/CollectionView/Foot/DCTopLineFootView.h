//
//  DCTopLineFootView.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCTopLineFootView : UICollectionReusableView
/* 轮播图数组 */
@property (copy , nonatomic)NSArray *titleGroupArray;
@property (copy,nonatomic) void (^ManageIndexBlock) (NSInteger ManageIndexBlock);
@end
