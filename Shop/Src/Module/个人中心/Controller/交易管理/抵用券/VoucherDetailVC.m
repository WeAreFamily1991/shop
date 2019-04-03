//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "VoucherDetailVC.h"
#import "CollectionCell.h"
#import "VoucherModel.h"
@interface VoucherDetailVC ()
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,retain)VoucherModel *VouchModel;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@end

@implementation VoucherDetailVC
-(NSMutableArray *)MsgListArr
{
    if ((!_MsgListArr)) {
        _MsgListArr=[NSMutableArray array];
    }
    return _MsgListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgTipButton];
    self.view.backgroundColor =BACKGROUNDCOLOR;
//    self.tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height);
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
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
        _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%ld",self.status+1]] forKeys:@[@"status"]];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr =@"buyer/myVoucher";
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
        [dic setObject:@"10" forKey:@"pageSize"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    if (self.status==0) {
        [dic setObject:@"" forKey:@"status"];
    }
    DRWeakSelf;
    [SNIOTTool getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        NSLog(@"data=%@",result.data[@"list"]);
        NSMutableArray*addArr=result.data[@"list"];
        NSMutableArray *modelArray =[VoucherModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
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
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return SCREEN_HEIGHT/9;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return self.MsgListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    CollectionCell1 *cell =[CollectionCell1 cellWithTableView:tableView];
    if (self.MsgListArr.count!=0) {
        self.VouchModel =self.MsgListArr[indexPath.row];
        cell.vouchModel =self.VouchModel;
        if (self.status==0) {
            if (self.VouchModel.topicType==0) {
                cell.iconBackIMG.image =[UIImage imageNamed:@"平台抵用券"];
                cell.statusBtn.selected =NO;
            }else
            {
                cell.iconBackIMG.image =[UIImage imageNamed:@"店铺券"];                
                cell.statusBtn.selected =YES;
            }
            [cell.statusBtn setTitle:@"去使用" forState:UIControlStateNormal];
            cell.selectlickBlock = ^{
                
            };
            cell.hidenBtn.hidden =YES;
        }
        else if (self.status==1)
        {
            cell.iconBackIMG.image =[UIImage imageNamed:@"我的抵用券_06"];
            [cell.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg-over"] forState:UIControlStateNormal];
            [cell.statusBtn setTitle:@"已使用" forState:UIControlStateNormal];
            cell.hidenBtn.selected =NO;
            cell.hidenBtn.hidden =NO;
        }
        else
        {
            cell.iconBackIMG.image =[UIImage imageNamed:@"我的抵用券_06"];
            [cell.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg-over"] forState:UIControlStateNormal];
            [cell.statusBtn setTitle:@"已过期" forState:UIControlStateNormal];
            cell.hidenBtn.selected =YES;
            cell.hidenBtn.hidden =NO;
        }
    }
    if (self.status!=0) {
        cell.titleLab.textColor =[UIColor lightGrayColor];
        cell.timeLab.textColor =[UIColor lightGrayColor];
        cell.conditionLab.textColor =[UIColor lightGrayColor];
    }
    return cell;
    
    
}
@end
