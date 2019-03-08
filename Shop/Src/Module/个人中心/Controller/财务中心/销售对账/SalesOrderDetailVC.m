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
@interface SalesOrderDetailVC ()
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
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
-(void)selectWithIndex:(NSInteger)selectIndex
{
    NSLog(@"selectIndex=%ld",(long)selectIndex);
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
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
    if (self.status==1) {
        return HScale(115) ;
    }
    return HScale(135);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    
    if (self.status==1) {
        SaleOrderCell *cell =[SaleOrderCell cellWithTableView:tableView];
        return cell;
    }
    SaleOrderCell1 *cell =[SaleOrderCell1 cellWithTableView:tableView];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SaleDetailVC *saleDetailVC =[[SaleDetailVC alloc]init];
    saleDetailVC.fatherStatus =self.status;
    [self.navigationController pushViewController:saleDetailVC animated:YES];
}
@end
