//
//  DCFiltrateViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define FiltrateViewScreenW ScreenW * 0.8

#import "DCFiltrateViewController.h"

// Controllers

// Models
#import "DCFiltrateItem.h"
#import "DCContentItem.h"
#import "GoodsShareModel.h"
// Views
#import "DCHeaderReusableView.h"
#import "DCFooterReusableView.h"
#import "DCAttributeItemCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCFiltrateViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* 筛选父View */
@property (strong , nonatomic)UIView *filtrateConView;
/* 已选 */
@property (strong , nonatomic)NSMutableArray *seleArray;
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@property (nonatomic , strong) NSMutableArray<DCFiltrateItem *> *filtrateItem;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@end

static NSString *const DCAttributeItemCellID = @"DCAttributeItemCell";
static NSString * const DCHeaderReusableViewID = @"DCHeaderReusableView";
static NSString * const DCFooterReusableViewID = @"DCFooterReusableView";

@implementation DCFiltrateViewController

#pragma mark - LazyLoad

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 10; //竖间距
        layout.itemSize = CGSizeMake((FiltrateViewScreenW - 6 * 5) / 3, 30);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(5, DRStatusBarHeight, FiltrateViewScreenW - 10, ScreenH - 50-DRStatusBarHeight);
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[DCAttributeItemCell class] forCellWithReuseIdentifier:DCAttributeItemCellID];//cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DCHeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCHeaderReusableViewID]; //头部
        [_collectionView registerClass:[DCFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCFooterReusableViewID]; //尾部
    }
    return _collectionView;
}

- (NSMutableArray<DCFiltrateItem *> *)filtrateItem
{
    if (!_filtrateItem) {
        _filtrateItem = [NSMutableArray array];
    }
    return _filtrateItem;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    
    [self setUpFiltrateData];
    
    [self setUpBottomButton];
}

#pragma mark - initialize
- (void)setUpInit
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    _filtrateConView = [UIView new];
    _filtrateConView.backgroundColor = [UIColor whiteColor];
    
    _filtrateConView.frame = CGRectMake(0, 0, FiltrateViewScreenW, ScreenH);
    [self.view addSubview:_filtrateConView];
    
    [_filtrateConView addSubview:self.collectionView];
    
}

#pragma mark - 筛选Item数据
- (void)setUpFiltrateData
{
    DRWeakSelf;
    NSString *urlStr;
    if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"history"]) {
        urlStr =@"/buyer/getHistoryBuyRelationCondition";
    }else if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"search"])
    {
        urlStr =@"/mainPage/getSearchRelationCondition";
    }//品牌搜索
    else if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"searchbrand"])
    {
        urlStr =@"/mainPage/getSearchRelationCondition";
    }
    //特价
    else if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"promotion"])
    {
        urlStr =@"/mainPage/getPromotionRelationCondition";
    }
    else if ([[GoodsShareModel sharedManager].queryType isEqualToString:@"factory"])
    {
        urlStr =@"/mainPage/getFactoryRelationCondition";
    }
    else
    {
        urlStr =@"/mainPage/getCategoryRelationCondition";
    }

    _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[[GoodsShareModel sharedManager].type?:@"",[GoodsShareModel sharedManager].level1Id?:@"",[GoodsShareModel sharedManager].level2Id?:@"",[GoodsShareModel sharedManager].cz?:@"",[GoodsShareModel sharedManager].categoryId?:@"",@"1",[GoodsShareModel sharedManager].jb?:@"",[GoodsShareModel sharedManager].bmcl?:@"",[GoodsShareModel sharedManager].cd?:@"",[GoodsShareModel sharedManager].cl?:@"",[GoodsShareModel sharedManager].yj?:@"",[GoodsShareModel sharedManager].yx?:@"",[GoodsShareModel sharedManager].pp?:@"",[GoodsShareModel sharedManager].zj?:@""] forKeys:@[@"type",@"level1Id",@"level2Id",@"cz",@"categoryId",@"subType",@"jb",@"bmcl",@"cd",@"cl",@"yj",@"yx",@"pp",@"zj"]];
    [SNIOTTool getWithURL:urlStr parameters:_sendDataDictionary success:^(SNResult *result) {
//        NSDictionary *bigDic =@{@"headTitle":@"",@"content":@""};
        NSArray *bigArr =@[@{@"headTitle":@"标准",@"content":result.data[@"bzlist"]},@{@"headTitle":@"材质",@"content":result.data[@"czlist"]},@{@"headTitle":@"材料",@"content":result.data[@"cllist"]},@{@"headTitle":@"直径",@"content":result.data[@"zjlist"]},@{@"headTitle":@"长度",@"content":result.data[@"cdlist"]},@{@"headTitle":@"级别",@"content":result.data[@"jblist"]},@{@"headTitle":@"表面处理",@"content":result.data[@"bmcllist"]},@{@"headTitle":@"品牌",@"content":result.data[@"pplist"]},@{@"headTitle":@"牙距",@"content":result.data[@"yjlist"]},@{@"headTitle":@"牙型",@"content":result.data[@"yxlist"]}];
        NSMutableArray *addSourceArr =[NSMutableArray array];
        for (NSDictionary *dic in bigArr) {
            NSArray *nilArr =dic[@"content"];
            if (nilArr.count!=0) {
                [addSourceArr addObject:dic];
            }
        }
        weakSelf.filtrateItem = [DCFiltrateItem mj_objectArrayWithKeyValuesArray:addSourceArr];
        [weakSelf.collectionView reloadData];
       
    } failure:^(NSError *error) {
    }];
}
#pragma mark - 底部重置确定按钮
- (void)setUpBottomButton
{
    CGFloat buttonW = FiltrateViewScreenW/2;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH-10;
    NSArray *titles = @[@"重置",@"确定"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag = i;
        if (i == 0) {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        CGFloat buttonX = i*buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = DR_FONT(15);
        button.backgroundColor = (i == 0) ? self.collectionView.backgroundColor : [UIColor redColor];
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_filtrateConView addSubview:button];
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.filtrateItem.count;
}

#pragma mark - <UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger doubleLine = (self.filtrateItem[section].content.count >= 6) ? 6 :  self.filtrateItem[section].content.count; //默认两行
    NSInteger oneLine = (self.filtrateItem[section].content.count >= 3) ? 3 : self.filtrateItem[section].content.count; //默认一行
    //这里默认第一组品牌展示两行数据其余展示一行数据（3个一行）
    return (_filtrateItem[section].isOpen == YES) ? self.filtrateItem[section].content.count : (section == 0) ? doubleLine : oneLine ;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DCAttributeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCAttributeItemCellID forIndexPath:indexPath];
    
    cell.contentItem = _filtrateItem[indexPath.section].content[indexPath.row];
  
    if (indexPath.section==0) {
          DCContentItem *itemModel =_filtrateItem[indexPath.section].content[indexPath.row];
         [cell.contentButton setTitle:itemModel.code forState:0];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        
        DCHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCHeaderReusableViewID forIndexPath:indexPath];
        DRWeakSelf;
        headerView.sectionClick = ^{
            
            weakSelf.filtrateItem[indexPath.section].isOpen = !weakSelf.filtrateItem[indexPath.section].isOpen; //打开取反
            
            [collectionView reloadData]; //刷新
        };
        
        //给每组的header的已选label赋值~
        NSArray *array = _seleArray[indexPath.section];
        NSString *selectName = @"";
        for (NSInteger i = 0; i < array.count; i ++ ) {
            if (i == array.count - 1) {
                selectName = [selectName stringByAppendingString:[NSString stringWithFormat:@"%@",array[i][@"name"]]];
            }else{
                selectName = [selectName stringByAppendingString:[NSString stringWithFormat:@"%@,",array[i][@"name"]]];
            }
            
        }
        
        headerView.selectHeadLabel.text = (selectName.length == 0) ? @"全部" : selectName;
        headerView.selectHeadLabel.textColor = ([headerView.selectHeadLabel.text isEqualToString:@"全部"]) ?  [UIColor darkGrayColor] : [UIColor redColor];
        
        
        headerView.headFiltrate = _filtrateItem[indexPath.section];
        
        return headerView;
    }else {
        
        DCFooterReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCFooterReusableViewID forIndexPath:indexPath];
        return footerView;
    }
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    _filtrateItem[indexPath.section].content[indexPath.row].isSelect = !_filtrateItem[indexPath.section].content[indexPath.row].isSelect;
    
    //数组mutableCopy初始化,for循环加数组 结构大致：@[@[],@[]] 如此
    _seleArray = [@[] mutableCopy];
    for (NSInteger i = 0; i < _filtrateItem.count; i++) {
        NSMutableArray *section = [@[] mutableCopy];
        [_seleArray addObject:section];
    }
    
    //把所选的每组Item分别加入每组的数组中
    for (NSInteger i = 0; i < _filtrateItem.count; i++) {
        for (NSInteger j = 0; j < _filtrateItem[i].content.count; j++) {
            if (indexPath.section==0) {
                if (_filtrateItem[i].content[j].isSelect == YES) {
                    NSDictionary *dic =@{@"name":_filtrateItem[i].content[j].code,@"id":_filtrateItem[i].content[j].child_id};
                    [_seleArray[i] addObject:dic];
                }else{
                    NSDictionary *dic =@{@"name":_filtrateItem[i].content[j].code,@"id":_filtrateItem[i].content[j].child_id};
                    [_seleArray[i] removeObject:dic];
                }
            }
            else
            {
                if (_filtrateItem[i].content[j].isSelect == YES) {
                    NSDictionary *dic =@{@"name":_filtrateItem[i].content[j].name,@"id":_filtrateItem[i].content[j].child_id};
                    [_seleArray[i] addObject:dic];
                }else{
                    NSDictionary *dic =@{@"name":_filtrateItem[i].content[j].name,@"id":_filtrateItem[i].content[j].child_id};
                    [_seleArray[i] removeObject:dic];
                }
            }
           
        }
    }
    
    [collectionView reloadData];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.dc_width, HScale(40));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.dc_width, 10);
}
#pragma mark - 点击事件
- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {//重置点击
        for (NSInteger i = 0; i < _filtrateItem.count; i++) {
            for (NSInteger j = 0; j < _filtrateItem[i].content.count; j++) {
                _filtrateItem[i].content[j].isSelect = NO;
                [_seleArray[i] removeAllObjects];
            }
        }
        [self.collectionView reloadData];
    }else if (button.tag == 1){//确定点击
        if (_seleArray != 0) {
            for (NSInteger i = 0; i < _seleArray.count; i++) {
                NSArray *array = _seleArray[i];
                NSString *selectName = @"";
                for (NSInteger i = 0; i < array.count; i ++ ) {
                    if (i == array.count - 1) {
                        selectName = [selectName stringByAppendingString:[NSString stringWithFormat:@"%@",array[i]]];
                    }else{
                        selectName = [selectName stringByAppendingString:[NSString stringWithFormat:@"%@,",array[i]]];
                    }
                    
                }
                if (selectName.length != 0) {
                    NSLog(@"已选：第%zd组 的 %@",i,selectName);
                }
            }
            
            !_sureClickBlock ? : _sureClickBlock(_seleArray);
        }

        
    }
}


@end
