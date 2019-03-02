//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "BillMessageDetailChildVC.h"
#import "FirstTableViewCell.h"
#import "CollectionCell.h"
#import "UIViewExt.h"
#import "ShoppingCarCell.h"
#import "ShoppingModel.h"
@interface BillMessageDetailChildVC ()<UITableViewDelegate,UITableViewDataSource,ShoppingCarCellDelegate>
{
    int pageCount;
}

@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BillMessageDetailChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"开票记录详情";
    self.view.backgroundColor =BACKGROUNDCOLOR;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.MsgListArr = [[NSMutableArray alloc]init];
    
    //    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //    [self.navigationController.navigationBar setTitleTextAttributes:
    //     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
  
  
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
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
-(void)getMsgList
{
    
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

/**
 * 初始化假数据
 */


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 7;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 6;
            break;
            
        default:
            break;
    }
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArr =[NSArray array];
    static NSString *index =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:1 reuseIdentifier:index];
    }
    if (indexPath.section==0) {
        titleArr =@[@"开票方：三块神铁",@"申请时间：2019-02-28",@"金额：0.00"];
        cell.textLabel.text =titleArr[indexPath.row];
        cell.textLabel.textColor =[UIColor blackColor];
        cell.textLabel.font =DR_FONT(12);
    }else if (indexPath.section==1)
    {
        titleArr =@[@"发票类型：增值税专用发票",@"单位名称：1234567",@"税号：7654321",@"发票类型：增值税专用发票",@"单位名称：1234567",@"税号：7654321",@"发票类型：增值税专用发票",@"单位名称：1234567"];
        cell.textLabel.text =titleArr[indexPath.row];
        cell.textLabel.textColor =[UIColor blackColor];
        cell.textLabel.font =DR_FONT(12);
    }
   else if (indexPath.section==2)
   {
       titleArr =@[@"发票类型：增值税专用发票",@"单位名称：1234567",@"税号：7654321"];
       cell.textLabel.text =titleArr[indexPath.row];
       cell.textLabel.textColor =[UIColor blackColor];
       cell.textLabel.font =DR_FONT(12);
   }else
   {
       titleArr =@[@"发票类型：增值税专用发票",@"单位名称：1234567",@"税号：7654321",@"发票类型：增值税专用发票",@"单位名称：1234567",@"税号：7654321"];
       cell.textLabel.text =titleArr[indexPath.row];
       cell.textLabel.textColor =[UIColor blackColor];
       cell.textLabel.font =DR_FONT(12);
       if (indexPath.row==5) {
           cell.detailTextLabel.text =@"查看详情";
           cell.detailTextLabel.textColor =[UIColor redColor];
           cell.detailTextLabel.font =DR_FONT(15);
           
       }
   }
    return cell;
   
}
-(void)detailBtnClick:(UIButton *)sender
{
    NSLog(@"sender=%ld",(long)sender.tag);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return HScale(30);
}
//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3&&indexPath.row==5) {
        NSLog(@"点点点");
    }
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale(35));
    bgView.backgroundColor = BACKGROUNDCOLOR;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 0, SCREEN_WIDTH-16, bgView.frame.size.height);
    NSArray *titleArray=  @[@"申请单号：KP-201902-D00002",@"开票信息",@"收票信息",@"订单信息"];
    label.text =titleArray[section];
    label.font =DR_FONT(15);
    label.textColor = [UIColor redColor];
    [bgView addSubview:label];
    
    
    return bgView;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return HScale(40);
//}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return HScale(35);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
@end
