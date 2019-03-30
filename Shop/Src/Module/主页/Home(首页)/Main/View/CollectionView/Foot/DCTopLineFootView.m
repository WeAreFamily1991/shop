

//
//  DCSlideshowHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCTopLineFootView.h"

// Controllers

// Models
#import "NewsModel.h"
// Views

// Vendors
#import <SDCycleScrollView.h>

// Categories

// Others

@interface DCTopLineFootView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;

@property (strong , nonatomic)NSMutableArray *tipArr;

@property (strong , nonatomic)UIButton *quickButton;
@end

@implementation DCTopLineFootView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        [self setsource];
    }
    return self;
}


- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *iconImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"news_ico"]];
    iconImg.frame =CGRectMake(10, self.dc_height/3, self.dc_height/3,self.dc_height/3);
    [self addSubview:iconImg];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(iconImg.dc_right, 0, ScreenW-WScale(80), self.dc_height) delegate:self placeholderImage:nil];
    _cycleScrollView.titleLabelBackgroundColor =[UIColor whiteColor];
     _cycleScrollView.titleLabelTextColor =[UIColor blackColor];
    _cycleScrollView.titleLabelTextFont =DR_FONT(14);
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    _cycleScrollView.onlyDisplayText = YES;
//    _cycleScrollView.pageDotImage =[UIImage imageNamed:@"news_ico"];
    [self addSubview:_cycleScrollView];
    self.quickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quickButton.titleLabel.font = DR_FONT(12);
    [self.quickButton setImage:[UIImage imageNamed:@"right_ico"] forState:UIControlStateNormal];
    self.quickButton.frame =CGRectMake(ScreenW-WScale(65), self.dc_height-40, WScale(50), 40);
    [self.quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.quickButton setTitle:@"全部" forState:UIControlStateNormal];
    [self.quickButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [self addSubview:self.quickButton];
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, self.dc_height-1, ScreenW, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview: lineView];
}
- (void)setsource
{
    DRWeakSelf;
    NSDictionary *mudic =@{@"typeCode":@"xinwengonggao",@"page":@"1",@"pageSize":@"10"};
    [SNIOTTool getWithURL:@"mainPage/news" parameters:[mudic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            
            self.tipArr =[NSMutableArray array];
            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data];
            for (NewsModel *model in sourceArr) {
                [weakSelf.tipArr addObject:model.title];
            }
  
            if (weakSelf.tipArr.count == 0) return;
           weakSelf.cycleScrollView.titlesGroup = weakSelf.tipArr;
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
    if (_ManageIndexBlock) {
        _ManageIndexBlock(index);
    }
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods


@end
