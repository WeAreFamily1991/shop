//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "AskSellOutVC.h"
#import "FourthCell.h"
#import "CollectionCell.h"
#import "DetailHeadView.h"
#import "CustomFooterView.h"
#import "HeadView.h"
#import "InfoTableViewCell.h"
#import "CGXPickerView.h"
#import "SelectPhotoView.h"
@interface AskSellOutVC ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
{
    int pageCount;
}
//@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UITableView*  tableView;
@property (weak, nonatomic) IBOutlet UIButton *saleOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBuyBtn;
@property (nonatomic,retain)UIButton *footBtn;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property(nonatomic,strong)NSDictionary* dataDict;
@property(nonatomic,strong)NSArray*  dataArr;
@property(nonatomic,strong)NSMutableArray*   isOpenArr;
@property(nonatomic,strong)NSArray* sectionNameArr;
@property(nonatomic,strong)NSMutableArray * messageArr;
@property(nonatomic,strong)NSMutableArray * resoverArr;
@property(nonatomic,strong)NSMutableArray * peisongArr;
@property(nonatomic,strong)NSMutableArray * payArr;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,retain)DetailHeadView *customHeadView;
@property (nonatomic,retain)GoodModel *goodModel;
@property (nonatomic,retain)NSString *allCountStr,*allMoneyCountStr;
@end

@implementation AskSellOutVC

- (IBAction)btnClick:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"申请售后";
    self.tableView.tableFooterView =self.footerView;
    [self loadSource];
    self.view.backgroundColor =BACKGROUNDCOLOR;
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-50-DRTopHeight) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    //    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[FourthCell class] forCellReuseIdentifier:@"FourthCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
-(void)loadSource
{
    //    _sectionNameArr=@[@"客厅"];
    self.isOpenArr=[[NSMutableArray alloc] init];
    // self.dataDict=@{@"first":firstDataArr,@"second":secondArr,@"third":thirdArr};
    //    self.dataArr=@[firstDataArr];
    //for (int i=0; i<self.dataDict.allKeys.count; i++) {
    
    [self.isOpenArr addObject:@"close"];
    
    [self loadTableView];
    [self addHeadView];
    [self getMsgList];
    
}
-(void)addHeadView
{
    self.customHeadView = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeadView" owner:self options:nil] lastObject];    
    self.tableView.tableHeaderView =self.customHeadView;
}
-(void)getMsgList
{
    DRWeakSelf;
//    NSDictionary *muDIC =@{@"id":self.sellOutModel.order_id,@"orderGoodsId":self.sellOutModel.goodsList};
    [SNIOTTool getWithURL:@"buyer/applyAfterSaleInfo" parameters:self.senderDic success:^(SNResult *result) {
        
        if (result.state==200) {
            NSArray *statusArr =@[@"已取消", @"待审核", @"待付款", @"待发货", @"待收货",@"已完成",@"退货中",@"已退货"];
            weakSelf.sellOutModel =[AskSellOutModel mj_objectWithKeyValues:result.data];
          
           
            self.customHeadView.statusLab.text =statusArr[weakSelf.sellOutModel.status];
            if (self.sellOutModel.status==0) {
                self.customHeadView.statusLab.textColor =[UIColor redColor];
            }
            else
            {
                self.customHeadView.statusLab.textColor =RGBHex(0x00cd00);
            }
            self.customHeadView.orderLab.text =[NSString stringWithFormat:@"订单号：%@",self.sellOutModel.orderNo];
            self.customHeadView.timeLab.text =[NSString stringWithFormat:@"下单时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)self.sellOutModel.createTime]]];
            
            NSArray *contentArr =@[@"尊敬的用户，您的订单已取消！",@"尊敬的用户，请耐心等待审核！", @"尊敬的用户，您的订单未付款，请您先付款！", @"尊敬的用户，您的订单已经审核成功，请您耐心等待发货！", @"尊敬的用户，您的订单已经出库，请您耐心等待！",@"尊敬的用户，您的订单已完成！",@"尊敬的用户，您的订单已经审核成功，请您耐心等待发货！",@"尊敬的用户，您的商品已经退货！"];
            NSArray *imgArr =@[@"cancel", @"checkpending", @"obligation", @"Toshipped", @"topreceived",@"offthestocks",@"Returns",@"returnedgoods"];
            self.customHeadView.contentLab.text =contentArr[self.sellOutModel.status];
            self.customHeadView.iconIMG.image =[UIImage imageNamed:imgArr[self.sellOutModel.status]];
            if (self.sellOutModel.status==0) {
                
                //                [SNTool compareOneDay: [SNTool dateFromString:[NSString stringWithFormat:@"%ld",(long)self.sellOutModel.confirmTime]] withAnotherDay:[SNTool dateFromString:[SNTool ddpGetExpectTimestamp:0 month:0 day:-1]]];
                //                NSLog(@"111%@222%@333%@444%@",[SNTool dateFromString:[NSString stringWithFormat:@"%ld",(long)self.sellOutModel.confirmTime]],[SNTool dateFromString:[NSString stringWithFormat:@"%ld",(long)self.sellOutModel.confirmTime]],[SNTool ddpGetExpectTimestamp:0 month:0 day:-1],[SNTool dateFromString:[SNTool ddpGetExpectTimestamp:0 month:0 day:-1]]);
                
            }
            self.allCountStr=nil;
            self.allMoneyCountStr=nil;
             double i = 0.000f;
            double j =0.000f;
            for (NSDictionary *dic in result.data[@"list"]) {
               
                i+=[dic[@"canReturnQty"] doubleValue];
                j+=[dic[@"canReturnQty"] doubleValue]*[dic[@"price"] doubleValue];
                
                
            }
            self.allCountStr =[NSString stringWithFormat:@"%.3f",i];
            self.allMoneyCountStr=[NSString stringWithFormat:@"%.3f",j];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
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



#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        NSString*  state=[self.isOpenArr objectAtIndex:section];
        if ([state isEqualToString:@"open"])
        {
            // NSString*  key=[self.dataDict.allKeys objectAtIndex:section];
            //   NSArray*  arr=[self.dataDict objectForKey:key];
            //                NSArray*  arr=[self.dataArr objectAtIndex:section];
            return self.sellOutModel.list.count+1;
        }
        return 2;
    }
    else if (section==1)
    {
        return 6;
    }
    return 0;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 40;
    }
    if (indexPath.section==2) {
        return HScale(80);
    }
    
    //    if (indexPath.section==1||indexPath.section==3||indexPath.section==4) {
    //        return HScale(25);
    //    }
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section==0) {
//        return 0.01;
//    }
//    if (section==1) {
//        if (self.sellOutModel.message.length==0) {
//            return 0.01;
//        }
//    }
//    return HScale(35);
    return 0.01;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0&&self.sellOutModel.list.count>1) {
        return 40;
    }
    if (section==1) {
        return HScale(100);
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSString*  state=[self.isOpenArr objectAtIndex:indexPath.section];
        
            if (indexPath.row==0) {
                
                CollectionCell8 *cell =[CollectionCell8 cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.sellOutModel =self.sellOutModel;
                return cell;
            }
            else
            {
                
                if ([state isEqualToString:@"open"])
                {
                      self.goodModel =[GoodModel mj_objectWithKeyValues:self.sellOutModel.list[indexPath.row-1]];
                }
                else
                {
                     self.goodModel =[GoodModel mj_objectWithKeyValues:self.sellOutModel.list[0]];
                }
                FourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FourthCell"];
                cell.goodModel =self.goodModel;
                cell.sellOutModel =self.sellOutModel;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.numberBlock = ^(NSString * _Nonnull numberStr) {
                    self.allCountStr=nil;
                    self.allMoneyCountStr=nil;
                    double i = 0.000f;
                    double j =0.000f;
                    for (NSDictionary *dic in self.sellOutModel.list) {
                        
                        i+=[numberStr doubleValue];
                        j+=[numberStr doubleValue]*[dic[@"price"] doubleValue];
                        
                        
                    }
                    self.allCountStr =[NSString stringWithFormat:@"%.3f",i];
                    self.allMoneyCountStr=[NSString stringWithFormat:@"%.3f",j];
                    //                    [self.tableView reloadData];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
                    
                    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:1];
                    [tableView reloadRowsAtIndexPaths:@[indexPath,indexPath1] withRowAnimation:UITableViewRowAnimationNone];
                    NSLog(@"====%@",self.goodModel.modelCount);
                };
                cell.saleOutClickBlock = ^{
                    
                };
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
           
        }
    
    else
    {
        NSArray *titleArray =[NSArray array];
        NSArray *placeholdArray=[NSArray array];
        titleArray = @[@"退货数量：",@"退货金额：",@"售后类型：",@"退货原因：",@"问题描述：",@"图片上传"];
        placeholdArray= @[@"请输入退货数量",@"请输入退货金额",@"请选择售后类型",@"请选择退货原因",@"请描述具体问题",@"*请上传您的图片，能帮助您更好的解决问题"];
        InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
        if (indexPath.row==2||indexPath.row==3) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        if (indexPath.row==0||indexPath.row==1||indexPath.row==2||indexPath.row==3||indexPath.row==5) {
            cell.contentTF.enabled = NO;
            if (indexPath.row==0||indexPath.row==1) {
                NSArray *countArr=@[self.allCountStr?:@"",self.allMoneyCountStr?:@""];
                cell.contentTF.textColor =[UIColor redColor];
                cell.contentTF.text =countArr[indexPath.row];
            }
        }
       
        
        cell.titleLabel.text = titleArray[indexPath.row];
        cell.titleLabel.font = DR_FONT(14);
        cell.contentTF.placeholder = placeholdArray[indexPath.row];
        cell.contentTF.tag = indexPath.row;
        cell.contentTF.font =DR_FONT(13);
        //        cell.contentTF.text = contentArray[indexPath.row];
        
        [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}
///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    if (indexPath.section==1) {
        if (indexPath.row==2)
        {
            
            [CGXPickerView showStringPickerWithTitle:@"售后类型" DataSource:@[@"退货"] DefaultSelValue:@"退货" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                
            }];
        }
        else
        {
            [CGXPickerView showStringPickerWithTitle:@"退货原因" DataSource:@[@"非品质问题",@"品质问题"] DefaultSelValue:@"" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
            }];
        }
    }
    //    ///选择车型
    //    if (indexPath.row == 2) {
    //
    //    }
    //    ///选择注册时间
    //    else if (indexPath.row == 3)
    //    {
    //
    //
    //    }
    
    
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *bgView = [[UIView alloc] init];
//    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale(35));
//    bgView.backgroundColor = BACKGROUNDCOLOR;
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(15, 0, SCREEN_WIDTH-16, bgView.frame.size.height);
//    NSArray *titleArray =[NSArray array];
//    if (self.sellOutModel.message.length!=0) {
//        titleArray =  @[@"",@"订单留言",@"收货信息",@"配送信息",@"支付信息"];
//    }else
//    {
//        titleArray =  @[@"",@"",@"收货信息",@"配送信息",@"支付信息"];
//    }
//
//    label.text =titleArray[section];
//    label.font =DR_BoldFONT(15);
//    label.textColor = [UIColor blackColor];
//    [bgView addSubview:label];
//    return bgView;
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section==1) {
//        HeadView *headView = [HeadView headViewWithTableView:tableView];
//
////        headView.bgBtnBlock = ^(BOOL bgBtnSelectBlock) {
////            self.isSelected =bgBtnSelectBlock;
////            [self.tableView reloadData];
////        };
//
////        headView.titleGroup = self.answersArray[section];
//
//        return headView;
//    }
//    return nil;
//}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0&&self.sellOutModel.list.count>1) {
        UIView*  sectionBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        sectionBackView.backgroundColor=[UIColor whiteColor];
        UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        button.tag=100+section;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"open"]) {
            [button setImage:[UIImage imageNamed:@"arrow_down_grey"] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"收起全部(%lu)",(unsigned long)self.sellOutModel.list.count] forState:UIControlStateNormal];
        }
        else if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"close"]) {
            [button setImage:[UIImage imageNamed:@"arrow_right_grey"] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"查看全部(%lu)",(unsigned long)self.sellOutModel.list.count] forState:UIControlStateNormal];
        }
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        [button addTarget:self action:@selector(ClickSection:) forControlEvents:UIControlEventTouchUpInside];
        [sectionBackView addSubview:button];
        return sectionBackView;
    }
    if (section==1) {
        SelectPhotoView *selectView =[[SelectPhotoView alloc]init];
        return selectView;
    }
    return nil;
}
-(void)ClickSection:(UIButton*)sender
{
    NSString*  state=[self.isOpenArr objectAtIndex:sender.tag-100];
    if ([state isEqualToString:@"open"]) {
        state=@"close";
    }else
    {
        state=@"open";
    }
    self.isOpenArr[sender.tag-100]=state;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag-100];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    [self.sourDic setValue:textField.text forKey:[NSString stringWithFormat:@"%ld",textField.tag]];
    //    if (textField.tag == 1) {
    //        self.so
    //        self.userModel.user_name = textField.text;
    //    }
    //    else if (textField.tag == 2)
    //    {
    //        self.userModel.user_mobile = textField.text;
    //    }
    //    else if (textField.tag == 3)
    //    {
    //        self.userModel.user_comany = textField.text;
    //    }
    //    else if (textField.tag == 4)
    //    {
    //        self.userModel.user_address = textField.text;
    //    }
    //    else if (textField.tag == 5)
    //    {
    //        self.userModel.company_phone = textField.text;
    //    } else if (textField.tag == 6)
    //    {
    //        self.userModel.user_contacts = textField.text;
    //    }
    //    else if (textField.tag == 7)
    //    {
    //        self.userModel.user_phone = textField.text;
    //    }
}

@end
