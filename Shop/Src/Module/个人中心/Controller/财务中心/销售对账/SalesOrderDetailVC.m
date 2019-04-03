//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "SalesOrderDetailVC.h"
#import "SaleOrderCell.h"
#import "SaleDetailVC.h"

#import "SalesOrderModel.h"
#import "CHDatePickerMenu.h"
#import "SalesOrderVC.h"
@interface SalesOrderDetailVC ()
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (nonatomic,strong)SalesOrderModel *saleModel;
/* 暂无子账号提示 */
@property (strong , nonatomic)DCUpDownButton *bgTipButton;
@end

@implementation SalesOrderDetailVC
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
-(NSMutableArray*)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
-(void)selectWithIndex:(NSInteger)selectIndex
{
    NSLog(@"selectIndex=%ld",(long)selectIndex);
}
-(void)setSourceWithDic:(NSMutableDictionary *)dic withIndex:(NSInteger)index;
{
    if ([dic[@"index"] isEqualToString:@"1"]) {
        [_sendDataDictionary setObject:dic[@"time"]?:@"" forKey:@"startTime"];
        [_sendDataDictionary setObject:dic[@"time"]?:@"" forKey:@"endTime"];
    }
    else
    {
        [_sendDataDictionary setObject:dic[@"dzNo"]?:@"" forKey:@"dzNo"];
    }
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgTipButton];
    self.view.backgroundColor =BACKGROUNDCOLOR;
//    self.tableView.frame =CGRectMake(0, 40, SCREEN_WIDTH, self.tableView.height-80);
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"sale" object:nil];
}

- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"sale"]) {
        NSDictionary *dic =notification.userInfo;
        if ([dic[@"index"] isEqualToString:@"1"]) {
            [_sendDataDictionary setObject:dic[@"time"]?:@"" forKey:@"startTime"];
            [_sendDataDictionary setObject:dic[@"time"]?:@"" forKey:@"endTime"];
        }
        else
        {
             [_sendDataDictionary setObject:dic[@"dzNo"]?:@"" forKey:@"dzNo"];
        }
        [self.tableView.mj_header beginRefreshing];
    }
}
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;

-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sale" object:nil];
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[@"",@"",@""] forKeys:@[@"startTime",@"endTime",@"dzNo"]];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *urlStr ;
        if (self.status == 1 ) {
            urlStr = @"buyer/feeList";
        }
        else  {
            urlStr = @"buyer/orderDz";
        }
        if (page) {
            [dic setObject:page forKey:@"pageNum"];
            [dic setObject:@"10" forKey:@"pageSize"];
        }
        if (dictionary) {
            [dic addEntriesFromDictionary:dictionary];
        }    
    DRWeakSelf;
    [SNIOTTool getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        NSLog(@"data=%@",result.data[@"list"]);
        NSMutableArray*addArr=result.data[@"list"];
        if (addArr.count) {
            for (NSDictionary *dic in addArr) {
                weakSelf.saleModel =[SalesOrderModel mj_objectWithKeyValues:dic];
                [self.MsgListArr addObject:weakSelf.saleModel];
            }
        }
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return UITableViewAutomaticDimension;
    if (self.status==1) {
        return HScale(100) ;
    }
    return HScale(120);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.bgTipButton.hidden = (self.MsgListArr.count > 0) ? YES : NO;
    return self.MsgListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//区尾的高度
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.saleModel =self.MsgListArr[indexPath.row];
    if (self.status==0) {
        SaleOrderCell *cell =[SaleOrderCell cellWithTableView:tableView];
        cell.typeLab.hidden =YES;
        cell.saleModel =self.saleModel;
        cell.status =self.status;
        cell.detailClickBlock = ^{
            SaleDetailVC *saleDetailVC =[[SaleDetailVC alloc]init];
            saleDetailVC.saleModel =self.saleModel;
            saleDetailVC.fatherStatus =self.status;
            [self.navigationController pushViewController:saleDetailVC animated:YES];
        };
        return cell;
    }else
    {
        SaleOrderCell1 *cell =[SaleOrderCell1 cellWithTableView:tableView];
        cell.typeLab.hidden =YES;
        cell.saleModel =self.saleModel;
        cell.status =self.status;
        cell.detailClickBlock = ^{
            SaleDetailVC *saleDetailVC =[[SaleDetailVC alloc]init];
            saleDetailVC.saleModel =self.saleModel;
            saleDetailVC.fatherStatus =self.status;
            [self.navigationController pushViewController:saleDetailVC animated:YES];
        };
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.saleModel =self.MsgListArr[indexPath.row];
    SaleDetailVC *saleDetailVC =[[SaleDetailVC alloc]init];
    saleDetailVC.saleModel =self.saleModel;
    saleDetailVC.fatherStatus =self.status;
    [self.navigationController pushViewController:saleDetailVC animated:YES];
}

@end
