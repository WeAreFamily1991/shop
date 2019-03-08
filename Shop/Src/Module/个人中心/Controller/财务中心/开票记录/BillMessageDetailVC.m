//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//
#import "BackVC.h"
#import "BillMessageDetailVC.h"
#import "FirstTableViewCell.h"
#import "SaleOrderCell.h"
#import "BillMessageDetailChildVC.h"
@interface BillMessageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (nonatomic, copy) NSString *titleStr;
@end

@implementation BillMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    //    self.tableView.frame =CGRectMake(0, 80, SCREEN_WIDTH, self.tableView.height - 120-DRTopHeight);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"FirstTableViewCell"];
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
    [self CustomView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideZheGaiBtn) name:@"yinCanZheGai" object:nil];
}
-(void)CustomView
{
    BackVC *vc = [[BackVC alloc]init];
    self.backView.hidden = !self.backView.hidden;
    [vc show];
}
//通知回调
- (void)hideZheGaiBtn{
    self.backView.hidden = !self.backView.hidden;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//YCViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"YCViewController"];
//self.zheGaiView.hidden = !self.zheGaiView.hidden;
//[vc show];
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
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
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
}
-(void)addCustomView
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, 36)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
            return SCREEN_HEIGHT/25;
            break;
        case 1:
        case 2:
            return SCREEN_HEIGHT/30;
            break;
            
        case 3:
            return SCREEN_HEIGHT/25;
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
    return 0.01;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *titleArr =@[@"申请单号：KP-201902-D00002",@"开票方：三块神铁",@"金额：¥202.80"];
    switch (indexPath.row) {
        case 0:
        {
            static NSString *SimpleTableIdentifier = @"cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                     SimpleTableIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier: SimpleTableIdentifier];
                if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                }
                self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
            }
            cell.textLabel.text =titleArr[indexPath.row];
            cell.textLabel.textColor =[UIColor redColor];
            cell.textLabel.font =DR_BoldFONT(14);
            return cell;
        }
            break;
        case 1:
        {
            static NSString *SimpleTableIdentifier = @"cell2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                     SimpleTableIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:1
                                              reuseIdentifier: SimpleTableIdentifier];
                self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
            }
            
            cell.textLabel.text =titleArr[indexPath.row];
            cell.textLabel.textColor =[UIColor blackColor];
            cell.textLabel.font =DR_BoldFONT(12);
            cell.detailTextLabel.text =@"待审核";
            cell.detailTextLabel.textColor =[UIColor redColor];
            cell.detailTextLabel.font =DR_FONT(12);
            
                return cell;
          
        }
            break;
        
        case 2:
        {
            static NSString *SimpleTableIdentifier = @"cell3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                     SimpleTableIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:1
                                              reuseIdentifier: SimpleTableIdentifier];
                self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
            }
            
            cell.textLabel.text =titleArr[indexPath.row];
            cell.textLabel.textColor =[UIColor blackColor];
            cell.textLabel.font =DR_FONT(12);
            cell.detailTextLabel.text =@"2019-02-28";
            cell.detailTextLabel.textColor =[UIColor lightGrayColor];
            cell.detailTextLabel.font =DR_FONT(12);
            
            return cell;
        }
            break;
        
        case 3:
            
        {
            SaleOrderCell2 *cell =[SaleOrderCell2 cellWithTableView:tableView];
            return cell;
        }
            break;
            
        default:
            break;
    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    cell.textLabel.text = [_titleStr stringByAppendingString:[NSString stringWithFormat:@"-%d",(int)indexPath.row]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.navigationController pushViewController:[BillMessageDetailChildVC new] animated:YES];
}
@end
