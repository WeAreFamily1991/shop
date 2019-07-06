//
//  DCCommodityViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define tableViewH  95

#import "DRCatoryShopVC.h"

// Controllers
#import "DCGoodsSetViewController.h"
#import "MLSearchViewController.h"
#import "DRLocationVC.h"
// Models
#import "DCClassMianItem.h"
#import "DCCalssSubItem.h"
#import "DRCatoryItem.h"
#import "SendSourceModel.h"
#import "DRFactoryModel.h"
#import "DRNullGoodModel.h"

// Views
#import "DCNavSearchBarView.h"
#import "DCClassCategoryCell.h"
#import "DCGoodsSortCell.h"
#import "DCBrandSortCell.h"
#import "DRFactoryCell.h"
#import "DCBrandsSortHeadView.h"
#import "CBSegmentView.h"
// Vendors
#import <MJExtension.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
#import "CategoryDetailVC.h"

// Others

@interface DRCatoryShopVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionViw */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
/* 语音按钮 */
@property (strong , nonatomic)UIButton *voiceButton;
/* 左边数据 */
@property (strong , nonatomic)NSMutableArray<DRCatoryItem *> *titleItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassMianItem *> *mainItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray<DRFactoryModel *> *factoryArr;

@property (nonatomic,strong)NSMutableArray *sendArr ,*nameArr;
@property (nonatomic,strong)SendSourceModel *souceModel;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (strong,nonatomic) NSDictionary *hotSearchDic;

@end

static NSString *const DCClassCategoryCellID = @"DCClassCategoryCell";
static NSString *const DCBrandsSortHeadViewID = @"DCBrandsSortHeadView";
static NSString *const DCGoodsSortCellID = @"DCGoodsSortCell";
static NSString *const DCBrandSortCellID = @"DCBrandSortCell";
static NSString *const DRFactoryCellID = @"DRFactoryCell";

@implementation DRCatoryShopVC

#pragma mark - LazyLoad

-(NSDictionary *)hotSearchDic
{
    if (!_hotSearchDic) {
        _hotSearchDic =[NSDictionary dictionary];
    }
    return _hotSearchDic;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 50, tableViewH, ScreenH -50-DRTabBarHeight-DRTopHeight);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[DCClassCategoryCell class] forCellReuseIdentifier:DCClassCategoryCellID];
        
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0; //X
        layout.minimumLineSpacing = 1;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewH ,50, ScreenW - tableViewH - DCMargin, ScreenH - DRTopHeight-50-DRTabBarHeight);
        //注册Cell
        [_collectionView registerClass:[DCGoodsSortCell class] forCellWithReuseIdentifier:DCGoodsSortCellID];
        [_collectionView registerClass:[DRFactoryCell class] forCellWithReuseIdentifier:DRFactoryCellID];
        [_collectionView registerClass:[DCBrandSortCell class] forCellWithReuseIdentifier:DCBrandSortCellID];
        //注册Header
        [_collectionView registerClass:[DCBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID];
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _sendDataDictionary =[NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"cz"]];
    [self setUpNav];
  
    [self setUpTab];
    [self setUpData];
    [self setHotSearch];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
-(void)setSellerid:(NSString *)sellerid
{
    _sellerid =sellerid;
      [self setUpHeaderBtn];
      [self addSource];
}
-(void)setUpHeaderBtn
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW,50)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    DRWeakSelf;
    NSDictionary *dic =@{@"sellerId":self.sellerid?:@""};
    [SNAPI getWithURL:@"seller/getCzList" parameters:dic.mutableCopy success:^(SNResult *result)
     {
        NSDictionary *dic =@{@"id":@"",@"name":@"全部"};
        weakSelf.nameArr=[NSMutableArray arrayWithObject:@"全部"];
         NSArray *czArr =result.data[@"czlist"];
         if (czArr.count!=0) {
             for (NSDictionary *dic in czArr) {
                 [weakSelf.nameArr addObject:dic[@"name"]];
             }
             weakSelf.sendArr=[[NSMutableArray alloc]initWithObjects:dic, nil];
             [weakSelf.sendArr addObjectsFromArray:czArr];
             CBSegmentView *zoomSegmentView = [[CBSegmentView alloc]initWithFrame:backView.bounds];
             [backView addSubview:zoomSegmentView];
             [zoomSegmentView setTitleArray:weakSelf.nameArr withStyle:CBSegmentStyleZoom];
             zoomSegmentView.titleChooseReturn = ^(NSInteger x) {
                 NSLog(@"点击了第%ld个按钮",x+1);
                 [self.sendDataDictionary setObject:self.sendArr[x][@"id"] forKey:@"cz"];
                 [self addSource];
             };
             UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
             lineView.backgroundColor =[UIColor lightGrayColor];
             [backView addSubview: lineView];
         }
        
       
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - initizlize
- (void)setUpTab
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    self.collectionView.backgroundColor = BACKGROUNDCOLOR;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - 加载数据
- (void)setUpData
{
    
   
  
    //    _titleItem = [DCClassGoodsItem mj_objectArrayWithFilename:@"ClassifyTitles.plist"];
    //    _mainItem = [DCClassMianItem mj_objectArrayWithFilename:@"ClassiftyGoods01.plist"];
    //默认选择第一行（注意一定要在加载完数据之后）
    
}
-(void)addSource
{
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    [self.sendDataDictionary setObject:self.sellerid?:@"" forKey:@"sellerId"];
    [SNAPI getWithURL:@"seller/sellerCategory" parameters:_sendDataDictionary success:^(SNResult *result) {
        
        weakSelf.mainItem =[NSMutableArray array];
        weakSelf.titleItem = [DRCatoryItem mj_objectArrayWithKeyValuesArray:result.data[@"categorys"]];
        [weakSelf.tableView reloadData];
        //默认选择第一行（注意一定要在加载完数据之后）
        NSArray *DATAArr =result.data[@"categorys"];
        if (DATAArr.count!=0) {
            [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            NSMutableArray *muItem =[NSMutableArray array];
            
            for (NSDictionary *dic in weakSelf.titleItem[0].list) {
                
                NSArray *mainItemArr  =[DCClassMianItem mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                [muItem addObjectsFromArray:mainItemArr];
                weakSelf.mainItem =muItem;
            }
        }
        [weakSelf.collectionView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        
    }];
}
-(void)addgetFactoryArea
{
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    NSDictionary *dic =@{@"pageNum":@"1",@"pageSize":@"10"};
    [SNAPI getWithURL:@"mainPage/getFactoryArea" parameters:dic.mutableCopy success:^(SNResult *result) {
        
        weakSelf.factoryArr =[NSMutableArray array];
        weakSelf.factoryArr = [DRFactoryModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        [weakSelf.collectionView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        
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
#pragma mark - 设置导航条
- (void)setUpNav
{
    //    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    negativeSpacer.width = -15;
    
    //    UIButton *button = [[UIButton alloc] init];
    //    [button setImage:[UIImage imageNamed:@"mshop_message_gray_icon"] forState:UIControlStateNormal];
    //    [button setImage:[UIImage imageNamed:@"mshop_message_gray_icon"] forState:UIControlStateHighlighted];
    //    button.frame = CGRectMake(0, 0, 44, 44);
    //    [button addTarget:self action:@selector(messButtonBarItemClick) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    //
    //    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
    
    _topSearchView = [[UIView alloc] init];
    _topSearchView.backgroundColor = RGBA(240, 240, 240, 1);
    _topSearchView.layer.cornerRadius = 16;
    [_topSearchView.layer masksToBounds];
    _topSearchView.frame = CGRectMake(15, 6, ScreenW - 30, 32);
    self.navigationItem.titleView = _topSearchView;
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"请输入关键字" forState:0];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
    _searchButton.titleLabel.font = DR_FONT(13);
    [_searchButton setImage:[UIImage imageNamed:@"group_home_search_gray"] forState:0];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * DCMargin, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, DCMargin, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _searchButton.frame = CGRectMake(0, 0, _topSearchView.dc_width - 2 * DCMargin, _topSearchView.dc_height);
    [_topSearchView addSubview:_searchButton];
    
    
    //    _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _voiceButton.adjustsImageWhenHighlighted = NO;
    //    _voiceButton.frame = CGRectMake(_topSearchView.dc_width - 40, 0, 35, _topSearchView.dc_height);
    //    [_voiceButton addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [_voiceButton setImage:[UIImage imageNamed:@"icon_voice_search"] forState:0];
    //    [_topSearchView addSubview:_voiceButton];
    
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DCClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DCClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = _titleItem[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale(40);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    _mainItem = [DCClassMianItem mj_objectArrayWithFilename:_titleItem[indexPath.row].fileName];
    NSMutableArray *muItem =[NSMutableArray array];
    for (NSDictionary *dic in _titleItem[indexPath.row].list) {
        
        NSArray *mainItemArr  =[DCClassMianItem mj_objectArrayWithKeyValuesArray:dic[@"list"]];
        [muItem addObjectsFromArray:mainItemArr];
        _mainItem =muItem;
    }
    [self.collectionView reloadData];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return _mainItem.count;
}
#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
 
        
    DCGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSortCellID forIndexPath:indexPath];
    cell.mainItem = _mainItem[indexPath.row];
    gridcell = cell;
    return gridcell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    //    if (kind == UICollectionElementKindSectionHeader){
    //
    //        DCBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID forIndexPath:indexPath];
    //        headerView.headTitle = _mainItem[indexPath.section];
    //        reusableview = headerView;
    //    }
    return reusableview;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    return CGSizeMake(ScreenW - tableViewH  - DCMargin, HScale(80));
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了个第%zd分组第%zd几个Item",indexPath.section,indexPath.row);
    //     [self.navigationController pushViewController:[CategoryDetailVC new] animated:YES];
   
        CategoryDetailVC *goodSetVc =[[CategoryDetailVC alloc] init];
        goodSetVc.classListStr =_mainItem[indexPath.row].classList;
        goodSetVc.czID =[_sendDataDictionary objectForKey:@"cz"];
        goodSetVc.queryTypeStr =@"normel";
        [[self.view viewController].navigationController pushViewController:goodSetVc animated:YES];    
}


#pragma mark - 搜索点击
- (void)searchButtonClick
{
    MLSearchViewController *vc = [[MLSearchViewController alloc] init];
    //    NSMutableArray *titleArr=[NSMutableArray array];
    //    for (NSDictionary *dic in self.hotSearchArr) {
    //        [titleArr addObject:dic[@"keywords"]];
    //    }
    //    vc.tagsArray =titleArr;
    vc.hotSearchDic =self.hotSearchDic;
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 语音点击
- (void)voiceButtonClick
{
    
}

#pragma mark - 消息点击
- (void)messButtonBarItemClick
{
    
}

@end
