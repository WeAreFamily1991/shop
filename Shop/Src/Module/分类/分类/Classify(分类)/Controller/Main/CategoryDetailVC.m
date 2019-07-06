
//
//  CategoryDetailVC.m
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CategoryDetailVC.h"
#import "SYTypeButtonView.h"
#import "SecondCell.h"
#import "GoodsCell.h"
#import "CatgoryDetailCell.h"
#import "GHCountField.h"
#import "CGXPickerView.h"
#import "DCSildeBarView.h"
#import "LDYSelectivityAlertView.h"
#import "StoreVC.h"
#import "GoodsModel.h"
#import "CustomAlertView.h"
#import "DRNullShopModel.h"
#import "DRFooterCell.h"
#import "TestImageView.h"
#import "ZWPhotoPreviewDataModel.h"
#import "ZWPhotoPreview.h"
#define DIC_EXPANDED @"expanded" //是否是展开 0收缩 1展开

#define DIC_ARARRY @"array" //存放数组

#define DIC_TITILESTRING @"title"

#define CELL_HEIGHT 50.0f
@interface CategoryDetailVC ()<GHCountFieldDelegate,LDYSelectivityAlertViewDelegate>
{
    int pageCount;
     NSMutableArray *DataArray;
    
}
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)NSMutableArray *MsgListArr,*selectNameArr,*selectCodeArr;
@property (assign,nonatomic)NSInteger selectYes;
@property (assign,nonatomic)NSInteger selectcode;
@property (strong , nonatomic)UIButton *selectBtn;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;

@property (strong , nonatomic)UIButton *shopCarButton;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@end

@implementation CategoryDetailVC
-(NSMutableArray *)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
//初始化数据
- (void)initDataSource{
    
    //创建一个数组
    DataArray=[[NSMutableArray alloc] init];
    
    for (int i = 0;i <= 5; i++) {
        
        NSMutableArray *array=[[NSMutableArray alloc] init];
        
        for (int j=0; j<=5;j++) {
            
            NSString *string=[NSString stringWithFormat:@"%i组-%i行",i,j];
            
            [array addObject:string];
            
        }
        
        NSString *string=[NSString stringWithFormat:@"第%i分组",i];
        
        //创建一个字典 包含数组，分组名，是否展开的标示
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:array,DIC_ARARRY,string,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED,nil];
        
        //将字典加入数组
        [DataArray addObject:dic];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgTipButton];
    self.selectYes =NO;
     [self initDataSource];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    //    self.tableView.frame =CGRectMake(0, 120, SCREEN_WIDTH, self.tableView.height - 120);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if ([self.queryTypeStr isEqualToString:@"history"])
    {
        self.title =@"购买记录";
    }else
    {
        self.title =@"产品列表";
    }
    
     [self setUpScrollToTopView];
    [self setUI];
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_tableView registerClass:[SecondCell class] forCellReuseIdentifier:@"SecondCell"];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.MsgListArr.count) {
            [weakSelf.MsgListArr removeAllObjects];
        }
        pageCount=1;
        [weakSelf getMsgList];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageCount = pageCount +1;
        [weakSelf getMsgList];
    }];
    [self.tableView.mj_footer endRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"select" object:nil];
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"select"]) {
        NSDictionary *dic =notification.userInfo;
        NSArray * sourceArr =dic[@"array"];
        NSString *muIDStr=[NSString string];
        NSMutableArray *muIDArr =[NSMutableArray array];
        for (NSArray *IDArr in sourceArr)
        {
            if (IDArr.count>1) {
                for (NSString *IDStr in IDArr) {
                    muIDStr =[muIDStr stringByAppendingString:[IDStr stringByAppendingString:@","]];
                }
            }
            else
            {
                if (IDArr.count!=0)
                {
                    muIDStr =IDArr[0]?:@"";
                }else
                {
                    muIDStr =@"";
                }
            }
            [muIDArr addObject:muIDStr];
        }
        NSArray *keyArr =@[@"onlyqty",@"voucherType",@"categoryId",@"czid",@"materialid",@"diameterid",@"lengthid",@"levelid",@"surfaceid",@"brandid",@"toothdistanceid",@"toothformid"];
        for (int i=0; i<muIDArr.count; i++) {
            [_sendDataDictionary setObject:muIDArr[i] forKey:keyArr[i]];
        }
//        for (NSString *muIDStr in muIDArr) {
//             [_sendDataDictionary setObject:muIDArr[0] forKey:@"onlyqty"];
//        }
//         [_sendDataDictionary setObject:muIDArr[0] forKey:@"onlyqty"];
//         [_sendDataDictionary setObject:muIDArr[1] forKey:@"voucherType"];
//         [_sendDataDictionary setObject:muIDArr[2] forKey:@"standardid"];
//         [_sendDataDictionary setObject:muIDArr[3] forKey:@"czid"];
//         [_sendDataDictionary setObject:muIDArr[4] forKey:@"materialid"];
//         [_sendDataDictionary setObject:muIDArr[5] forKey:@"diameterid"];
//         [_sendDataDictionary setObject:muIDArr[6] forKey:@"lengthid"];
//         [_sendDataDictionary setObject:muIDArr[7] forKey:@"levelid"];
//         [_sendDataDictionary setObject:muIDArr[8] forKey:@"surfaceid"];
//         [_sendDataDictionary setObject:muIDArr[9] forKey:@"brandid"];
//         [_sendDataDictionary setObject:muIDArr[10] forKey:@"toothdistanceid"];
////         [_sendDataDictionary setObject:muIDArr[11] forKey:@"toothformid"];
         [self.tableView.mj_header beginRefreshing];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"select" object:nil];
}
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
   
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 180-DRTopHeight , 40, 40);
    
    _shopCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_shopCarButton];
    [_shopCarButton addTarget:self action:@selector(shopCarButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [_shopCarButton setTitle:@"购物车" forState:UIControlStateNormal];
//    [_shopCarButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [_shopCarButton setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
    
//    _shopCarButton.hidden = YES;
    _shopCarButton.frame = CGRectMake(ScreenW - 100, ScreenH - 110-DRTopHeight , 80, 40);
}
-(void)shopCarButtonClick
{
    self.tabBarController.selectedIndex =3;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
    //    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > DRTopHeight) {
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
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        //queryType  normel(普通)  search （搜索） history（历史购买）
        //level1Id   标准头ID
       // level2Id   分类左边ID
        //categoryId   商品ID
        //serviceType 0:本地云仓 ，st：工厂库存——三铁配送  zf：工厂库存-工厂直发
        //sellerType  0自营 1月结卖家
        //containzy   是否包含自营 默认包含 0不包含
        //districtid  区域ID
        //onlyqty  是否显示有货 0或者1
        if ([self.queryTypeStr isEqualToString:@"history"]||[self.queryTypeStr isEqualToString:@"search"]||[self.queryTypeStr isEqualToString:@"searchbrand"]) {
//            NSArray *IDArr =[_classListStr componentsSeparatedByString:@","];
            NSLog(@"");
          
                _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[@"Wechat",self.queryTypeStr,@"",@"",@"",@"",@"1",@"",@"",@"",@"",@"",[DRBuyerModel sharedManager].locationcode?:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""] forKeys:@[@"sourceType",@"queryType",@"keyword",@"level1Id",@"level2Id",@"cz",@"subType",@"categoryId",@"condition",@"serviceType",@"sellerType",@"containzy",@"districtid",@"orderBy",@"onlyqty",@"standardid",@"levelid",@"surfaceid",@"lengthid",@"materialid",@"toothdistanceid",@"toothformid",@"brandid",@"czid",@"diameterid",@"voucherType"]];
            if ([self.queryTypeStr isEqualToString:@"search"]||[self.queryTypeStr isEqualToString:@"searchbrand"]) {
               [ _sendDataDictionary setObject:self.keyWordStr forKey:@"keyword"];
            }
        }
        else if ([self.queryTypeStr isEqualToString:@"shopnull"])
        {
             _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[[DRBuyerModel sharedManager].locationcode?:@"",self.nullShopModel.sellerid,self.queryTypeStr,@"",@"",@"",@"",@"1",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""] forKeys:@[@"districtId",@"sellerId",@"keyword",@"level1Id",@"level2Id",@"cz",@"subType",@"categoryId",@"condition",@"serviceType",@"sellerType",@"containzy",@"districtid",@"orderBy",@"onlyqty",@"standardid",@"levelid",@"surfaceid",@"lengthid",@"materialid",@"toothdistanceid",@"toothformid",@"brandid",@"czid",@"diameterid",@"voucherType"]];
        }
        else
        {
            NSArray *IDArr =[_classListStr componentsSeparatedByString:@","];
            NSLog(@"");
            if (IDArr.count>=3) {
                [GoodsShareModel sharedManager].level1Id =IDArr[0];
                [GoodsShareModel sharedManager].level2Id =IDArr[1];
                _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[@"Wechat",self.queryTypeStr,@"",IDArr[0],IDArr[1],_czID?:@"",@"1",IDArr[2],@"",@"",@"",@"",[DRBuyerModel sharedManager].locationcode?:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",_czID?:@"",@"",@""] forKeys:@[@"sourceType",@"queryType",@"keyword",@"level1Id",@"level2Id",@"cz",@"subType",@"categoryId",@"condition",@"serviceType",@"sellerType",@"containzy",@"districtid",@"orderBy",@"onlyqty",@"standardid",@"levelid",@"surfaceid",@"lengthid",@"materialid",@"toothdistanceid",@"toothformid",@"brandid",@"czid",@"diameterid",@"voucherType"]];
            }
            
        }
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (page) {
        [dic setObject:page forKey:@"pageindex"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    
    [SNAPI getWithURL:@"mainPage/getItem" parameters:dic success:^(SNResult *result) {
        
        NSLog(@"data=%@",result.data[@"list"]);
        NSMutableArray*addArr=result.data[@"itemdata"];
        NSMutableArray *modelArray =[GoodsModel mj_objectArrayWithKeyValuesArray:result.data[@"itemdata"]];
        [weakSelf.MsgListArr addObjectsFromArray:modelArray];
        [self.tableView reloadData];
        if (addArr.count<10){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
    }];
}
-(void)setUI
{
    NSArray *titleArr =@[@"选择服务",@"月结卖家",@"筛选"];
    NSArray *imageArr =@[@"accessoryArrow_down",@"",@"accessoryArrow_down"];
    NSArray *selectedImageArr =@[@"accessoryArrow_downSelected",@"",@"accessoryArrow_downSelected"];
    for (int i=0; i<3; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(i*ScreenW/3, 0, ScreenW/3, 39);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.backgroundColor =[UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:REDCOLOR forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImageArr[i]] forState:UIControlStateSelected];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:4];
        button.titleLabel.font =DR_FONT(14);
        button.tag =i;
        [button addTarget:self action:@selector(selectClickWithTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
-(void)selectClickWithTag:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            NSArray *datas =@[@"本地云仓（三铁配送）",@"卖家直发（价格便宜）"];
            NSArray *contentDatas =@[@"说明：本地现货库存，及时配送、出货。",@"说明：卖家现货库存，由卖家直接安排发货。"];
            LDYSelectivityAlertView *ldySAV = [[LDYSelectivityAlertView alloc]initWithdatas:datas contentDatas:contentDatas selectDatas:nil ifSupportMultiple:YES];
            ldySAV.delegate = self;
            [ldySAV show];
            
        }
            break;
        case 1:
        {
            sender.selected =!sender.selected;
            [self.sendDataDictionary setObject:sender.selected?@"1":@"" forKey:@"sellerType"];
            [self.tableView.mj_header beginRefreshing];
        }
            break;
        case 2:
        {
            if ([self.queryTypeStr isEqualToString:@"history"]) {
                 [GoodsShareModel sharedManager].queryType =@"history";
            }else if ([self.queryTypeStr isEqualToString:@"search"])
            {
                 [GoodsShareModel sharedManager].queryType =@"search";
                [GoodsShareModel sharedManager].keyword =self.keyWordStr;
            }
            else if ([self.queryTypeStr isEqualToString:@"searchbrand"])
            {
                 [GoodsShareModel sharedManager].queryType =@"searchbrand";
                [GoodsShareModel sharedManager].keyword =self.keyWordStr;
            }
            else if ([self.queryTypeStr isEqualToString:@"promotion"])
            {
                [GoodsShareModel sharedManager].queryType =@"promotion";
                [GoodsShareModel sharedManager].keyword =self.keyWordStr;
            }
            else
            {
                 [GoodsShareModel sharedManager].queryType =@"";
            }
           
            [DCSildeBarView dc_showSildBarViewController];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma LDYSelectivityAlertViewDelegate
-(void)singleChoiceBlockData:(NSString *)data{
    NSLog(@"data=%@",data);
}

-(void)multipleChoiceBlockDatas:(NSArray *)datas{
    
    NSLog(@"detail=%@",[datas componentsJoinedByString:@","]);
    [_sendDataDictionary setObject:[datas componentsJoinedByString:@","] forKey:@"serviceType"];
    [self.tableView.mj_header beginRefreshing];
}

- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"MG_Empty_dizhi"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无数据" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-DRTopHeight, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}



#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return self.MsgListArr.count;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 120;
            break;
        case 1:
            return UITableViewAutomaticDimension;
            break;
            
        case 2:
            if (self.MsgListArr.count!=0) {
                self.goodsModel =self.MsgListArr[indexPath.section];
                if ([self.goodsModel.qty isEqualToString:@"0"]) {
                    return 40;
                }
                
            }
            return 80;
            break;
            
        case 3:
            return 0;
            break;
            
            
        default:
            break;
    }
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.selectYes) {
            return HScale(70);
    }
    return 0.01;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRWeakSelf;
    if (self.MsgListArr.count!=0)
    {
        self.goodsModel =self.MsgListArr[indexPath.section];
        if (indexPath.row==0)
        {
            GoodsCell *cell =[GoodsCell cellWithTableView:tableView];
            cell.goodsModel =self.goodsModel;
            return cell;
        }
        else if (indexPath.row==1)
        {
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
            cell.moreBtn.tag =indexPath.section;
            cell.moreBtn.selected =self.selectYes;
            [cell.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.goodsModel =self.goodsModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else if (indexPath.row==2)
        {
            if (![self.goodsModel.qty isEqualToString:@"0"])
            {
                CatgoryDetailCell1 *cell =[CatgoryDetailCell1 cellWithTableView:tableView withIndexPath:indexPath];
              
                cell.goodsModel =self.goodsModel;
                cell.danweiBtn.tag =indexPath.section;
                cell.countTF.placeholder =@"0.00";
                return cell;
            }
            else
            {
                CatgoryDetailCell *cell =[CatgoryDetailCell cellWithTableView:tableView];
                cell.goodsModel =self.goodsModel;
                return cell;
            }
        }
    }
          static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 SimpleTableIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier: SimpleTableIdentifier];
        }
        return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.selectYes)
    {
        DRFooterCell *cell =[DRFooterCell cellWithTableView:tableView];
        NSString *timestr;
        if ([self.goodsModel.deliveryDay doubleValue]>1) {
            timestr =[NSString stringWithFormat:@"预计发货时间：%ld天",(long)self.goodsModel.deliveryDay];
        }else{
            timestr =@"预计发货时间：当天发货";
        }
        NSArray *titleArr =@[[NSString stringWithFormat:@"最小销售单位：%@",self.goodsModel.saleunitname],[NSString stringWithFormat:@"单规格起订量：%.3f%@",[self.goodsModel.minquantity floatValue],self.goodsModel.saleunitname],timestr];
        cell.danweiLab.text = titleArr[0];
        cell.qidingliangLab.text = titleArr[1];
        cell.timeLAb.text = titleArr[2];
        if (self.goodsModel.drawing.length==0) {
            cell.lookIMGbTN.hidden =YES;
        }
        else
        {
            cell.lookIMGbTN.hidden =NO;
        }
        cell.lookIMGBtnBlock = ^{
          
            ZWPhotoPreviewDataModel *model1 = [[ZWPhotoPreviewDataModel alloc] init];
            model1.zw_photoURL = self.goodsModel.drawing;
            model1.zw_photoTitle =nil;
            model1.zw_photoDesc = nil;
            
            ZWPhotoPreview *view = [ZWPhotoPreview zw_showPhotoPreview:@[model1]];
            view.showIndex = 0;
           
            
        };
        //            [SNTool setTextColor:cell.textLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(7, cell.textLabel.text.length-7) AndColor:REDCOLOR];
        return cell;
        
    }
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.navigationController pushViewController:[StoreVC new] animated:YES];
}

#pragma mark -- ShopTableViewCellSelectDelegate
/**
 *  cell的选择代理
 *
 *  @param sender 选中按钮
 */
//- (void)cellSelectBtnClick:(UIButton *)sender{
//    MyShopCarTableViewCell *cell = (MyShopCarTableViewCell *)[[sender superview] superview];
//    NSIndexPath *indexPath;
//    indexPath = [_tableView indexPathForCell:cell];
//
//    ShopCarDetailModel *bigModel = self.shopCarGoodsArray[indexPath.section];
//    CarDetailModel *cellModel = bigModel.goodsDetails[indexPath.row];
//    cellModel.selectState = sender.selected;
//    //设置段头的选择按钮选中状态
//    [self setHeaderViewSelectState:bigModel];
//    //设置底部选择按钮的选中状态
//    [self setBottomBtnSelectState];
//    //计算价格
//    [self calculateTotalMoney:[NSMutableArray arrayWithObject:cellModel] addOrReduc:sender.selected];
//
//    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
//    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    //    [_tableView reloadData];
//
//}
///**
// *  修改商品数量
// *
// *  @param sender 1 减少  2 增加
// */
//- (void)changeShopCount:(UIButton *)sender{
//    switch (sender.tag) {
//        case 1:
//        {
//
//        }
//            break;
//        case 2:
//        {
//
//        }
//            break;
//        default:
//            break;
//    }
//}

-(void)selectBtnClick:(UIButton *)sender
{
    [CGXPickerView showStringPickerWithTitle:@"单位" DataSource:@[ @"袋",@"盒", @"箱"] DefaultSelValue:@"单位" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
        NSLog(@"%@",selectValue);
        
    }];
}
-(void)moreBtnClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    self.selectYes = sender.selected ;
    [self.tableView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
