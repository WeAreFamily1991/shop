
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
#import "CollectionCell.h"
#import "CatgoryDetailCell.h"
#import "GHCountField.h"
#import "CGXPickerView.h"
#import "DCSildeBarView.h"
#import "LDYSelectivityAlertView.h"
#import "StoreVC.h"
#define DIC_EXPANDED @"expanded" //是否是展开 0收缩 1展开

#define DIC_ARARRY @"array" //存放数组

#define DIC_TITILESTRING @"title"

#define CELL_HEIGHT 50.0f
@interface CategoryDetailVC ()<GHCountFieldDelegate,LDYSelectivityAlertViewDelegate>
{
    int pageCount;
     NSMutableArray *DataArray;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (assign,nonatomic)NSInteger selectYes;
@property (strong , nonatomic)UIButton *selectBtn;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
@end

@implementation CategoryDetailVC
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
    self.selectYes =NO;
     [self initDataSource];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    //    self.tableView.frame =CGRectMake(0, 120, SCREEN_WIDTH, self.tableView.height - 120);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    self.title =@"产品列表";
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
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
   
}
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 110 , 40, 40);
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
        _sendDataDictionary = [[NSMutableDictionary alloc] init];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    //    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjects:@[[UserModel sharedManager].token,] forKeys:@[@"token"]];
    //    NSString *urlStr = @"/ZcApi/CollectInfoList";
    //    if (self.statusStr == nil || [self.statusStr isEqualToString:@"2"]) {
    //        urlStr = @"/ZcApi/CollectInfoList";
    //        if ([self.title isEqualToString:SNStandardString(@"我的采集")]) {
    //            [dic setValue:@"2" forKey:@"s_type"];
    //        }
    //    }
    //    else if ([self.statusStr isEqualToString:@"1"]) {
    //        urlStr = @"/ZcApi/MyAssignList";
    //    }
    //    if (page) {
    //        [dic setObject:page forKey:@"page"];
    //        [dic setObject:@"10" forKey:@"limit"];
    //    }
    //    if (dictionary) {
    //        [dic addEntriesFromDictionary:dictionary];
    //    }
    //    if (self.status) {
    //        [dic setValue:self.status forKey:@"status"];
    //    }
    //
    //    [Interface_Base Post:urlStr dic:dic sccessBlock:^(NSDictionary *data, NSString *message) {
    //        NSLog(@"data=%@",data[@"data"]);
    //        if ([data[@"data"] isKindOfClass:[NSNull class]]||data[@"data"]==nil) {
    //            //            [MBProgressHUD showError:@"暂无新数据"];
    //            if (self.MsgListArr.count==0) {
    //                self.zeroView.hidden =NO;
    //            }else
    //            {
    //                self.zeroView.hidden =YES;
    //            }
    //            //             self.tableView.mj_footer.hidden =YES;
    //            [self.tableView reloadData];
    //
    //            [self.tableView.mj_footer endRefreshingWithNoMoreData];
    //
    //            //            [MBProgressHUD showError:@"暂无新数据"];
    //        }else
    //        {
    //            [self.MsgListArr addObjectsFromArray:data[@"data"]];
    //            if (self.MsgListArr.count==0) {
    //                self.zeroView.hidden =NO;
    //            }else
    //            {
    //                self.zeroView.hidden =YES;
    //            }
    //            [self.tableView reloadData];
    //            if (self.MsgListArr.count<10) {
    //                [self.tableView.mj_footer endRefreshingWithNoMoreData];
    //                //                self.tableView.mj_footer.hidden =YES;
    //            }
    //            else
    //            {
    //                //                self.tableView.mj_footer.hidden =NO;
    //                [self.tableView.mj_footer endRefreshing];
    //            }
    //            [self.tableView.mj_header endRefreshing];
    //            [MBProgressHUD hideHUD];
    //        }
    //    } failBlock:^(NSDictionary *data, NSString *message) {
    //        [self.tableView.mj_header endRefreshing];
    //        [self.tableView.mj_footer endRefreshing];
    //        [MBProgressHUD hideHUD];
    //    }];

   
    // Do any additional setup after loading the view from its nib.
}
-(void)setUI
{
    DRWeakSelf;
    self.buttonView = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(0.0, DRTopHeight, SCREEN_WIDTH, 40) view:self.view];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    
    self.buttonView.buttonClick = ^(NSInteger index, BOOL isDescending){
        NSLog(@"click index %ld, isDescending %d", index, isDescending);
        switch (index) {
            case 0:
            {
                NSArray *datas =@[@"本地云仓（三铁配送）",@"卖家库存（三铁配送）",@"卖家直发（价格便宜）"];
                 NSArray *contentDatas =@[@"说明：本地现货库存，及时配送、出货。",@"说明：卖家现货库存，通过三铁配送，到货方便。",@"说明：卖家现货库存，由卖家直接安排发货。"];
                LDYSelectivityAlertView *ldySAV = [[LDYSelectivityAlertView alloc]initWithdatas:datas contentDatas:contentDatas ifSupportMultiple:YES];
                ldySAV.delegate = weakSelf;
                [ldySAV show];
            }
                break;
            case 1:
            {
                
                
            }
                break;
            case 2:
            {
                 [DCSildeBarView dc_showSildBarViewController];
            }
                //                [buttonView setTitleButton:@"2019-02-27" index:2];
                break;
                
            default:
                break;
        }
    };
    self.buttonView.titleColorNormal = [UIColor blackColor];
    self.buttonView.titleColorSelected = [UIColor redColor];
    self.buttonView.titles = @[@"选择服务",@"月结卖家",@"筛选"];
    self.buttonView.enableTitles =  @[@"选择服务",@"筛选"];
    NSDictionary *dict01 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_downSelected"], keyImageSelected, nil];
    NSDictionary *dict02 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@""], keyImageNormal, [UIImage imageNamed:@""], keyImageSelected, nil];
    NSDictionary *dict03 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_downSelected"], keyImageSelected, nil];
    self.buttonView.imageTypeArray = @[dict01, dict02, dict03];
    self.buttonView.selectedIndex = -1;
}
#pragma LDYSelectivityAlertViewDelegate
-(void)singleChoiceBlockData:(NSString *)data{
    NSLog(@"data=%@",data);
}

-(void)multipleChoiceBlockDatas:(NSArray *)datas{
    NSLog(@"detail=%@",[datas componentsJoinedByString:@","]);
}

#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectYes) {
        return 7;
    }
    return 4;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectYes) {
        if (indexPath.row==4||indexPath.row==5||indexPath.row==6) {
            return HScale(20);
        }
    }
    switch (indexPath.row) {
        case 0:
            return 100;
            break;
        case 1:
            return UITableViewAutomaticDimension;
            break;
            
        case 2:
            return 45;
            break;
            
        case 3:
            return 40;
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
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            
        {
            CollectionCell2 *cell =[CollectionCell2 cellWithTableView:tableView];
            return cell;
        }
            break;
        case 1:
            
        {
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
            cell.moreBtn.tag =indexPath.section;
            cell.moreBtn.selected =self.selectYes;
            [cell.moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.dataDict = @{};
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
            break;
        case 2:
            
        {
            CatgoryDetailCell1 *cell =[CatgoryDetailCell1 cellWithTableView:tableView];
    
            [cell.danweiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
            cell.danweiBtn.tag =indexPath.section;
            
            cell.danweiBtnBlock = ^(NSInteger danweiBtntag) {
                [CGXPickerView showStringPickerWithTitle:@"单位" DataSource:@[ @"袋",@"盒", @"箱"] DefaultSelValue:@"袋" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                    [cell.danweiBtn setTitle:selectValue forState:UIControlStateNormal];
                    NSLog(@"%@",selectValue);
                    
                }];
            };
            cell.countTF.text =@"0.00";
            
            
            
            
            return cell;
        }
            break;
        case 3:
            
        {
            CatgoryDetailCell *cell =[CatgoryDetailCell cellWithTableView:tableView];
            return cell;
        }
            
            break;
        default:
            break;
    }
    if (self.selectYes) {
        if (indexPath.row==4||indexPath.row==5||indexPath.row==6) {
            static NSString *SimpleTableIdentifier = @"selectCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                     SimpleTableIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault                                              reuseIdentifier: SimpleTableIdentifier];
            }
            NSArray *titleArr =@[@"最小销售单位：箱",@"单规格起订量：1.000箱",@"预计发货时间：当日发货"];
            cell.textLabel.text = titleArr[indexPath.row-4];
            cell.textLabel.font =DR_FONT(12);
            return cell;
        }
    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    
//    cell.textLabel.text = [_titleStr stringByAppendingString:[NSString stringWithFormat:@"-%d",(int)indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[StoreVC new] animated:YES];
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
