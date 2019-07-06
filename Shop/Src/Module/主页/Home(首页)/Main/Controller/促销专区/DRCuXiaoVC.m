//
//  DCHandPickViewController.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DRCuXiaoVC.h"
#import "HQCollectionViewFlowLayout.h"
#import "CategoryDetailVC.h"
// Models
#import "DCGridItem.h"
#import "DCRecommendItem.h"
// Views
#import "DCNavSearchBarView.h"
#import "DCHomeTopToolView.h"
/* cell */
#import "DRCuxiaoCell.h"  //爆品牛商cell
/* head */
#import "DRCuXiaoHeaderView.h"  //倒计时标语
/* foot */
//#import "DRFooterView.h"
//#import "DCTopLineFootView.h"    //热点
//#import "DCOverFootView.h"       //结束
//#import "DCScrollAdFootView.h"   //底滚动广告
//#import "DRGuangGaoView.h"
// Vendors
#import "DCHomeRefreshGifHeader.h"
#import <MJExtension.h>
#import "DOPDropDownMenu.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others
#import "CDDTopTip.h"
#import "NetworkUnit.h"
#import "DRCuXiaoModel.h"

@interface DRCuXiaoVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>



/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSArray<DCRecommendItem *> *youLikeItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSArray<DRCuXiaoModel *> *cuxiaoArr;
///* 顶部工具View */
//@property (nonatomic, strong) DCHomeTopToolView *topToolView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;

@property (nonatomic, strong) NSMutableArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSMutableArray *areas;
@property (nonatomic, strong) NSMutableDictionary *sendDic;


@property (nonatomic, strong) NSMutableArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@property (nonatomic, weak) DOPDropDownMenu *menuB;

@end
/* cell */
static NSString *const DRCuxiaoCellID = @"DRCuxiaoCell";
/* head */
static NSString *const DRCuXiaoHeaderViewID = @"DRCuXiaoHeaderView";


@implementation DRCuXiaoVC

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        HQCollectionViewFlowLayout *flowlayout = [[HQCollectionViewFlowLayout alloc] init];
        //设置悬停高度
        flowlayout.naviHeight = 0;
        //
        //左右间距
        flowlayout.minimumInteritemSpacing = 1;
        //上下间距
        flowlayout.minimumLineSpacing = 1;
        flowlayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        //        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        //        layout.sectionHeadersPinToVisibleBounds = YES;//头视图悬浮
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, HScale(40), ScreenW, ScreenH-DRTopHeight);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        _collectionView.panGestureRecognizer.delaysTouchesBegan = _collectionView.delaysContentTouches;
        [_collectionView registerClass:[DRCuxiaoCell class] forCellWithReuseIdentifier:DRCuxiaoCellID];
        
        
        [_collectionView registerClass:[DRCuXiaoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DRCuXiaoHeaderViewID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"促销专区";
    [self GETheaderView];
    [self setUpBase];
    [self setUpGoodsData];
    [self setUpScrollToTopView];
    [self setUpGIFRrfresh];
    [self getNetwork];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewContenInset) name:@"kSetTableViewContentInsetNSNotification" object:nil];
}

-(void)GETheaderView
{
//    self.classifys = @[@"美食",@"今日新单",@"电影",@"酒店"];
    self.sendDic =[NSMutableDictionary dictionary];
    self.cates = @[@"自助餐",@"快餐",@"火锅",@"日韩料理",@"西餐",@"烧烤小吃"];
    self.movices = @[@"内地剧",@"港台剧",@"英美剧"];
    self.hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店"];
    NSDictionary *dic =@{@"name":@"材质",@"code":@"",@"id":@""};
    self.classifys =[NSMutableArray array];
    [self.classifys addObject:dic];
   
    NSDictionary *bigdic =@{@"name":@"大类",@"code":@"",@"id":@""};
    self.areas =[NSMutableArray array];
    [self.areas addObject:bigdic];
    NSDictionary *smalldic =@{@"name":@"小类",@"code":@"",@"id":@""};
    self.sorts =[NSMutableArray array];
    [self.sorts addObject:smalldic];
  
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:HScale(40)];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    //当下拉菜单收回时的回调，用于网络请求新的数据
    _menu.finishedBlock=^(DOPIndexPath *indexPath){
        if (indexPath.item >= 0) {
            NSLog(@"收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
        }else {
            NSLog(@"收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        }
    };
    //     创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    //    [menu selectDefalutIndexPath];
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
}
- (void)menuReloadData
{
//    self.classifys = @[@"美食",@"今日新单",@"电影"];
    [_menu reloadData];
}
#pragma DOPDropDownMenuDelegate
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1){
        return self.areas.count;
    }else {
        return self.sorts.count;
    }
}
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath
{
        if (indexPath.column == 0 || indexPath.column == 1) {
            return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.row];
        }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
        if (indexPath.column == 0 && indexPath.item >= 0) {
            return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.item];
        }
    return nil;
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath
{
        if (indexPath.column < 2) {
            return [@(arc4random()%1000) stringValue];
        }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return [@(arc4random()%1000) stringValue];
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
//        if (column == 0) {
//            if (row == 0) {
//               return self.cates.count;
//            } else if (row == 2){
//                return self.movices.count;
//            } else if (row == 3){
//                return self.hostels.count;
//            }
//        }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
//        if (indexPath.column == 0) {
//            if (indexPath.row == 0) {
//                return self.cates[indexPath.item];
//            } else if (indexPath.row == 2){
//                return self.movices[indexPath.item];
//            } else if (indexPath.row == 3){
//                return self.hostels[indexPath.item];
//            }
//        }
    return nil;
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.classifys[indexPath.row][@"name"];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row][@"name"];
    } else {
        return self.sorts[indexPath.row][@"name"];
    }
}
- (NSIndexPath *)menu:(DOPDropDownMenu *)menu willSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"将要点击 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"将要点击 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
    if (indexPath.item > 0) {
        return [NSIndexPath indexPathForRow:indexPath.item inSection:0];
    } else {
        return [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.column];
    }
}
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        if (indexPath.column==0) {
            [self.sendDic setObject:self.classifys[indexPath.row][@"id"] forKey:@"cz"];
             [self promotionCategory];
        }else if (indexPath.column==1)
        {
            self.sorts =[NSMutableArray array];
             NSDictionary *smalldic =@{@"name":@"小类",@"code":@"",@"id":@""};
            [self.sorts addObject:smalldic];
            NSArray *array =self.areas[indexPath.row][@"childCategory2"];
            for (NSDictionary *dic in array) {
                [self.sorts addObject:dic];
            }
            
        }else
        {
             [self.sendDic setObject:self.sorts[indexPath.row][@"id"] forKey:@"id"];
            [self getPromotion];
        }
    }
}
-(void)getPromotion
{
    
    NSDictionary *dic =@{@"cz":self.sendDic[@"cz"]?:@"",@"district":[DRBuyerModel sharedManager].locationcode,@"id":self.sendDic[@"id"]?:@""};
    [SNAPI getWithURL:@"mainPage/getPromotion" parameters:dic.mutableCopy success:^(SNResult *result) {
        _cuxiaoArr =[DRCuXiaoModel mj_objectArrayWithKeyValuesArray:result.data];
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)setTableViewContenInset {
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//    [self.collectionView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"location =%@",[DRBuyerModel sharedManager].locationcode);
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
        [self setUpGoodsData];
        [weakSelf.collectionView.mj_header endRefreshing];
    });
}

#pragma mark - 加载数据
- (void)setUpGoodsData
{
    [self getCZList];
    [self getPromotion];
//    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
//    _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
}
-(void)getCZList
{
    [SNAPI getWithURL:@"mainPage/getCzList" parameters:nil success:^(SNResult *result) {
        self.classifys =[NSMutableArray array];
        NSDictionary *dic =@{@"name":@"材质",@"code":@"",@"id":@""};
        [self.classifys addObject:dic];
         [self.classifys addObjectsFromArray:result.data];
        NSDictionary *bigdic =@{@"name":@"大类",@"code":@"",@"id":@""};
        self.areas =[NSMutableArray array];
        [self.areas addObject:bigdic];
//         [_menu reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)promotionCategory
{
    NSDictionary *dic =@{@"cz":self.sendDic[@"cz"],@"district": [DRBuyerModel sharedManager].locationcode};
    [SNAPI getWithURL:@"mainPage/promotionCategory" parameters:dic.mutableCopy success:^(SNResult *result) {
        NSDictionary *dic =@{@"name":@"大类",@"code":@"",@"id":@""};
        self.areas =[NSMutableArray array];
        [self.areas addObject:dic];
        [self.areas addObjectsFromArray:result.data];
         NSDictionary *smalldic =@{@"name":@"小类",@"code":@"",@"id":@""};
        self.sorts =[NSMutableArray array];
        [self.sorts addObject:smalldic];
       
//        [_menu reloadData];
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


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cuxiaoArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    
    DRCuxiaoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DRCuxiaoCellID forIndexPath:indexPath];
    cell.lookSameBlock = ^{
        NSLog(@"点击了第%zd商品的找相似",indexPath.row);
    };
    cell.cuxiaoModel = _cuxiaoArr[indexPath.row];
    gridcell = cell;
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *reusableview = nil;
//    if (kind == UICollectionElementKindSectionHeader){
////        DRCuXiaoHeaderView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DRCuXiaoHeaderViewID forIndexPath:indexPath];
//////        footerView.backgroundColor = BACKGROUNDCOLOR;
//////        [footerView.timeBtn setTitle:@"————  爆品牛商  ————" forState:UIControlStateNormal];
//////        footerView.timeBtn.titleLabel.font =DR_FONT(18);
//////        [footerView.timeBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
//        //        return footerView;
//        heiheihei *heiVC =[[heiheihei alloc]init];
//        return heiVC.view;
//    }
    return nil;
}
//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((ScreenW - 6)/2,  (ScreenW - 6)/2+ScreenW*0.13);
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(ScreenW, 0);
}
#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryDetailVC *goodSetVc =[[CategoryDetailVC alloc] init];
    goodSetVc.classListStr =_cuxiaoArr[indexPath.row].classList;
    goodSetVc.czID =_cuxiaoArr[indexPath.row].cz;
    goodSetVc.queryTypeStr =@"promotion";
    [self.navigationController pushViewController:goodSetVc animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
    //    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
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
