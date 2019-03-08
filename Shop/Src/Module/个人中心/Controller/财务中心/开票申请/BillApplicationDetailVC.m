//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "BillApplicationDetailVC.h"
#import "FirstTableViewCell.h"
#import "CollectionCell.h"
#import "UIViewExt.h"
#import "ShoppingCarCell.h"
#import "ShoppingModel.h"
@interface BillApplicationDetailVC ()<UITableViewDelegate,UITableViewDataSource,ShoppingCarCellDelegate>
{
    int pageCount;
}
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,strong) UIButton *selectAllBtn;//全选按钮

@property (nonatomic,strong) UIButton *jieSuanBtn;//结算按钮
@property (nonatomic,strong) UILabel *totalMoneyLab;//总金额

@property(nonatomic,assign) float allPrice;
@end

@implementation BillApplicationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    
//    self.tableView.frame =CGRectMake(0, 80, SCREEN_WIDTH, self.tableView.height - 120-DRTopHeight);
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    self.allPrice = 0.00;
    if (self.status==0) {
        self.tableView.height =self.tableView.height-60;
        [self createSubViews];
    }
    [self initData];
    [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"FirstTableViewCell"];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.MsgListArr.count) {
            [weakSelf.MsgListArr removeAllObjects];
        }
        pageCount=1;
        [weakSelf initData];
        [weakSelf.tableView.mj_header endRefreshing];

    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        pageCount = pageCount +1;
        [weakSelf initData];
    }];
    [self.tableView.mj_footer endRefreshing];
//       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
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

-(void)initData{
    for (int i = 0; i<3; i++)
    {
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:@"单据编码：XD-00005-201902-D00019" forKey:@"order"];
        [infoDict setValue:@"单据时间：2019/2/19 10:44:52" forKey:@"time"];
        [infoDict setValue:@"单据金额：￥0.00" forKey:@"orderPrice"];
        [infoDict setValue:@"退货金额：￥0.00" forKey:@"backPrice"];
         [infoDict setValue:@"可开票金额：￥1.01" forKey:@"number"];
        [infoDict setValue:@"可开票" forKey:@"typeRight"];
        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
        [infoDict setValue:[NSNumber numberWithInt:1] forKey:@"goodsNum"];
        ShoppingModel *goodsModel = [[ShoppingModel alloc]initWithShopDict:infoDict];
        [self.MsgListArr addObject:goodsModel];
    }
}
-(void)createSubViews{
    UIView *bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.height-60, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bottomView];
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake(10,(50-20)/2.0, 60, 20);
    [self.selectAllBtn setImage:IMAGENAMED(@"check_n") forState:UIControlStateNormal];
    [self.selectAllBtn setImage:IMAGENAMED(@"check_p") forState:UIControlStateSelected];
    [self.selectAllBtn addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectAllBtn.titleLabel.font = DR_FONT(14.0);
    self.selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [bottomView addSubview:self.selectAllBtn];
    
    self.totalMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(self.selectAllBtn.right+10, self.selectAllBtn.top, kScreenWidth-self.selectAllBtn.right-30-WScale(90),20)];
    self.totalMoneyLab.textAlignment = NSTextAlignmentCenter;
    self.totalMoneyLab.font = DR_FONT(13.0);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:DR_FONT(14) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;
    [bottomView addSubview:self.totalMoneyLab];
    
    self.jieSuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jieSuanBtn.frame = CGRectMake(SCREEN_WIDTH-WScale(90)-10,10,WScale(90), 30);
    [self.jieSuanBtn setBackgroundColor:[UIColor redColor]];
    [self.jieSuanBtn addTarget:self action:@selector(jieSuanAction) forControlEvents:UIControlEventTouchUpInside];
    self.jieSuanBtn.layer.masksToBounds = YES;
    self.jieSuanBtn.layer.cornerRadius = 15;
    [self.jieSuanBtn setTitle:@"确认申请" forState:UIControlStateNormal];
    [self.jieSuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.jieSuanBtn.titleLabel.font = DR_FONT(14.0);
    self.jieSuanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [bottomView addSubview:self.jieSuanBtn];
    
}
//结算
-(void)jieSuanAction{
    NSLog(@"结算");
}

//全选
-(void)selectAllaction:(UIButton *)sender{
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        sender.selected = YES;
    }else{
        sender.selected = NO;
    }
    //改变单元格选中状态
    for (int i=0; i<self.MsgListArr.count;i++)
    {
        ShoppingModel *model = self.MsgListArr[i];
        model.selectState = sender.tag;
    }
    [self CalculationPrice];
    [self.tableView reloadData];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.MsgListArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        CollectionCell7 *cell =[CollectionCell7 cellWithTableView:tableView];
        return cell;
    }
    else if (indexPath.row==1)
    {
        static NSString *index =@"cell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
        if (cell==nil) {
            cell =[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
        }
        cell.textLabel.text =@"开票方：三块神铁";
        cell.textLabel.textColor =[UIColor redColor];
        cell.textLabel.font =DR_FONT(12);
        return cell;
    }
    static NSString *cellStr = @"ShopCarCell";
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if(!cell){
        cell = [[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.delegate = self;
    cell.detailBtn.tag =indexPath.section;
    [cell.detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.shoppingModel = self.MsgListArr[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)detailBtnClick:(UIButton *)sender
{
    NSLog(@"sender=%ld",(long)sender.tag);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        return 120;
    }
    return 40;
}
//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     * 判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    ShoppingModel *model = self.MsgListArr[indexPath.section];
    if (model.selectState)
    {
        model.selectState = NO;
    }
    else
    {
        model.selectState = YES;
    }
    //刷新当前行
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self CalculationPrice];
}
//#pragma mark -- 实现加减按钮点击代理事件
///**
// * 实现加减按钮点击代理事件
// *
// * @param cell 当前单元格
// * @param flag 按钮标识，11 为减按钮，12为加按钮
// */
//-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
//{
//    NSIndexPath *index = [self.tableView indexPathForCell:cell];
//    switch (flag) {
//        case 11:
//        {
//            //做减法
//            //先获取到当期行数据源内容，改变数据源内容，刷新表格
//            ShoppingModel *model = self.MsgListArr[index.section];
//            if (model.goodsNum > 1)
//            {
//                model.goodsNum --;
//            }
//        }
//            break;
//        case 12:
//        {
//            //做加法
//            ShoppingModel *model = self.MsgListArr[index.section];
//            model.goodsNum ++;
//        }
//            break;
//        default:
//            break;
//    }
//    //刷新表格
//    [self.tableView reloadData];
//    //计算总价
//    [self CalculationPrice];
//}
//计算价格
-(void)CalculationPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    for ( int i =0; i<self.MsgListArr.count;i++)
    {
        ShoppingModel *model = self.MsgListArr[i];
        if (model.selectState)
        {
            self.allPrice = self.allPrice + [[model.number substringWithRange:NSMakeRange(7,model.number.length-7)] floatValue];
        }
    }
    //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:DR_FONT(15) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;
    NSLog(@"%f",self.allPrice);
    self.allPrice = 0.0;
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
@end
