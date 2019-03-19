//
//  DCTopLineFootView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCTopLineFootView.h"

// Controllers
#import "DCZuoWenRightButton.h"
// Models

// Views
#import "DCTitleRolling.h"
// Vendors

// Categories
#import <UIImageView+WebCache.h>
// Others

@interface DCTopLineFootView ()<UIScrollViewDelegate,CDDRollingDelegate>

/* 滚动 */
@property (strong , nonatomic)DCTitleRolling *numericalScrollView;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;
/* 头部 */
@property (strong , nonatomic)UIView *headLineView;
/* 顶部广告宣传图片 */
@property (strong , nonatomic)UIImageView *topAdImageView;
/* 好货秒抢 */
@property (strong , nonatomic)DCZuoWenRightButton *quickButton;
@end

@implementation DCTopLineFootView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        [self setUpBase];
        
    }
    return self;
}

- (void)setUpUI
{
    
//    _topAdImageView = [[UIImageView alloc] init];
//    [_topAdImageView sd_setImageWithURL:[NSURL URLWithString:HomeBottomViewGIFImage]];
//    _topAdImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:_topAdImageView];

    //初始化
    _numericalScrollView = [[DCTitleRolling alloc] initWithFrame:CGRectMake(0, self.dc_height - 40, self.dc_width, 40) WithTitleData:^(CDDRollingGroupStyle *rollingGroupStyle, NSString *__autoreleasing *leftImage, NSArray *__autoreleasing *rolTitles, NSArray *__autoreleasing *rolTags, NSArray *__autoreleasing *rightImages, NSString *__autoreleasing *rightbuttonTitle, NSInteger *interval, float *rollingTime, NSInteger *titleFont, UIColor *__autoreleasing *titleColor, BOOL *isShowTagBorder) {
        
        *rollingTime = 0.25;
//        *rolTags = @[@"冬季健康日",@"新手上路",@"年终内购会",@"GitHub星星走一波"];
        *rolTitles = @[@"先领券在购物，一元抢？",@"2000元热门手机推荐",@"好奇么？点进去哈",@"这套家具比房子还贵"];
        *leftImage = @"news_ico";
        *interval = 6.0;
        *titleFont = 14;
        *isShowTagBorder = YES;
        *titleColor = [UIColor darkGrayColor];
    }];
    
    _numericalScrollView.moreClickBlock = ^{
        NSLog(@"mall----more");
    };
    [_numericalScrollView dc_beginRolling];
    _numericalScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_numericalScrollView];
    
    _headLineView = [[UIView alloc] init];
    _headLineView.backgroundColor = BACKGROUNDCOLOR;
    [self addSubview:_headLineView];
    _headLineView.frame = CGRectMake(0, self.dc_height-41, ScreenW, 1);

    _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = DR_FONT(12);
    [_quickButton setImage:[UIImage imageNamed:@"right_ico"] forState:UIControlStateNormal];
    _quickButton.frame =CGRectMake(ScreenW-WScale(65), self.dc_height-40, WScale(50), 40);
    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_quickButton setTitle:@"全部" forState:UIControlStateNormal];
    [self addSubview:_quickButton];
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = BACKGROUNDCOLOR;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.dc_height - 1, ScreenW, 1);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    [_topAdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self);
//        make.top.mas_equalTo(self);
//        make.width.mas_equalTo(self);
//        [make.bottom.mas_equalTo(self)setOffset:-50];
//    }];
}

- (void)setUpBase
{
    self.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - Setter Getter Methods

#pragma mark - 滚动条点击事件

- (void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%zd头条滚动条",index);
}

@end
