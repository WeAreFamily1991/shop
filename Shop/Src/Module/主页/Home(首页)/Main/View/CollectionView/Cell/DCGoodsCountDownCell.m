//
//  DCGoodsCountDownCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsCountDownCell.h"
#import "DCGridItem.h"
// Controllers
#import "DCGoodsGridCell.h"      //10个选项
#import <FWCycleScrollView/FWCycleScrollView-Swift.h>
// Models
#import "DCRecommendItem.h"
// Views
#import "DCGoodsSurplusCell.h"

// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCGoodsCountDownCell ()
@property (nonatomic, strong) UIScrollView          *scrollView;
///* collection */
//@property (strong , nonatomic)UICollectionView *collectionView;
///* 推荐商品数据 */
////@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *countDownItem;
///* 底部 */
//@property (strong , nonatomic)UIView *bottomLineView;
///* 10个属性 */
//@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
@end
//static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
//static NSString *const DCGoodsSurplusCellID = @"DCGoodsSurplusCell";

@implementation DCGoodsCountDownCell

#pragma mark - lazyload
//- (UICollectionView *)collectionView
//{
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
////        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
////        layout.minimumLineSpacing = 2;
////        layout.itemSize = CGSizeMake(self.dc_height * 0.65, self.dc_height * 0.9);
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        [self addSubview:_collectionView];
//        _collectionView.frame = self.bounds;
//        _collectionView.showsHorizontalScrollIndicator = NO;
////        _collectionView.pagingEnabled =YES;
////        //  让scrollView的超出试图的部分也显示出来
////        _collectionView.clipsToBounds = NO;
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//
//        [_collectionView registerClass:[DCGoodsSurplusCell class] forCellWithReuseIdentifier:DCGoodsSurplusCellID];
//    }
//    return _collectionView;
//}

//- (NSMutableArray<DCRecommendItem *> *)countDownItem
//{
//    if (!_countDownItem) {
//        _countDownItem = [NSMutableArray array];
//    }
//    return _countDownItem;
//}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = UIColor.clearColor;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [self addSubview:self.scrollView];
    /// 例八：仿直播间礼物列表
    FWCycleScrollView *cycleScrollView8 = [FWCycleScrollView cycleWithFrame:self.bounds loopTimes:1];
    cycleScrollView8.viewArray = [self setupCustomSubView:0];
    cycleScrollView8.backgroundColor =[UIColor redColor];
    cycleScrollView8.currentPageDotEnlargeTimes = 1.0;
    cycleScrollView8.customDotViewType = FWCustomDotViewTypeSolid;
    cycleScrollView8.pageDotColor = [UIColor grayColor];
    cycleScrollView8.currentPageDotColor = REDCOLOR;
    cycleScrollView8.pageControlDotSize = CGSizeMake(8, 8);
    cycleScrollView8.pageControlInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    cycleScrollView8.autoScroll = NO;
    [self.scrollView addSubview:cycleScrollView8];
    
}
- (UIView *)setupUIView3:(int)index frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];

    NSArray *titleArr=@[@"爆品牛商",@"三铁云仓",@"工厂直营",@"本地批发",@"促销专区",@"领券中心",@"卖家入驻",@"永年市场",@"温州市场",@"戴南市场",@"购买记录",@"帮助中心"];
    NSArray *imgArr =@[@"爆品2",@"云仓",@"工厂",@"本地",@"促销",@"领券2",@"sell-store",@"永年",@"温州",@"戴南",@"记录",@"帮助"];
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.backgroundColor =[UIColor whiteColor];
    titleBtn.frame =CGRectMake(0, 0, view.dc_width, view.dc_height-30);
    titleBtn.titleLabel.font = DR_FONT(14);
    titleBtn.tag =index;
//    titleBtn.backgroundColor =BLACKCOLOR;
    [titleBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [titleBtn setTitle:titleArr[index] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:imgArr[index]] forState:UIControlStateNormal];
    [titleBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:titleBtn];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"gift_%d",index%20]]];
//    imageView.backgroundColor =[UIColor redColor];
//    imageView.frame = CGRectMake(0, 0, view.dc_width, view.dc_width/2);
//    [view addSubview:imageView];
//    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, view.dc_width/2, view.dc_width, view.dc_height-view.dc_width/2-10)];
//    titleLab.text =[NSString stringWithFormat:@"%d", (index + 1)];
//    titleLab.font = DR_FONT(14);
//    titleLab.backgroundColor =[UIColor greenColor];
//    titleLab.textAlignment = NSTextAlignmentCenter;
//    [view addSubview:titleLab];
    return view;
}
-(void)titleBtnClick:(UIButton *)sender
{
    if (_btnItemBlock) {
        _btnItemBlock(sender.tag);
    }
    
}
- (UIView *)setupUIView4:(int)index frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    int tmpW = view.frame.size.width *0.5;
    int tmpH = view.frame.size.height *0.5;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((view.frame.size.width-tmpW)/2, (view.frame.size.height-tmpH)/2, tmpW, tmpH)];
    label.text = [NSString stringWithFormat:@"%d", (index + 1)];
    label.textColor = UIColor.whiteColor;
    label.backgroundColor = [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
    label.font = [UIFont systemFontOfSize:25.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.dc_width / 2;
    label.clipsToBounds = YES;
    [view addSubview:label];
    
    return view;
}

- (NSMutableArray *)setupCustomSubView:(int)subViewType
{
    int tmpX = 0;
    int tmpY = 0;
    
    int horizontalRow = 5;
    int verticalRow = 2;
    
    int tmpW = self.frame.size.width / horizontalRow;
    int tmpH = self.frame.size.width / 2 / verticalRow;
    
    UIView *viewContrainer = nil;
    NSMutableArray *customSubViewArray = [NSMutableArray array];
    
    for (int i=0; i<12; i++) {
        tmpX = (i % horizontalRow) * tmpW;
        if (i % (horizontalRow * verticalRow) < horizontalRow) {
            tmpY = DCMargin;
        } else {
            tmpY = tmpH*0.8+DCMargin;
        }
        
        if (viewContrainer == nil || (i % (horizontalRow * verticalRow) == 0)) {
            viewContrainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width /2 + 30)];
            viewContrainer.backgroundColor = UIColor.whiteColor;
            [customSubViewArray addObject:viewContrainer];
        }
        
        if (subViewType == 0) {
            [viewContrainer addSubview:[self setupUIView3:i frame:CGRectMake(tmpX, tmpY, tmpW, tmpH)]];
        } else {
            [viewContrainer addSubview:[self setupUIView4:i frame:CGRectMake(tmpX, tmpY, tmpW, tmpH)]];
        }
    }
    return customSubViewArray;
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>

@end
