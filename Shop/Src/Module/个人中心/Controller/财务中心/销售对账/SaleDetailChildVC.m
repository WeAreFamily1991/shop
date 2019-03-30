//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "SaleDetailChildVC.h"
#import "SaleOrderCell.h"
#import "CustomHeadView.h"
#import "ChildCustomHeadView.h"
#import "SalesOrderModel.h"
@interface SaleDetailChildVC ()
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (nonatomic,strong)ChildCustomHeadView *childheadView;
@property (nonatomic,strong)CustomHeadView *headView;
@property (nonatomic,strong)detailSalesOrderModel *detailModel;
@property (nonatomic,strong)ListModel *listMOdel;
@end

@implementation SaleDetailChildVC
- (instancetype)initWithIndex:(NSInteger)index title:(NSString *)title
{
    self = [super init];
    if (self) {
        _titleStr = title;
        NSLog(@"index=%ld",(long)index);
        _selectIndex =index;
        
    }
    return self;
}
-(void)selectWithIndex:(NSInteger)selectIndex
{
    NSLog(@"selectIndex=%ld",(long)selectIndex);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    //    self.tableView.frame =CGRectMake(0, 40, SCREEN_WIDTH, self.tableView.height-80);
//    __weak typeof(self) weakSelf = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (weakSelf.MsgListArr.count) {
//            [weakSelf.MsgListArr removeAllObjects];
//        }
//        pageCount=1;
//        [weakSelf getMsgList];
//        [weakSelf.tableView.mj_header endRefreshing];
//
//    }];
//    [self.tableView.mj_header beginRefreshing];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//        pageCount = pageCount +1;
//        [weakSelf getMsgList];
//    }];
//    [self.tableView.mj_footer endRefreshing];
    
    if (self.fatherStatus==1) {
        [self addCustomChildHeadView];
    }
    else
    {
        [self addCustomHeadView];
    }
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
    [self orderDzInfo];
// Do any additional setup after loading the view.
}
-(void)orderDzInfo
{
//    DRWeakSelf;
    NSString * stateStr;
    if (self.status==0) {
        stateStr =@"";
    }else if (self.status==1)
    {
        stateStr =@"1";
    }
    else if (self.status==2)
    {
        stateStr =@"0";
    }
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.saleModel.sale_id,stateStr] forKeys:@[@"dzId",@"type"]];
    [SNIOTTool getWithURL:@"buyer/orderDzInfo" parameters:dic success:^(SNResult *result) {
        
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.MsgListArr =[NSMutableArray array];
            NSArray *resultArr =result.data[@"sellerList"];
            if (resultArr.count!=0) {
                
                NSMutableArray *modelArray = [detailSalesOrderModel mj_objectArrayWithKeyValuesArray:resultArr];
                [self.MsgListArr addObjectsFromArray:modelArray];
                if (self.fatherStatus==0) {
                    //"totalAmt":2408.90,"onlineAmt":0,"lineAmt":2408.90,"lineReturnAmt":0,"onlineReturnAmt":0,"payAmt":2408.90,"
                    self.headView.payAllLab.text =[NSString stringWithFormat:@"您需支付金额:￥%.2f",[result.data[@"payAmt"] doubleValue]]?:@"0.00";
                    self.headView.allCountLab.text =[NSString stringWithFormat:@"账单总金额:￥%.2f",[result.data[@"totalAmt"] doubleValue]]?:@"0.00";
                    self.headView.onlineLab.text =[NSString stringWithFormat:@"在线支付金额：￥%.2f",[result.data[@"onlineAmt"] doubleValue]]?:@"0.00";
                    self.headView.onlineBackLab.text =[NSString stringWithFormat:@"在线支付退款：￥%.2f",[result.data[@"onlineReturnAmt"] doubleValue]]?:@"0.00";
                    self.headView.EDuLab.text =[NSString stringWithFormat:@"额度支付金额：￥%.2f",[result.data[@"lineAmt"] doubleValue]]?:@"0.00";
                    self.headView.eDuBackLab.text =[NSString stringWithFormat:@"额度支付退款：￥%.2f",[result.data[@"lineReturnAmt"] doubleValue]]?:@"0.00";
                }
                else
                {
                    self.childheadView.allCountMoneyLab.text =[NSString stringWithFormat:@"账单总金额:￥%@",result.data[@"totalAmt"]]?:@"0.00";
                    self.childheadView.payCountMoneyLab.text =[NSString stringWithFormat:@"您需支付金额:￥%@",result.data[@"payAmt"]]?:@"0.00";
                    self.childheadView.backCountLab.text =[NSString stringWithFormat:@"在线支付退款：￥%@",result.data[@"onlineReturnAmt"]]?:@"0.00";
                }
            }
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)addCustomChildHeadView
{
    self.childheadView = [[[NSBundle mainBundle] loadNibNamed:@"ChildCustomHeadView" owner:self options:nil] lastObject]; // lastObject 可改为 firstObject，该数组只有一个元素，写哪个都行，看个人习惯。
    self.tableView.tableHeaderView =self.childheadView ;
}
-(void)addCustomHeadView
{
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"CustomHeadView" owner:self options:nil] lastObject]; // lastObject 可改为 firstObject，该数组只有一个元素，写哪个都行，看个人习惯。
    self.tableView.tableHeaderView =self.headView ;

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
    
}-(void)addCustomView
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, 36)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.fatherStatus==0) {
        return HScale(100) ;
    }
    return HScale(120);
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.MsgListArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.detailModel =self.MsgListArr[section];
    return self.detailModel.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailModel = self.MsgListArr[indexPath.section];
    self.listMOdel =[ListModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
    if (self.fatherStatus==0) {
        SaleOrderCell1 *cell =[SaleOrderCell1 cellWithTableView:tableView];
        if ([self.listMOdel.billType intValue]==1) {
            cell.orderLab.text =@"单据类型：销售订单";
        }else
        {
            cell.orderLab.text =@"单据类型：退货订单";
        }
       
        cell.getTimeLab.text =[NSString stringWithFormat:@"生成时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",self.listMOdel.orderCompleteTime]]];
         cell.getTimeLab.textColor =[UIColor blackColor];
        cell.saleTimeLab.text =[NSString stringWithFormat:@"对账数量：%.3f",self.listMOdel.qty];
       
        cell.saleCountLab.text =[NSString stringWithFormat:@"对账金额：%.3f",self.listMOdel.orderAmt];
        cell.saleCountLab.textColor =[UIColor redColor];
        return cell;
    }
    SaleOrderCell *cell =[SaleOrderCell cellWithTableView:tableView];
    if ([self.listMOdel.billType intValue]==1) {
        cell.orderLab.text =@"单据类型：销售订单";
    }else
    {
        cell.orderLab.text =@"单据类型：退货订单";
    }
    
    cell.getTimeLab.text =[NSString stringWithFormat:@"生成时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",self.listMOdel.orderCompleteTime]]];
    cell.getTimeLab.textColor =[UIColor blackColor];
    cell.saleTimeLab.text =[NSString stringWithFormat:@"对账数量：%.3f",self.listMOdel.qty];
    cell.saleCountLab.text =[NSString stringWithFormat:@"对账金额：%.3f",self.listMOdel.orderAmt];
    cell.saleCountLab.textColor =[UIColor redColor];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.detailModel =self.MsgListArr[section];
    
    UIView*  headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HScale(30))];
    headView.backgroundColor=[UIColor whiteColor];
    UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(15, HScale(5), WScale(50), HScale(20))];
    button.titleLabel.font =DR_FONT(14);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
    [button setTitle:@"自营" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    [button setTitle:@"非自营" forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateSelected];
    button.selected =[self.detailModel.compType boolValue];
    [headView addSubview:button];
    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(button.dc_right+15, 0, 2*ScreenW/3, HScale(30))];
    headLab.font =DR_FONT(14);
    headLab.textColor =[UIColor blackColor];
    headLab.textAlignment = 0;
    headLab.text=self.detailModel.sellerName;
    [headView addSubview:headLab];
    return headView;
    
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, HScale(55))];
//    headView.backgroundColor =[UIColor whiteColor];
//    UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    button.tag=100+section;
//    button.titleLabel.font =[UIFont systemFontOfSize:14];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//
//    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
//    [button addTarget:self action:@selector(ClickSection:) forControlEvents:UIControlEventTouchUpInside];
//    [headView addSubview:button];
//    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, HScale(55))];
//    headLab.font =DR_FONT(14);
//    headLab.textColor =[UIColor blackColor];
//    headLab.textAlignment = 0;
//    headLab.text=self.detailModel.sellerName;
//    [headView addSubview:headLab];
//    return headView;
//}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return HScale(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
