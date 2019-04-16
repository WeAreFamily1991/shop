//
//  DCCommodityViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define tableViewH  95

#import "DCCommodityViewController.h"

// Controllers
#import "DCGoodsSetViewController.h"
#import "MLSearchViewController.h"
// Models
#import "DCClassMianItem.h"
#import "DCCalssSubItem.h"
#import "DCClassGoodsItem.h"
#import "SendSourceModel.h"

// Views
#import "DCNavSearchBarView.h"
#import "DCClassCategoryCell.h"
#import "DCGoodsSortCell.h"
#import "DCBrandSortCell.h"
#import "DCBrandsSortHeadView.h"
#import "SYMoreButtonView.h"
// Vendors
#import <MJExtension.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
#import "CategoryDetailVC.h"
// Others

@interface DCCommodityViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SYMoreButtonDelegate>

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
@property (strong , nonatomic)NSMutableArray<DCClassGoodsItem *> *titleItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassMianItem *> *mainItem;

@property (nonatomic,strong)SYMoreButtonView *bottomBtnView;
@property (nonatomic,strong)NSMutableArray *sendArr ,*nameArr;
@property (nonatomic,strong)SendSourceModel *souceModel;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (strong,nonatomic) NSArray *hotSearchArr;

@end

static NSString *const DCClassCategoryCellID = @"DCClassCategoryCell";
static NSString *const DCBrandsSortHeadViewID = @"DCBrandsSortHeadView";
static NSString *const DCGoodsSortCellID = @"DCGoodsSortCell";
static NSString *const DCBrandSortCellID = @"DCBrandSortCell";

@implementation DCCommodityViewController

#pragma mark - LazyLoad

-(NSArray *)hotSearchArr
{
    if (!_hotSearchArr) {
        _hotSearchArr =[NSArray array];
    }
    return _hotSearchArr;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, DRTopHeight+50, tableViewH, ScreenH - DRTopHeight-50-DRTabBarHeight);
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
        _collectionView.frame = CGRectMake(tableViewH , DRTopHeight+50, ScreenW - tableViewH - DCMargin, ScreenH - DRTopHeight-50-DRTabBarHeight);
        //注册Cell
        [_collectionView registerClass:[DCGoodsSortCell class] forCellWithReuseIdentifier:DCGoodsSortCellID];
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
    [self setUpHeaderBtn];
    [self setUpTab];
    [self setUpData];
    [self setHotSearch];
}
-(void)setUpHeaderBtn
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, DRTopHeight, self.view.width,50)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    DRWeakSelf;
    [SNIOTTool getWithURL:@"mainPage/getCzList" parameters:nil success:^(SNResult *result) {
        NSDictionary *dic =@{@"id":@"",@"name":@"全部"};
        weakSelf.nameArr=[NSMutableArray arrayWithObject:@"全部"];
        for (NSDictionary *dic in result.data) {
            [weakSelf.nameArr addObject:dic[@"name"]];
        }
        weakSelf.sendArr=[[NSMutableArray alloc]initWithObjects:dic, nil];
        [weakSelf.sendArr addObjectsFromArray:result.data];
        weakSelf.bottomBtnView = [[SYMoreButtonView alloc] initWithFrame:CGRectMake(0.0, 0, ScreenW, backView.dc_height)];
        [backView addSubview:weakSelf.bottomBtnView];
        weakSelf.bottomBtnView.backgroundColor = [UIColor clearColor];
        weakSelf.bottomBtnView.titles = weakSelf.nameArr;
        weakSelf.bottomBtnView.showline = NO;
        weakSelf.bottomBtnView.showlineAnimation = NO;
        weakSelf.bottomBtnView.font = 14;
        weakSelf.bottomBtnView.indexSelected = 0;
        weakSelf.bottomBtnView.colorSelected = [UIColor redColor];
        weakSelf.bottomBtnView.delegate = self;
        weakSelf.bottomBtnView.buttonClick = ^(NSInteger index) {
            NSLog(@"block click index = %@", @(index));
        };
        [weakSelf.bottomBtnView reloadData];
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor =[UIColor lightGrayColor];
        [backView addSubview: lineView];
    } failure:^(NSError *error) {
        
    }];
}
- (void)sy_buttonClick:(NSInteger)index
{
    
    [self.sendDataDictionary setObject:self.sendArr[index][@"id"] forKey:@"cz"];
    [self setUpData];
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
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    [SNIOTTool getWithURL:@"mainPage/itemCategory" parameters:_sendDataDictionary success:^(SNResult *result) {
       
        
        weakSelf.titleItem = [DCClassGoodsItem mj_objectArrayWithKeyValuesArray:result.data];
        [weakSelf.tableView reloadData];
         //默认选择第一行（注意一定要在加载完数据之后）
         [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        NSMutableArray *muItem =[NSMutableArray array];
        for (NSDictionary *dic in weakSelf.titleItem[0].childCategory2) {
            
            NSArray *mainItemArr  =[DCClassMianItem mj_objectArrayWithKeyValuesArray:dic[@"stCategoryVOList"]];
            [muItem addObjectsFromArray:mainItemArr];
            weakSelf.mainItem =muItem;
        }
         [weakSelf.collectionView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
         [MBProgressHUD hideHUD];
        
    }];
//    _titleItem = [DCClassGoodsItem mj_objectArrayWithFilename:@"ClassifyTitles.plist"];
//    _mainItem = [DCClassMianItem mj_objectArrayWithFilename:@"ClassiftyGoods01.plist"];
    //默认选择第一行（注意一定要在加载完数据之后）
   
}

-(void)setHotSearch
{
    DRWeakSelf;
    [SNIOTTool getWithURL:@"mainPage/hotSearch" parameters:nil success:^(SNResult *result) {
        weakSelf.hotSearchArr =result.data[@"item"];
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
    for (NSDictionary *dic in _titleItem[indexPath.row].childCategory2) {
        
        NSArray *mainItemArr  =[DCClassMianItem mj_objectArrayWithKeyValuesArray:dic[@"stCategoryVOList"]];
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
//    for (<#type *object#> in _titleItem) {
//        <#statements#>
//    }
   
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
    CategoryDetailVC *goodSetVc = [[CategoryDetailVC alloc] init];
    
    goodSetVc.classListStr =_mainItem[indexPath.row].classList;
    goodSetVc.czID =[_sendDataDictionary objectForKey:@"cz"];
    [self.navigationController pushViewController:goodSetVc animated:YES];
}


#pragma mark - 搜索点击
- (void)searchButtonClick
{
    MLSearchViewController *vc = [[MLSearchViewController alloc] init];
    NSMutableArray *titleArr=[NSMutableArray array];
    for (NSDictionary *dic in self.hotSearchArr) {
        [titleArr addObject:dic[@"keywords"]];
    }
    vc.tagsArray =titleArr;
    vc.hotSearchArr =self.hotSearchArr;
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
