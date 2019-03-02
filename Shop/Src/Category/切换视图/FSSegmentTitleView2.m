//
//  FSSegmentTitleView2.m
//  Caipiao
//
//  Created by 解辉 on 2017/12/27.
//  Copyright © 2017年 mac01. All rights reserved.
//

#import "FSSegmentTitleView2.h"

#define HX_FONT(__fontsize__) [UIFont systemFontOfSize:__fontsize__]
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度
#define ScaleH screenWidth/375
#define ScaleW screenWidth/375
#define HScale(v) v / 667. * kWindowH //高度比
#define WScale(w) w / 375. * kWindowW //宽度比
#define CatColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface FSSegmentTitleView2 ()



@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray<UIButton *> *itemBtnArr;

///2:大神推单
@property (nonatomic, assign) FSIndicatorType indicatorType;

@end

@implementation FSSegmentTitleView2

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<FSSegmentTitleViewDelegate>)delegate indicatorType:(FSIndicatorType)incatorType
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = delegate;
        self.indicatorType = incatorType;
        [self initWithProperty];
    }
    return self;
}
//初始化默认属性值
- (void)initWithProperty
{
    self.itemMargin = 30*ScaleW;
    self.selectIndex = 0;
    self.titleNormalColor = [UIColor blackColor];
    self.titleSelectColor = CatColor(121, 223, 202, 1);
  //  self.titleFont = HX_FONT(14);
   // self.indicatorColor = self.titleSelectColor;
    self.indicatorExtension = 5.f;
}
//重新布局frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    if (self.itemBtnArr.count == 0)
    {
        return;
    }
    CGFloat totalBtnWidth = 0.0;
    for (NSString *title in self.titlesArr)
    {
        CGFloat itemBtnWidth = [FSSegmentTitleView2 getWidthWithString:title font:_titleFont] + self.itemMargin;
        totalBtnWidth += itemBtnWidth;
    }
    if (totalBtnWidth <= CGRectGetWidth(self.bounds))
    {//不能滑动
        CGFloat itemBtnWidth = CGRectGetWidth(self.bounds)/self.itemBtnArr.count;
        CGFloat itemBtnHeight = CGRectGetHeight(self.bounds);
        [self.itemBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.frame = CGRectMake(idx * itemBtnWidth, 0, itemBtnWidth, itemBtnHeight);
        }];
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.scrollView.bounds));
    }else{//超出屏幕 可以滑动
        CGFloat currentX = 0;
        for (int idx = 0; idx < self.titlesArr.count; idx++) {
            UIButton *btn = self.itemBtnArr[idx];
            CGFloat itemBtnWidth = [FSSegmentTitleView2 getWidthWithString:self.titlesArr[idx] font:_titleFont] + self.itemMargin;
            CGFloat itemBtnHeight = CGRectGetHeight(self.bounds);
            btn.frame = CGRectMake(currentX, 0, itemBtnWidth, itemBtnHeight);
            currentX += itemBtnWidth;
        }
        self.scrollView.contentSize = CGSizeMake(currentX, CGRectGetHeight(self.scrollView.bounds));
    }
    [self moveIndicatorView:NO];
}

- (void)moveIndicatorView:(BOOL)animated
{
    UIButton *selectBtn = self.itemBtnArr[self.selectIndex];
    CGFloat indicatorWidth = [FSSegmentTitleView2 getWidthWithString:self.titlesArr[self.selectIndex] font:_titleFont];
    [UIView animateWithDuration:(animated?0.3:0) animations:^{
        switch (_indicatorType)
        {
            case FSIndicatorTypeDefault:
                
                self.indicatorView.center = CGPointMake(selectBtn.center.x,WScale(40)-2);
                self.indicatorView.bounds = _button_Width>0 ?(CGRectMake(0, 0,_button_Width,2)):(CGRectMake(0, 0,7, 4));
                if (_indicatorType == 2) {
                    self.indicatorView.bounds = CGRectMake(0, 0,14,2);
                }
                break;
            case FSIndicatorTypeEqualTitle:
                self.indicatorView.center = CGPointMake(selectBtn.center.x, CGRectGetHeight(self.scrollView.bounds) - 2);
                self.indicatorView.bounds = _button_Width>0 ?(CGRectMake(0, 0,_button_Width, 1.5)):(CGRectMake(0, 0,7, 4));
                if (_indicatorType == 2) {
                    self.indicatorView.bounds = CGRectMake(0, 0,14,2);
                }
                break;
            case FSIndicatorTypeCustom:
                self.indicatorView.center = CGPointMake(selectBtn.center.x, CGRectGetHeight(self.scrollView.bounds) - 2);
                self.indicatorView.bounds = _button_Width>0 ?(CGRectMake(0, 0,_button_Width, 1.5)):(CGRectMake(0, 0,7, 4));
                if (_indicatorType == 2) {
                    
                    self.indicatorView.bounds = CGRectMake(0, 0,14,2);
                }
                break;
            case FSIndicatorTypeNone:
                self.indicatorView.frame = CGRectZero;
                break;
            default:
                break;
        }

    } completion:^(BOOL finished) {
        [self scrollSelectBtnCenter:animated];
    }];
}

- (void)scrollSelectBtnCenter:(BOOL)animated
{
    UIButton *selectBtn = self.itemBtnArr[self.selectIndex];
    CGRect centerRect = CGRectMake(selectBtn.center.x - CGRectGetWidth(self.scrollView.bounds)/2, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    [self.scrollView scrollRectToVisible:centerRect animated:animated];
}

#pragma mark --LazyLoad

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSMutableArray<UIButton *>*)itemBtnArr
{
    if (!_itemBtnArr) {
        _itemBtnArr = [[NSMutableArray alloc]init];
    }
    return _itemBtnArr;
}

- (UIImageView *)indicatorView
{
    if (!_indicatorView)
    {
        if (self.indicatorType == 2) {
           _indicatorView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,14,2)];
        }
        else
        {
           _indicatorView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 7, 4)];
        }
        
        [self.scrollView addSubview:_indicatorView];
    }
    return _indicatorView;
}

#pragma mark --Setter

- (void)setTitlesArr:(NSArray *)titlesArr
{
    _titlesArr = titlesArr;
    [self.itemBtnArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtnArr = nil;
    for (NSString *title in titlesArr) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = self.itemBtnArr.count + 666;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = _titleFont;
        [self.scrollView addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (self.itemBtnArr.count == self.selectIndex)
        {
            btn.selected = YES;
            btn.titleLabel.font = _titleFont;
        }
        [self.itemBtnArr addObject:btn];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setIndicatorImage:(NSString *)indicatorImage
{
    _indicatorImage = indicatorImage;
    self.indicatorView.image = [UIImage imageNamed:indicatorImage];
}

- (void)setItemMargin:(CGFloat)itemMargin
{
    _itemMargin = itemMargin;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if ([_identify isEqualToString:@"zhibo"])
    {
        if (selectIndex == 2 || selectIndex == 3) {
            
            return;
        }
        else
        {
            if (_selectIndex == selectIndex||_selectIndex < 0||_selectIndex > self.itemBtnArr.count - 1) {
                return;
            }
            UIButton *lastBtn = [self.scrollView viewWithTag:_selectIndex + 666];
            lastBtn.selected = NO;
            lastBtn.titleLabel.font = _titleFont;
            _selectIndex = selectIndex;
            UIButton *currentBtn = [self.scrollView viewWithTag:_selectIndex + 666];
            currentBtn.selected = YES;
            currentBtn.titleLabel.font = _titleFont;
            [self moveIndicatorView:NO];
        }
    }
    else
    {
        if (_selectIndex == selectIndex||_selectIndex < 0||_selectIndex > self.itemBtnArr.count - 1) {
            return;
        }
        UIButton *lastBtn = [self.scrollView viewWithTag:_selectIndex + 666];
        lastBtn.selected = NO;
        lastBtn.titleLabel.font = _titleFont;
        _selectIndex = selectIndex;
        UIButton *currentBtn = [self.scrollView viewWithTag:_selectIndex + 666];
        currentBtn.selected = YES;
        currentBtn.titleLabel.font = _titleFont;
        [self moveIndicatorView:NO];
    }
    
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    for (UIButton *btn in self.itemBtnArr) {
        btn.titleLabel.font = titleFont;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    
    for (UIButton *btn in self.itemBtnArr)
    {
        [btn setTitleColor:titleNormalColor forState:UIControlStateNormal];
    }
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor
{
    _titleSelectColor = titleSelectColor;
    
    for (UIButton *btn in self.itemBtnArr)
    {
        [btn setTitleColor:titleSelectColor forState:UIControlStateSelected];
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    self.indicatorView.backgroundColor = indicatorColor;
}

- (void)setIndicatorExtension:(CGFloat)indicatorExtension
{
    _indicatorExtension = indicatorExtension;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark --Btn

- (void)btnClick:(UIButton *)btn
{
    NSInteger index = btn.tag - 666;
    if ([_identify isEqualToString:@"zhibo"]) {
        
        if (index == 2 || index == 3)
        {
            if (_selectTypeBlock) {
                
                _selectTypeBlock(index);
            }
        }
        if (self.delegate&&[self.delegate respondsToSelector:@selector(FSSegmentTitleView:startIndex:endIndex:)]){
            [self.delegate FSSegmentTitleView:self startIndex:self.selectIndex endIndex:index];
        }
        self.selectIndex = index;
    }
    else
    {
        if (index == self.selectIndex)
        {
            return;
        }
        if (self.delegate&&[self.delegate respondsToSelector:@selector(FSSegmentTitleView:startIndex:endIndex:)]){
            [self.delegate FSSegmentTitleView:self startIndex:self.selectIndex endIndex:index];
        }
        self.selectIndex = index;
    }
}
#pragma mark Private
/**
 计算字符串长度
 
 @param string string
 @param font font
 @return 字符串长度
 */
+ (CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : HX_FONT(14)};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}

/**
 随机色
 
 @return 调试用
 */
+ (UIColor*) randomColor{
    NSInteger r = arc4random() % 255;
    NSInteger g = arc4random() % 255;
    NSInteger b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}


@end
