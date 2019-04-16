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
#import "BillMessageDetailModel.h"
#import "BillDetailCell.h"
@interface BillMessageDetailChildVC ()<UITableViewDelegate,UITableViewDataSource,ShoppingCarCellDelegate>
{
    int pageCount;
}

@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)BillMessageDetailModel *detailModel;
@property (nonatomic,retain)DetailListModel *listModel;

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
    //    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //    [self.navigationController.navigationBar setTitleTextAttributes:
    //     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self getMsgList];
    //       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
-(NSMutableArray*)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
-(void)getMsgList
{
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.MessageModel.message_id] forKeys:@[@"id"]];
    [SNIOTTool getWithURL:@"buyer/invoiceRecordInfo" parameters:dic success:^(SNResult *result) {
        if (result.state==200) {
            self.detailModel =[BillMessageDetailModel mj_objectWithKeyValues:result.data];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
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
            return self.detailModel.list.count;
            break;
            
        default:
            break;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titleArr =[NSArray array];
    if (indexPath.section<3) {
        static NSString *index =@"cell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
        if (cell==nil) {
            cell =[[UITableViewCell alloc]initWithStyle:1 reuseIdentifier:index];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section==0) {
           
            titleArr =@[[NSString stringWithFormat:@"开票方：%@",self.detailModel.fpPartyName],[NSString stringWithFormat:@"申请时间：%@",self.detailModel.applyeTime],[NSString stringWithFormat:@"金额：%.2f",self.detailModel.invoiceAmt]];
            cell.textLabel.text =titleArr[indexPath.row];
            cell.textLabel.textColor =[UIColor blackColor];
            cell.textLabel.font =DR_FONT(12);
        }else if (indexPath.section==1)
        {
            titleArr =@[[NSString stringWithFormat:@"发票类型：%@",self.detailModel.invoiceType?@"增值税专用发票":@"增值税普通发票"],[NSString stringWithFormat:@"发票抬头：%@",self.detailModel.title],[NSString stringWithFormat:@"税号：%@",self.detailModel.taxNo],[NSString stringWithFormat:@"注册地址：%@",self.detailModel.invoiceAddress],[NSString stringWithFormat:@"注册电话：%@",self.detailModel.invoiceTel],[NSString stringWithFormat:@"开户行：%@",self.detailModel.bankName],[NSString stringWithFormat:@"银行账户：%@",self.detailModel.bankAccount]];
            cell.textLabel.text =titleArr[indexPath.row];
            cell.textLabel.textColor =[UIColor blackColor];
            cell.textLabel.font =DR_FONT(12);
        }
        else if (indexPath.section==2)
        {
            titleArr =@[[NSString stringWithFormat:@"收票人：%@",self.detailModel.receiverName],[NSString stringWithFormat:@"详细地址：%@",self.detailModel.receiverAddress],[NSString stringWithFormat:@"联系电话：%@",self.detailModel.receiverPhone]];
            cell.textLabel.text =titleArr[indexPath.row];
            cell.textLabel.textColor =[UIColor blackColor];
            cell.textLabel.font =DR_FONT(12);
        }
        return cell;
    }
    self.listModel =[DetailListModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
    BillDetailCell *cell = [BillDetailCell cellWithTableView:tableView];
    cell.listModel = self.listModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)detailBtnClick:(UIButton *)sender
{
    NSLog(@"sender=%ld",(long)sender.tag);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        return 150;
    }
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
    NSArray *titleArray=  @[[NSString stringWithFormat:@"申请单号：%@",self.detailModel.applyNo],@"开票信息",@"收票信息",@"订单信息"];
    label.text =titleArray[section];
    label.font =DR_FONT(15);
    label.textColor = [UIColor redColor];
    [bgView addSubview:label];
    if (section==0) {
        
        UILabel *detaillabel = [[UILabel alloc] init];
        detaillabel.frame = CGRectMake(ScreenW/2, 0, SCREEN_WIDTH/2-15, bgView.frame.size.height);
         NSArray *detailArr =@[@"待审核", @"已通过", @"未通过" ,@"已开票",@"已作废",@"已撤回"];
        detaillabel.text =detailArr[self.detailModel.status];
        detaillabel.font =DR_FONT(14);
        detaillabel.textAlignment =2;
        detaillabel.textColor = [UIColor redColor];
        [bgView addSubview:detaillabel];
    }
    
    return bgView;
}
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
