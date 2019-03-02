//
//  FSPageContentView2.h
//  Caipiao
//
//  Created by 解辉 on 2017/12/27.
//  Copyright © 2017年 mac01. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPageContentView2;

@protocol FSPageContentViewDelegate <NSObject>

@optional

/**
 FSPageContentView开始滑动
 
 @param contentView FSPageContentView
 */
- (void)FSContentViewWillBeginDragging:(FSPageContentView2 *)contentView;

/**
 FSPageContentView滑动调用
 
 @param contentView FSPageContentView
 @param startIndex 开始滑动页面索引
 @param endIndex 结束滑动页面索引
 @param progress 滑动进度
 */
- (void)FSContentViewDidScroll:(FSPageContentView2 *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress;

/**
 FSPageContentView结束滑动
 
 @param contentView FSPageContentView
 @param startIndex 开始滑动索引
 @param endIndex 结束滑动索引
 */
- (void)FSContenViewDidEndDecelerating:(FSPageContentView2 *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end

@interface FSPageContentView2 : UIView
/**
 对象方法创建FSPageContentView
 
 @param frame frame
 @param childVCs 子VC数组
 @param parentVC 父视图VC
 @param delegate delegate
 @return FSPageContentView
 */
- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC delegate:(id<FSPageContentViewDelegate>)delegate;

@property (nonatomic, weak) id<FSPageContentViewDelegate>delegate;

/**
 设置contentView当前展示的页面索引，默认为0
 */
@property (nonatomic, assign) NSInteger contentViewCurrentIndex;

@end
