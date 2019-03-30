//
//  HQTopStopView.h
//  HQCollectionViewDemo
//
//  Created by Mr_Han on 2018/10/10.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
// 

#import <UIKit/UIKit.h>
#import "SYMoreButtonView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HQTopStopView : UICollectionReusableView
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong)UIButton *buttonBtn;
@property (nonatomic,strong)SYMoreButtonView *bottomBtnView;

@property (nonatomic,assign)NSInteger selectIndex;
@end

NS_ASSUME_NONNULL_END
