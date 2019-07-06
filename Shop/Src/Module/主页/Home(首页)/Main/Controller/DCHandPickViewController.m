//
//  DCHandPickViewController.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define NeedStartMargin 15   // 首列起始间距
#define NeedBtnHeight 33   // 按钮高度
#import "DCHandPickViewController.h"
#import "HQCollectionViewFlowLayout.h"
#import "HQTopStopView.h"
// Controllers
#import "CRDetailController.h"
#import "DCCommodityViewController.h"
#import "DRNewsVC.h"
#import "DRLocationVC.h"
#import "DRCuXiaoVC.h"
#import "DRTigetsVC.h"
#import "DRComeVC.h"
#import "DRHelpCenterVC.h"
#import "CGXPickerView.h"
#import "NewsModel.h"
#import "DRSameLookVC.h"
#import "DRShopListVC.h"
#import "CategoryDetailVC.h"
#import "MLSearchViewController.h"
//#import "DCGoodsSetViewController.h"
//#import "DCCommodityViewController.h"
//#import "DCMyTrolleyViewController.h"
//#import "DCGoodDetailViewController.h"
//#import "DCGMScanViewController.h"
// Models
#import "DCGridItem.h"
#import "DCRecommendItem.h"
#import "DRNullGoodModel.h"
#import "DRBigCategoryModel.h"
// Views
#import "DCNavSearchBarView.h"
#import "DCHomeTopToolView.h"
/* cell */
#import "DCGoodsCountDownCell.h" //倒计时商品
#import "DCNewWelfareCell.h"     //新人福利
#import "DCGoodsHandheldCell.h"  //掌上专享
#import "DCExceedApplianceCell.h"//不止
#import "DCGoodsYouLikeCell.h"   //猜你喜欢商品
#import "DCGoodsGridCell.h"      //10个选项
#import "DRNullGoodLikesCell.h"  //爆品牛商cell
/* head */
#import "DCSlideshowHeadView.h"  //轮播图
#import "DCCountDownHeadView.h"  //倒计时标语
#import "DCYouLikeHeadView.h"    //猜你喜欢等头部标语
/* foot */
#import "DRFooterView.h"
#import "DCTopLineFootView.h"    //热点
#import "DCOverFootView.h"       //结束
#import "DCScrollAdFootView.h"   //底滚动广告
#import "DRGuangGaoView.h"
// Vendors
#import "DCHomeRefreshGifHeader.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others
#import "CDDTopTip.h"
#import "NetworkUnit.h"
#import "DRNullMainVC.h"

@interface DCHandPickViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)DRNullGoodModel *nullGoodModel;
@property (nonatomic,strong)DRBigCategoryModel *bigCategoryModel;
@property (nonatomic,strong)NewsModel *newmodel;
@property (nonatomic,strong)NSMutableArray *bannerArr,*newsArr,*nullArr,*bottomBannerArr,* tipArr;
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSArray<DCRecommendItem *> *youLikeItem;
/* 顶部工具View */
@property (nonatomic, strong) DCHomeTopToolView *topToolView;
@property (nonatomic, strong) HQTopStopView *DRheaderView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;

@property (strong,nonatomic)NSArray *bigCartporyArr;
@property (strong,nonatomic)NSString *selectedID,*zyStoreIdStr;

@property (strong,nonatomic) NSDictionary *hotSearchDic;

@end
/* cell */
static NSString *const DCGoodsCountDownCellID = @"DCGoodsCountDownCell";
static NSString *const DCNewWelfareCellID = @"DCNewWelfareCell";
static NSString *const DCGoodsHandheldCellID = @"DCGoodsHandheldCell";
static NSString *const DCGoodsYouLikeCellID = @"DCGoodsYouLikeCell";
static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
static NSString *const DCExceedApplianceCellID = @"DCExceedApplianceCell";
static NSString *const DRNullGoodLikesCellCellID = @"DRNullGoodLikesCell";
/* head */
static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
static NSString *const DCCountDownHeadViewID = @"DCCountDownHeadView";
static NSString *const DCYouLikeHeadViewID = @"DCYouLikeHeadView";
/* foot */
static NSString *const DRFooterViewID = @"DRFooterView";
static NSString *const DCTopLineFootViewID = @"DCTopLineFootView";
static NSString *const DCOverFootViewID = @"DCOverFootView";
static NSString *const DCScrollAdFootViewID = @"DCScrollAdFootView";
static NSString *const DRGuangGaoFootViewID = @"DRGuangGaoView";

static NSString *const DRTopViewID = @"HQTopStopView";
@implementation DCHandPickViewController

#pragma mark - LazyLoad
-(NSDictionary *)hotSearchDic
{
    if (!_hotSearchDic) {
        _hotSearchDic =[NSDictionary dictionary];
    }
    return _hotSearchDic;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        HQCollectionViewFlowLayout *flowlayout = [[HQCollectionViewFlowLayout alloc] init];
        //设置悬停高度
        flowlayout.naviHeight = DRTopHeight;
//
        //左右间距
        flowlayout.minimumInteritemSpacing = 2;
        //上下间距
        flowlayout.minimumLineSpacing = 2;
//        flowlayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
//        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//        layout.sectionHeadersPinToVisibleBounds = YES;//头视图悬浮
    
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DRTabBarHeight);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        [_collectionView registerClass:[DCGoodsCountDownCell class] forCellWithReuseIdentifier:DCGoodsCountDownCellID];
        [_collectionView registerClass:[DCGoodsHandheldCell class] forCellWithReuseIdentifier:DCGoodsHandheldCellID];
        [_collectionView registerClass:[DCGoodsYouLikeCell class] forCellWithReuseIdentifier:DCGoodsYouLikeCellID];
        [_collectionView registerClass:[DCGoodsGridCell class] forCellWithReuseIdentifier:DCGoodsGridCellID];
        [_collectionView registerClass:[DCExceedApplianceCell class] forCellWithReuseIdentifier:DCExceedApplianceCellID];
        [_collectionView registerClass:[DCNewWelfareCell class] forCellWithReuseIdentifier:DCNewWelfareCellID];
         [_collectionView registerClass:[DRNullGoodLikesCell class] forCellWithReuseIdentifier:DRNullGoodLikesCellCellID];
        
         [_collectionView registerClass:[DRFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRFooterViewID];
        [_collectionView registerClass:[DCTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID];
        [_collectionView registerClass:[DCOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID];
        [_collectionView registerClass:[DCScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID];
        [_collectionView registerClass:[DCYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID];
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerClass:[DCCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCCountDownHeadViewID];
         [_collectionView registerClass:[DRGuangGaoView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRGuangGaoFootViewID];
        [_collectionView registerClass:[HQTopStopView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:DRTopViewID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.bigCartporyArr =@[@"12.9级/10.9级",@"螺栓",@"螺母",@"螺丝钉",@"螺丝帽",@"螺蛳粉",@"螺蛳肉"];
    [self setUpBase];
   
    [self setUpNavTopView];
   
    [self setUpGoodsData];
    
    [self setUpScrollToTopView];
    
    [self setUpGIFRrfresh];
    
    [self getNetwork];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"HQTopStopView" object:nil];
    
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}

- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"HQTopStopView"]) {
        NSDictionary *dic =notification.userInfo;
        NSString *tagStr=dic[@"tag"];
        
        self.selectedID =self.bigCartporyArr[[tagStr integerValue]][@"id"];
        [self getMobHomeBurstItemList];
        [self getHomeBigCategoryImg];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self loadLocation];
    [self setUpGoodsData];
//    [_collectionView.mj_header beginRefreshing];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)loadLocation
{
    if (![User currentUser].isLogin) {
        if (![DEFAULTS objectForKey:@"locationcode"]) {
            
            [CGXPickerView showAddressPickerWithTitle:@"请选择地区" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
                //NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
                self.topToolView.voiceButton.titleLabel.text =selectAddressArr[2];
                [DRBuyerModel sharedManager].location = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                [DRBuyerModel sharedManager].locationcode =[selectAddressArr lastObject];
               
                [DEFAULTS setObject:[NSString stringWithFormat:@"%@/%@/%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]] forKey:@"address"];
                [DEFAULTS setObject:[selectAddressArr lastObject] forKey:@"locationcode"];
                [DEFAULTS setObject:[selectAddressArr lastObject] forKey:@"code"];
                //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                    [_collectionView.mj_header beginRefreshing];
            }];
        }
        else
        {
            NSArray *codeArr =[[DEFAULTS objectForKey:@"locationcode"] componentsSeparatedByString:@"/"];
            [DRBuyerModel sharedManager].locationcode  = [codeArr lastObject];
            [DRBuyerModel sharedManager].location  = [DEFAULTS objectForKey:@"address"];
            NSArray *nameArr =[[DRBuyerModel sharedManager].location componentsSeparatedByString:@"/"];
            if (nameArr.count==3)
            {
                [_topToolView.voiceButton setTitle:[nameArr lastObject] forState:UIControlStateNormal];
            }
        }
    }else
    {
        NSArray *codeArr =[[DEFAULTS objectForKey:@"locationcode"] componentsSeparatedByString:@"/"];
        [DRBuyerModel sharedManager].locationcode  = [codeArr lastObject];
        [DRBuyerModel sharedManager].location  = [DEFAULTS objectForKey:@"address"];
        NSArray *nameArr =[[DRBuyerModel sharedManager].location componentsSeparatedByString:@"/"];
        if (nameArr.count==3)
        {
            [_topToolView.voiceButton setTitle:[nameArr lastObject] forState:UIControlStateNormal];
        }
    }
}
#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = BACKGROUNDCOLOR;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
}

#pragma mark - 获取网络
- (void)getNetwork
{
    if ([[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { //网络
        [CDDTopTip showTopTipWithMessage:@"您现在暂无可用网络"];
    }
}

#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    self.collectionView.mj_header = [DCHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
}

#pragma mark - 刷新
- (void)setUpRecData
{
    DRWeakSelf;
    [DCSpeedy dc_callFeedback]; //触动
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
        [self geToken];
        [weakSelf.collectionView.mj_header endRefreshing];
    });
}
-(void)geToken
{
    if ([User currentUser].isLogin) {
        // 获取用户信息
        [self setUpGoodsData];
    } else {
        // 以游客模式登录
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"ios", @"dGVzdA=="] forKeys:@[@"username", @"secret"]];
        
        //    if (areaCode) [dict setObject:areaCode forKey:@"area_code"];
        
        [SNIOTTool postvisiteTokenWithURL:GET_TOKEN parameters:dict success:^(SNResult *result) {
            NSString *visiteStr =result.data;
//            [User currentUser].visitetoken =visiteStr;
            [DEFAULTS setObject:visiteStr forKey:@"visitetoken"];
            [self setUpGoodsData];
        } failure:^(NSError *error) {
            
        }];
    }
}
#pragma mark - 加载数据
- (void)setUpGoodsData
{
    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
//    _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self GetNews];
    [self shoujixinwen];
    [self getburstmainPageList];
    [self getHomeBigCategoryList];
    [self systemSetting];
    [self setHotSearch];
}
-(void)systemSetting
{
    [SNAPI getWithURL:@"mainPage/systemSetting" parameters:nil success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
          self.zyStoreIdStr =result.data[@"zyStoreId"];
         
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)GetNews
{
    NSDictionary *dic =@{@"typeCode":@"mobileBanner",@"page":@"1",@"pageSize":@"10"};
    [SNAPI getWithURL:@"mainPage/news" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.bannerArr =[NSMutableArray array];
//             NSArray *sourceArr =result.data;
            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data];
            for (NewsModel *model in sourceArr) {
                [self.bannerArr addObject:model.imageurl];
            }
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)shoujixinwen
{
    NSDictionary *dic =@{@"typeCode":@"shoujixinwen",@"page":@"1",@"pageSize":@"10"};
    [SNAPI getWithURL:@"mainPage/news" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.newsArr =[NSMutableArray array];
            self.tipArr =[NSMutableArray array];
            //             NSArray *sourceArr =result.data;
            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data];
            for (NewsModel *model in sourceArr) {
//                [self.newsArr addObject:model.imageurl];
                [self.tipArr addObject:model.title];
            }
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)getburstmainPageList
{
    
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@""};
    [SNAPI getWithURL:@"burst/mainPageList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.nullArr =[NSMutableArray array];
            self.nullArr =[DRNullGoodModel mj_objectArrayWithKeyValuesArray:result.data];
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)getHomeBigCategoryList
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@""};
    [SNAPI getWithURL:@"burst/getHomeBigCategoryList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            
            self.bigCartporyArr =[NSMutableArray array];
            self.bigCartporyArr =result.data;
//         self.bigCartporyArr  =[self.bigCartporyArr subarrayWithRange:NSMakeRange(0, 2)];
            self.selectedID =[self.bigCartporyArr firstObject][@"id"];
            if (self.selectedID.length!=0) {
                
                [self getMobHomeBurstItemList];
                [self getHomeBigCategoryImg];
            }
        }
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)getMobHomeBurstItemList
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@"",@"bhtId":self.selectedID,@"pageNum":@"1",@"pageSize":@"10000"};
    [SNAPI getWithURL:@"burst/getMobHomeBurstItemList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {            
           _youLikeItem =[DCRecommendItem mj_objectArrayWithKeyValuesArray:result.data];
            [self.collectionView reloadData];
//            [self.collectionView performBatchUpdates:^{
//                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:8]];
//            } completion:nil];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)getHomeBigCategoryImg
{
    NSDictionary *dic =@{@"districtId":[DEFAULTS objectForKey:@"code"]?:@"",@"bhtId":self.selectedID};
    [SNAPI getWithURL:@"burst/getMobHomeBurstAdvList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.bottomBannerArr=[NSMutableArray array];
            for (NSDictionary *dic in result.data) {
                [self.bottomBannerArr addObject:dic[@"img"]];
            }
            [self.collectionView reloadData];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)setHotSearch
{
    DRWeakSelf;
    [SNAPI getWithURL:@"mainPage/hotSearch" parameters:nil success:^(SNResult *result) {
        weakSelf.hotSearchDic =result.data;
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 滚回顶部
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 80-DRTabBarHeight, 40, 40);
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[DCHomeTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, DRTopHeight)];
    DRWeakSelf;
    
   
    _topToolView.leftItemClickBlock = ^{
        //NSLog(@"点击了首页扫一扫");
//        DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
//        [weakSelf.navigationController pushViewController:dcGMvC animated:YES];
    };
    _topToolView.rightItemClickBlock = ^{

        //NSLog(@"点击了首页分类");
//        DCCommodityViewController *dcComVc = [DCCommodityViewController new];
//        [weakSelf.navigationController pushViewController:dcComVc animated:YES];
    };
    _topToolView.rightRItemClickBlock = ^{
        //NSLog(@"点击了首页购物车");
//        DCMyTrolleyViewController *shopCarVc = [DCMyTrolleyViewController new];
//        shopCarVc.isTabBar = YES;
//        shopCarVc.title = @"购物车";
//        [weakSelf.navigationController pushViewController:shopCarVc animated:YES];
    };
    
    _topToolView.searchButtonClickBlock = ^{
        //NSLog(@"点击了首页搜索");
        [self searchButtonClick];
    };
    _topToolView.voiceButtonClickBlock = ^{
        if (![User currentUser].isLogin) {
            [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
                //NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
                [DRBuyerModel sharedManager].location = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                [DRBuyerModel sharedManager].locationcode =[selectAddressArr lastObject];
                [DEFAULTS setObject:[NSString stringWithFormat:@"%@/%@/%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]] forKey:@"address"];
                [DEFAULTS setObject:[selectAddressArr lastObject] forKey:@"locationcode"];
                [DEFAULTS setObject:[selectAddressArr lastObject] forKey:@"code"];
                
                [weakSelf.topToolView.voiceButton setTitle:selectAddressArr[2] forState:UIControlStateNormal];
                  [_collectionView.mj_header beginRefreshing];
                //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
            }];
        }
        //NSLog(@"点击了首页语音");
    };
//    self.navigationItem.titleView  =_topToolView;
    [self.view addSubview:_topToolView];
}
#pragma mark - 搜索点击
- (void)searchButtonClick
{
    MLSearchViewController *vc = [[MLSearchViewController alloc] init];
    vc.hotSearchDic =self.hotSearchDic;

    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 9;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (section==0||section == 1 || section==3||section==4||section==7) {
//        return 0;
//    }
   
    if ( section==2) { //广告福利  倒计时  掌上专享
        return 1;
    }
    
    if (section==5) {
        return self.nullArr.count;
    }
    if (section == 8) { //猜你喜欢
       
//        if (_youLikeItem.count>8) {
//        _youLikeItem =[_youLikeItem subarrayWithRange:NSMakeRange(0, 8)];
//        }
        return _youLikeItem.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 1) {//碳钢专区
        DCNewWelfareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCNewWelfareCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    else if (indexPath.section == 2) {//工厂直营 item
        DCGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsCountDownCellID forIndexPath:indexPath];
        cell.btnItemBlock = ^(NSInteger btnTag) {
            [self selectedWithTag:btnTag];
        };
        gridcell = cell;
    }
//    else if (indexPath.section == 4) {//倒计时
//        DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
////        cell.gridItem = _gridItem[indexPath.row];
//        cell.backgroundColor = [UIColor whiteColor];
//        gridcell = cell;
//    }
    else if (indexPath.section == 5) {//倒计时
        self.nullGoodModel =self.nullArr[indexPath.row];
        DRNullGoodLikesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DRNullGoodLikesCellCellID forIndexPath:indexPath];
        cell.lookSameBlock = ^{
            //NSLog(@"点击了第%zd商品的找相似",indexPath.row);
            DRSameLookVC *sameLookVC = [[DRSameLookVC alloc]init];
             sameLookVC.nullGoodModel= self.nullArr[indexPath.row];
            [self.navigationController pushViewController:sameLookVC animated:YES];
        };
        cell.centerShopBtnBlock = ^{
            CRDetailController *detailVC = [CRDetailController new];
            self.nullGoodModel =self.nullArr[indexPath.row];
            detailVC.sellerid=self.nullGoodModel.sellerid;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        cell.sureBuyBtnBlock = ^{
            DRShopListVC * shopListVC =[[DRShopListVC alloc]init];
            shopListVC.nullGoodModel =self.nullArr[indexPath.row];
            [self.navigationController pushViewController:shopListVC animated:YES];
        };
        cell.nullGoodModel = self.nullGoodModel;
        gridcell = cell;
//        DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
//          cell.youLikeItem = _youLikeItem[indexPath.row];
//        //        cell.gridItem = _gridItem[indexPath.row];
//        cell.backgroundColor = [UIColor whiteColor];
//        gridcell = cell;
    }
    else if (indexPath.section == 7) {//掌上专享

//        DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
//         cell.youLikeItem = _youLikeItem[indexPath.row];
//        //        cell.gridItem = _gridItem[indexPath.row];
//        cell.backgroundColor = [UIColor whiteColor];
//        gridcell = cell;
////        DCExceedApplianceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCExceedApplianceCellID forIndexPath:indexPath];
////        cell.goodExceedArray = GoodsRecommendArray;
////        gridcell = cell;

    }
    else if (indexPath.section ==8) {//推荐
//        self.nullGoodModel =self.nullArr[indexPath.row];
        DRNullGoodLikesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DRNullGoodLikesCellCellID forIndexPath:indexPath];
        cell.youLikeItem = _youLikeItem[indexPath.row];
        cell.lookSameBlock = ^{
            //NSLog(@"点击了第%zd商品的找相似",indexPath.row);
            DRSameLookVC *sameLookVC = [[DRSameLookVC alloc]init];
            sameLookVC.nullGoodModel=(DRNullGoodModel*)self.youLikeItem[indexPath.row];
            [self.navigationController pushViewController:sameLookVC animated:YES];
        };
        cell.centerShopBtnBlock = ^{
            CRDetailController *detailVC = [CRDetailController new];
           
            detailVC.sellerid=self.youLikeItem[indexPath.row].sellerid;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        cell.sureBuyBtnBlock = ^{
            DRShopListVC * shopListVC =[[DRShopListVC alloc]init];
            shopListVC.nullGoodModel =(DRNullGoodModel*)self.youLikeItem[indexPath.row];
            [self.navigationController pushViewController:shopListVC animated:YES];
            
        };
//        cell.nullGoodModel = self.nullGoodModel;
        gridcell = cell;
//        DCGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsYouLikeCellID forIndexPath:indexPath];
//        cell.centerShopBtnBlock  = ^{
//            //NSLog(@"点击了第%zd商品的找进入店铺",indexPath.row);
//            CRDetailController *detailVC = [CRDetailController new];
//            [self.navigationController pushViewController:detailVC animated:YES];
//        };
//        cell.sureBuyBtnBlock  = ^{
//            //NSLog(@"立即购买=%zd",indexPath.row);
//
//        };
//        cell.lookSameBlock = ^{
//            //NSLog(@"点击了第%zd商品的找相似",indexPath.row);
//        };
////        cell.youLikeItem = _youLikeItem[indexPath.row];
//        gridcell = cell;
        
    }
    else {//猜你喜欢
        
        DCGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsHandheldCellID forIndexPath:indexPath];
        NSArray *images = GoodsHandheldImagesArray;
        cell.handheldImage = images[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
       

        if (indexPath.section ==8){
            self.DRheaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DRTopViewID forIndexPath:indexPath];
            self.DRheaderView.backgroundColor = [UIColor whiteColor];
            self.DRheaderView.bigCartporyArr =self.bigCartporyArr;
           
            DRWeakSelf;
            self.DRheaderView.SelectbuttonClickBlock= ^(NSInteger index) {
                weakSelf.selectedID =weakSelf.bigCartporyArr[index][@"id"];
                self.DRheaderView.selectIndex =index;
                [weakSelf getMobHomeBurstItemList];
                [weakSelf getHomeBigCategoryImg];
            };
            return self.DRheaderView;
        } else {
            HQTopStopView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            return headerView;
        }
    }
    if (kind == UICollectionElementKindSectionFooter)
    {
        
        if (indexPath.section == 0) {
            DCSlideshowHeadView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
            footerView.imageGroupArray = self.bannerArr.copy;
            footerView.ManageIndexBlock = ^(NSInteger ManageIndexBlock) {
            };
            return  footerView ;
        }
       else if (indexPath.section == 2) {
               DRGuangGaoView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DRGuangGaoFootViewID forIndexPath:indexPath];
           if (self.bannerArr.count>2) {
               
               footerView.imageGroupArray = [self.bannerArr subarrayWithRange:NSMakeRange(2, 1)].copy;
           }
               footerView.ManageIndexBlock = ^(NSInteger ManageIndexBlock) {
                   
               };
               return  footerView ;
         
        }
        else if (indexPath.section == 3) {
            DCTopLineFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID forIndexPath:indexPath];
            footerView.titleGroupArray =self.tipArr;
            footerView.ManageIndexBlock = ^(NSInteger ManageIndexBlock) {
                
            };
            footerView.allBlock = ^(NSInteger allDex) {
                DRNewsVC *newsVC =[[DRNewsVC alloc]init];
                [self.navigationController pushViewController:newsVC animated:YES];
            };
            return footerView;
        }
        else if (indexPath.section == 4){
            DCCountDownHeadView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCCountDownHeadViewID forIndexPath:indexPath];
            footerView.backgroundColor = BACKGROUNDCOLOR;
            [footerView.timeBtn setTitle:@"————  今日疯抢  ————" forState:UIControlStateNormal];
            footerView.timeBtn.titleLabel.font =DR_FONT(18);
            [footerView.timeBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
            return footerView;

        }
//
        
        else if (indexPath.section==5)
        {
//            DCCountDownHeadView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCCountDownHeadViewID forIndexPath:indexPath];
//            footview.backgroundColor = [UIColor whiteColor];
//            [footview.timeBtn setTitle:@"查看更多>" forState:UIControlStateNormal];
//            footview.timeBtn.titleLabel.font =DR_FONT(15);
//            footview.timeBtnBlock = ^{
//                DRNullMainVC *mainVC =[[DRNullMainVC alloc]init];
//                [self.navigationController pushViewController:mainVC animated:YES];
//            };
//            [footview.timeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            return footview;
        }
//        else if (indexPath.section == 6)
//        {
////            DCScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID forIndexPath:indexPath];
////            return footerView;
//
//
//        }
        else if (indexPath.section==6)
        {
            DCCountDownHeadView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCCountDownHeadViewID forIndexPath:indexPath];
            footview.backgroundColor = [UIColor whiteColor];
            [footview.timeBtn setTitle:@"————  活动专区  ————" forState:UIControlStateNormal];
            footview.timeBtn.titleLabel.font =DR_FONT(18);
            [footview.timeBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
            return footview;
        }
        else if (indexPath.section==7)
        {
            if (self.bottomBannerArr.count!=0) {
                
                DCScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID forIndexPath:indexPath];
                footerView.imageGroupArray = self.bottomBannerArr;
                return footerView;
            }
            
        }
       
        
    }
    return nil;
}
//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 1) {//广告
//        return CGSizeMake(ScreenW, ScreenW/4+10);
//    }
    if (indexPath.section == 2) {//9宫格组
        return CGSizeMake(ScreenW, 2*(ScreenW/5+DCMargin));
    }
    if (indexPath.section == 3) {//计时
        return CGSizeMake(ScreenW,  HScale(190));
    }
    if (indexPath.section == 4) {//掌上
        return CGSizeMake(ScreenW,  HScale(190));
    }
    if (indexPath.section == 5||indexPath.section == 8) {//掌上
        return CGSizeMake((ScreenW - 2)/2,  (ScreenW - 2)/2 + HScale(80)+ScreenW*0.13+HScale(20));
    }

    return CGSizeZero;
}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    if (indexPath.section == 5) {
//        if (indexPath.row == 0) {
//            layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.38);
//        }else if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
//            layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.24);
//        }else{
//            layoutAttributes.size = CGSizeMake(ScreenW * 0.25, ScreenW * 0.35);
//        }
//    }
//    return layoutAttributes;
//}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    if (section==2) {
        return CGSizeZero;
    }
    if (section==8) {
        //初始行_列的X、Y值设置
        float butX = NeedStartMargin;
        float butY =10;
        for(int i = 0; i < self.bigCartporyArr.count; i++){
            //宽度自适应计算宽度
            NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGRect frame_W = [self.bigCartporyArr[i][@"name"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
            //宽度计算得知当前行不够放置时换行计算累加Y值
            if (butX+frame_W.size.width+NeedStartMargin*2>SCREEN_WIDTH-NeedStartMargin) {
                butX = NeedStartMargin;
                butY += (NeedBtnHeight+12);//Y值累加，具体值请结合项目自身需求设置 （值 = 按钮高度+按钮间隙）
            }
            //设置计算好的位置数值
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+NeedStartMargin*2, NeedBtnHeight)];
            //设置内容
            [btn setTitle:self.bigCartporyArr[i][@"name"] forState:UIControlStateNormal];
           
            //添加事
        
            //一个按钮添加之后累加X值后续计算使用
            //NSLog(@"%f",CGRectGetMaxX(btn.frame));
            butX = CGRectGetMaxX(btn.frame)+15;
          
          
        }
        return CGSizeMake(ScreenW, butY+NeedBtnHeight+10); //图片滚动的宽高
    }
    return CGSizeZero;
}
#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        
        return CGSizeMake(ScreenW, 200); //图片滚动的宽高
    }
    if (section==2) {
        if (self.bannerArr.count>2) {
            
            return CGSizeMake(ScreenW, HScale(90));
        }
    }
    if (section == 3||section == 4||section == 6) {
        return CGSizeMake(ScreenW, HScale(40));  //Top头条的宽高
    }
    if (section==7) {
        if (self.bottomBannerArr.count==0) {
            return CGSizeMake(0,0);
        }
       return CGSizeMake(ScreenW, HScale(100));  //scroll
    }
//    if (section == 3) {
//        return CGSizeMake(ScreenW, 40); // 滚动广告
//    }
//    if (section == 5) {
//        return CGSizeMake(ScreenW, 40); // 结束
//    }
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10
        
//        DCGoodsSetViewController *goodSetVc = [[DCGoodsSetViewController alloc] init];
//        goodSetVc.goodPlisName = @"ClasiftyGoods.plist";
//        [self.navigationController pushViewController:goodSetVc animated:YES];
//        //NSLog(@"点击了10个属性第%zd",indexPath.row);
    }else if (indexPath.section == 5){
        //NSLog(@"点击了推荐的第%zd个商品",indexPath.row);
//        CRDetailController *detailVC = [CRDetailController new];
//        self.nullGoodModel =self.nullArr[indexPath.row];
//        detailVC.sellerid=self.nullGoodModel.sellerid;
//        [self.navigationController pushViewController:detailVC animated:YES];
        DRShopListVC * shopListVC =[[DRShopListVC alloc]init];
        shopListVC.nullGoodModel =self.nullArr[indexPath.row];
        [self.navigationController pushViewController:shopListVC animated:YES];
//        DCGoodDetailViewController *dcVc = [[DCGoodDetailViewController alloc] init];
//        dcVc.goodTitle = _youLikeItem[indexPath.row].main_title;
//        dcVc.goodPrice = _youLikeItem[indexPath.row].price;
//        dcVc.goodSubtitle = _youLikeItem[indexPath.row].goods_title;
//        dcVc.shufflingArray = _youLikeItem[indexPath.row].images;
//        dcVc.goodImageView = _youLikeItem[indexPath.row].image_url;
//
//        [self.navigationController pushViewController:dcVc animated:YES];
    }
    else if (indexPath.section==8)
    {
        DRShopListVC * shopListVC =[[DRShopListVC alloc]init];
        shopListVC.nullGoodModel =(DRNullGoodModel*)self.youLikeItem[indexPath.row];
        [self.navigationController pushViewController:shopListVC animated:YES];
//        CRDetailController *detailVC = [CRDetailController new];
//        detailVC.sellerid=self.youLikeItem[indexPath.row].sellerid;
//        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}
-(void)selectedWithTag:(NSInteger)tag
{
    switch (tag) {
        case 0:
        {
            self.tabBarController.selectedIndex =1;
            
        }
            break;
        case 1:
        {
            CRDetailController *detailVC = [CRDetailController new];
            detailVC.sellerid =self.zyStoreIdStr;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 2:
        {
            DCCommodityViewController *commandVC =[[DCCommodityViewController alloc]init];
            commandVC.statusStr =@"homePush";
            [self.navigationController pushViewController:commandVC animated:YES];
            
        }
            break;
        case 3:
        {
            DRLocationVC *locationVC =[[DRLocationVC alloc]init];
            locationVC.advType = @"000";
            locationVC.title =@"本地批发";
            locationVC.isHome =@"2";
            [self.navigationController pushViewController:locationVC animated:YES];
        }
            break;
        case 4:
        {
            DRCuXiaoVC *cuxiaoVC =[[DRCuXiaoVC alloc]init];
            [self.navigationController pushViewController:cuxiaoVC animated:YES];
        }
            break;
        case 5:
        {
            DRTigetsVC *tiketVC =[[DRTigetsVC alloc]init];
            [self.navigationController pushViewController:tiketVC animated:YES];
        }
            break;
        case 6:
        {
            DRComeVC *comeVC=[[DRComeVC alloc]init];
            [self.navigationController pushViewController:comeVC animated:YES];
        }
            break;
        case 7:
        {
            DRLocationVC *locationVC =[[DRLocationVC alloc]init];
             locationVC.advType = @"007";
            locationVC.type =@"1";
            locationVC.isHome =@"1";
            locationVC.title =@"永年市场";
            [self.navigationController pushViewController:locationVC animated:YES];
        }
            break;
        case 8:
        {
            DRLocationVC *locationVC =[[DRLocationVC alloc]init];
            locationVC.advType = @"008";
            locationVC.type =@"2";
            locationVC.isHome =@"1";
            locationVC.title =@"温州市场";
            [self.navigationController pushViewController:locationVC animated:YES];
        }
            break;
        case 9:
        {
            DRLocationVC *locationVC =[[DRLocationVC alloc]init];            
            locationVC.advType = @"006";
            locationVC.isHome =@"1";
            locationVC.type =@"3";
            locationVC.title =@"戴南市场";
            [self.navigationController pushViewController:locationVC animated:YES];
        }
            break;
        case 10:
        {
            CategoryDetailVC *goodSetVc =[[CategoryDetailVC alloc] init];
            goodSetVc.classListStr =@"";
            goodSetVc.czID =@"";
            goodSetVc.queryTypeStr =@"history";
            [self.navigationController pushViewController:goodSetVc animated:YES];
        }
            break;
        case 11:
        {
            DRHelpCenterVC *helpVC =[[DRHelpCenterVC alloc]init];
            [self.navigationController pushViewController:helpVC animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > DCNaviH) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
#pragma mark - 消息
- (void)messageItemClick
{

}
@end
