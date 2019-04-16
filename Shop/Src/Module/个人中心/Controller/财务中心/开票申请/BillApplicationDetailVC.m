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

#import "DetailOrdervc.h"
@interface BillApplicationDetailVC ()<UITableViewDelegate,UITableViewDataSource,ShoppingCarCellDelegate>
{
    int pageCount;
    NSString *idStr;
}

@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,strong) UIButton *selectAllBtn;//全选按钮

@property (nonatomic,strong) UIButton *jieSuanBtn;//结算按钮
@property (nonatomic,strong) UILabel *totalMoneyLab;//总金额
@property (nonatomic,retain)ShoppingModel *model;
@property(nonatomic,assign) float allPrice;
@property (nonatomic,retain)DCUpDownButton *bgTipButton ;
@end

@implementation BillApplicationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    [self.view addSubview:self.bgTipButton];
   _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[self.sendDataDictionary[@"startTime"]?:@"",self.sendDataDictionary[@"endTime"]?:@"",self.sendDataDictionary[@"dzNo"]?:@""] forKeys:@[@"startTime",@"endTime",@"keyWord"]];
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
//    [self initData];
    [self getMsgList];
    [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"FirstTableViewCell"];
//    __weak typeof(self) weakSelf = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (weakSelf.MsgListArr.count) {
//            [weakSelf.MsgListArr removeAllObjects];
//        }
//        pageCount=1;
//        [weakSelf initData];
//        [weakSelf.tableView.mj_header endRefreshing];
//
//    }];
//    [self.tableView.mj_header beginRefreshing];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//        pageCount = pageCount +1;
//        [weakSelf initData];
//    }];
//    [self.tableView.mj_footer endRefreshing];
//    [self initData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"record" object:nil];
//       self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"record"]) {
        NSDictionary *dic =notification.userInfo;
        
        if ([dic[@"index"] intValue]==3) {
            [_sendDataDictionary setObject:dic[@"dzNo"]?:@"" forKey:@"keyWord"];
            
        }else
        {
            [_sendDataDictionary setObject:dic[@"startTime"]?:@"" forKey:@"startTime"];
            [_sendDataDictionary setObject:dic[@"endTime"]?:@"" forKey:@"endTime"];
            
        }
        [self getMsgList];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"record" object:nil];
}
-(void)getMsgList
{
   
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr ;
    if (self.status == 0 || self.status == 3) {
        urlStr = @"buyer/invoiceAbleList";
        if (self.status==0) {
            
            [dic setObject:@"0" forKey:@"status"];
        }
        else
        {
            [dic setObject:@"1" forKey:@"status"];
        }
    }
    else
    {
        if (self.status==1) {
            
            [dic setObject:@"0" forKey:@"status"];
        }
        else
        {
            [dic setObject:@"3" forKey:@"status"];
        }
        urlStr = @"buyer/inReviewInvoice";
    }
    if (page) {
        [dic setObject:@"1" forKey:@"pageNum"];
        [dic setObject:@"10000" forKey:@"pageSize"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    DRWeakSelf;
    [SNIOTTool getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        NSLog(@"data=%@",result.data[@"list"]);
        NSArray *listArr =result.data[@"list"];
        weakSelf.MsgListArr =[NSMutableArray array];
        NSMutableArray *modelArray =[ShoppingModel mj_objectArrayWithKeyValuesArray:[listArr firstObject][@"orderList"]];
        [weakSelf.MsgListArr addObjectsFromArray:modelArray];
        [weakSelf.tableView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
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
//        self.model = [[ShoppingModel alloc]initWithShopDict:infoDict];
//        [self.MsgListArr addObject: self.model];
    }
}
-(void)createSubViews{
    UIView *bottomView =[[UIView alloc]init];
    bottomView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale(0));

        make.bottom.mas_equalTo(WScale(0));
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
        
    }];
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake(10,(50-20)/2.0, 60, 20);
    [self.selectAllBtn setImage:IMAGENAMED(@"Unchecked") forState:UIControlStateNormal];
    [self.selectAllBtn setImage:IMAGENAMED(@"checked") forState:UIControlStateSelected];
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
    DRWeakSelf;
    if (self.allPrice==0.00) {
        return;
    }
    NSDictionary *dic =@{@"ids":idStr};
    [SNIOTTool postWithURL:@"buyer/applyInvoice" parameters:[dic mutableCopy] success:^(SNResult *result) {
        
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            weakSelf.allPrice=0.00;
            [weakSelf getMsgList];
            idStr =nil;
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",weakSelf.allPrice]];
            [str addAttribute:NSFontAttributeName value:DR_FONT(15) range:NSMakeRange(4,str.length-4)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
            weakSelf.totalMoneyLab.attributedText = str;
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
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
     self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.model =self.MsgListArr[indexPath.section];
    if (indexPath.row==0) {
        static NSString *index =@"cell0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
        if (cell==nil) {
            cell =[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
            UIView*  headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HScale(30))];
            headView.backgroundColor=[UIColor whiteColor];
            UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(15, HScale(5), WScale(45), HScale(20))];
            button.titleLabel.font =DR_FONT(14);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button setTitle:@"自营" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
            [button setTitle:@"非自营" forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateSelected];
            button.selected =[self.model.compType boolValue];
            [headView addSubview:button];
            UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(button.dc_right+15, 0, 2*ScreenW/3, HScale(30))];
            headLab.font =DR_FONT(14);
            headLab.textColor =[UIColor blackColor];
            headLab.textAlignment = 0;
            headLab.text=self.model.sellerName;
            [headView addSubview:headLab];
            [cell.contentView addSubview:headView];
        }
        return cell;
    }
    else if (indexPath.row==1)
    {
        static NSString *index =@"cell1";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
        if (cell==nil) {
            cell =[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
        }
        cell.textLabel.text =[NSString stringWithFormat:@"开票方：%@",self.model.fpPartyName];
        cell.textLabel.textColor =[UIColor redColor];
        cell.textLabel.font =DR_FONT(13);
       
        return cell;
    }
    static NSString *cellStr = @"ShopCarCell";
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if(!cell){
        cell = [[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.delegate = self;
    cell.detailBtn.tag =indexPath.section;
    if (self.status==0) {
        cell.checkImg.hidden =NO;
    }
    else
    {
        cell.checkImg.hidden =YES;
    }
    
    cell.selectClickBlock = ^{
         NSLog(@"sender=%ld",indexPath.section);
        DetailOrdervc *detailVC =[[DetailOrdervc alloc]init];
        [self.navigationController pushViewController:detailVC animated:YES];
    };
//    [cell.detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.shoppingModel = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        return 120;
    }
    return HScale(30);
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
            self.allPrice = self.allPrice + [model.realAmt  floatValue];
            if (idStr) {
                
                idStr =[NSString stringWithFormat:@"%@,%@",idStr,model.application_id];
            }
            else
            {
                idStr =  model.application_id ;
            }
        
        }
    }
    //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:DR_FONT(15) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;
    NSLog(@"%f",self.allPrice);
//    self.allPrice = 0.0;
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
@end
