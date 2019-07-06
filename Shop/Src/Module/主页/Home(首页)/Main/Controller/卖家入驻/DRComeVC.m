//
//  DRComeVC.m
//  Shop
//
//  Created by BWJ on 2019/4/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRComeVC.h"
#import "DRSellerCell.h"
#import "DRComeModel.h"
#import "InfoTableViewCell.h"
#import "GHAttributesLabel.h"
#import "CGXPickerView.h"
#import "ListSelectView.h"
#import "ZJBLTimerButton.h"
#import "SNAPIManager.h"
#import "LSXAlertInputView.h"
#import "DRComView.h"
@interface DRComeVC ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSDictionary* dataDict;
@property(nonatomic,strong)NSMutableDictionary* muDataDic;
@property(nonatomic,strong)NSArray*  dataArr;
@property(nonatomic,strong)NSArray<DRComeModel*>*sourceArr;
@property(nonatomic,strong)NSMutableArray*   isOpenArr;
@property(nonatomic,strong)NSArray* sectionNameArr;
@property(nonatomic,strong)NSString *contactStr,*mobileStr,*imgCodeStr,*numCodeStr,*companyNameStr,*tongyiStr,*compAddressStr,*compAddressIDStr,*detailAddressStr,*compTypeStr,*compTypeIDStr,*fapiaoStr,*shuihaoStr,*bankTypeStr,*bankIDTypeStr,*bankNumStr,*numTypeStr,*numTypeIDStr,*numNameStr,*provinceStr,*provinceIDStr,*cityIDStr,*imgStr;
@end

@implementation DRComeVC
-(NSMutableDictionary *)muDataDic
{
    if (_muDataDic) {
        _muDataDic =[NSMutableDictionary dictionaryWithObjects:@[] forKeys:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    }
    return _muDataDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"卖家入驻";
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
  
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"DRSellerCell" bundle:nil] forCellReuseIdentifier:@"DRSellerCell"];
    [self GetNews];
    [self addTableViewHeaderView];
    [self addTableViewfooterView];
    // Do any additional setup after loading the view from its nib.
}
-(void)addTableViewHeaderView
{
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HScale(40))];
    headerView.backgroundColor =[UIColor clearColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, HScale(40))];
    titleLab.font = DR_BoldFONT(14);
    titleLab.textAlignment = 1;
    titleLab.numberOfLines =1;
    titleLab.textColor =[UIColor grayColor];
    titleLab.text =@"————  寻求渴望成功的伙伴加入我们  ————";
    [headerView addSubview:titleLab];
    
//    UILabel *bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(0, HScale(40), ScreenW, HScale(30))];
//    bottomLab.font = DR_FONT(12);
//    bottomLab.textAlignment = 1;
//    bottomLab.numberOfLines =1;
//    bottomLab.textColor =REDCOLOR;
//    bottomLab.text =@"寻求渴望成功的伙伴加入我们";
//    [headerView addSubview:bottomLab];
    self.tableView.tableHeaderView =headerView;
}

-(void)addTableViewfooterView
{
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HScale(80))];
    headerView.backgroundColor =[UIColor clearColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW-30, HScale(30))];
    titleLab.font = DR_BoldFONT(12);
    titleLab.textAlignment = 0;
    titleLab.numberOfLines =0;
    titleLab.textColor =[UIColor grayColor];
    titleLab.text =@"感谢您关注三块神铁，如您有入驻意向，请填写并提交以上内容，我们的工作人员将及时与您联系。";
    [headerView addSubview:titleLab];
    
    GHAttributesLabel *attributesLabel = [[GHAttributesLabel alloc]initWithFrame:CGRectMake(15, HScale(30), SCREEN_WIDTH - 30, HScale(40))];
    attributesLabel.font =DR_FONT(13);
    NSString *temp = @"热线电话：0573-83108631";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:temp];
    
    NSString *actionStr = @"0573-83108631";
    NSRange range = [temp rangeOfString:actionStr];
    
    NSLog(@"range%@",NSStringFromRange(range));
    [attrStr addAttribute:NSLinkAttributeName
                    value:actionStr
                    range: range];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:DR_FONT(14)
                    range:NSMakeRange(0, attrStr.length)];
    
    attributesLabel.actionBlock = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0573-83108631"]];
    };
    
    [attributesLabel setAttributesText:attrStr actionText:actionStr];
    
    [headerView addSubview:attributesLabel];
    self.tableView.tableFooterView =headerView;
}
-(void)GetNews
{
    NSDictionary *dic =@{@"advType":@"mobileSellerRegisterImg",@"pageNum":@"1",@"pageSize":@"10"};
    [SNAPI getWithURL:@"mainPage/getAdvList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.sourceArr =[NSArray array];
             self.sourceArr =[DRComeModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            _sectionNameArr=@[@"卖家入驻联系热线",@"填写入驻申请"];
            self.isOpenArr=[[NSMutableArray alloc] init];
            NSArray *titleArr=@[@"联系人",@"手机号",@"图文验证",@"手机验证",@"公司名称",@"统一社会信用代码",@"公司所在地",@"详细地址",@"公司类型",@"营业执照",@"发票抬头",@"税号",@"开户行",@"银行账号",@"账户类型",@"账户名称",@"省市"];
            self.dataArr=@[self.sourceArr,titleArr];
            for (int i=0; i<self.dataArr.count; i++) {
                NSString*  state=@"open";
                [self.isOpenArr addObject:state];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)addSource
{
    [self.tableView reloadData];
}
-(void)ClickSection:(UIButton*)sender
{
    if (sender.tag==99) {
        LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"入驻申请进度" PlaceholderText:@"请输入手机号码" WithKeybordType:LSXKeyboardTypeNamePhonePad CompleteBlock:^(NSString *contents) {
            NSLog(@"-----%@",contents);
            [self getAddJINDUwithMobile:contents];
        }];
        [alert show];
    }else
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
}
-(void)getAddJINDUwithMobile:(NSString *)mobile
{
    NSDictionary *dic =@{@"mobile":mobile};
    [SNAPI getWithURL:@"seller/registerSchedule4Mobile" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            if ([[NSString stringWithFormat:@"%@",result.data[@"status"]] isEqualToString:@"500"])
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"您还没有申请入驻，赶紧填写信息入驻吧~" preferredStyle:UIAlertControllerStyleAlert];
                //            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
                //            [alert addAction:cancelAction];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }else
            {
                DRComView *comView = [[[NSBundle mainBundle] loadNibNamed:@"DRComView" owner:self options:nil] lastObject];
                comView.frame =CGRectMake(0, 0,ScreenW,ScreenH-DRTopHeight);
                if ([result.data[@"status"] intValue]==0||[result.data[@"status"] intValue]==2) {
                    comView.threeIconbTN.selected =NO;
                    comView.thretitleBtn.selected =YES;
                    comView.threeContentBtn.selected =YES;
                }
                else if ([result.data[@"status"] intValue]==4)
                {
                    comView.threeIconbTN.selected =YES;
                    comView.thretitleBtn.selected =NO;
                    comView.threeContentBtn.selected =NO;
                }else if ([result.data[@"status"] intValue]==1||[result.data[@"status"] intValue]==3)
                {
                    comView.threeIconbTN.selected =NO;
                    comView.thretitleBtn.selected =YES;
                    comView.threeContentBtn.selected =YES;
                    [comView.thretitleBtn setTitle:@"申请被驳回，入驻失败！" forState:UIControlStateSelected];
                    [comView.threeContentBtn setTitle:result.data[@"reason"] forState:UIControlStateSelected];
                }
                comView.closeBtnBlock = ^{
                    
                    [comView removeFromSuperview];
                };
                [self.view addSubview:comView];
                
            }
//            self.bannerArr=[NSMutableArray array];
//            //             NSArray *sourceArr =result.data;
//            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
//            for (NewsModel *model in sourceArr) {
//                [self.bannerArr addObject:model.img];
//            }
//            if (self.bannerArr.count!=0) {
//                weakSelf.cycleScrollView.imageURLStringsGroup =self.bannerArr.copy;
//            }
        }
       
    
            
    } failure:^(NSError *error) {
       
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return self.dataDict.allKeys.count;
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString*  state=[self.isOpenArr objectAtIndex:section];
    if ([state isEqualToString:@"open"]) {
        // NSString*  key=[self.dataDict.allKeys objectAtIndex:section];
        //   NSArray*  arr=[self.dataDict objectForKey:key];
        NSArray*  arr=[self.dataArr objectAtIndex:section];
        return arr.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        DRSellerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DRSellerCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.comModel=self.dataArr[indexPath.section][indexPath.row];
        //    cell.dic = _data[indexPath.row];
        return cell;
    }else
    {
        if (indexPath.row==9) {
            InfoTableViewCell4 *cell = [InfoTableViewCell4 cellWithTableView:tableView];
            NSString *tagStr = [NSString stringWithFormat:@"%ld%@",indexPath.row-3,@"1"];
            cell.photoBtn.tag = [tagStr intValue];
            cell.titleLabel.text =@"营业执照";
            [cell.photoBtn addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
            id imgStr1 = [DRBuyerModel sharedManager].yingyeLogo?:@"default_head";
            if (![imgStr1 isEqualToString:@"default_head"]) {
                [cell.photoBtn sd_setImageWithURL:[NSURL URLWithString:[DRBuyerModel sharedManager].yingyeLogo] forState:UIControlStateNormal];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
//            titleArray = @[@"手机号：",@"公司名称：",@"公司地址：",@"联系人：",@"固定电话：",@"手机号码："];
//            placeholdArray= @[@"请输入手机号",@"请输入公司名称",@"请输入公司地址",@"请输入联系人",@"请输入固定电话",@"请输入手机号码"];
//            NSArray *contentArray = @[[DRBuyerModel sharedManager].mobilephone?:@"",[DRBuyerModel sharedManager].name?:@"",[DRBuyerModel sharedManager].companyAddress?:@"",[DRBuyerModel sharedManager].cName?:@"",[DRBuyerModel sharedManager].cTel?:@"",[DRBuyerModel sharedManager].cPhone?:@""];
            InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
            self.tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
            //           self.dataArr[indexPath.section][indexPath.row];
            cell.titleLabel.text =self.dataArr[indexPath.section][indexPath.row];
            cell.titleLabel.font = DR_FONT(15);
            NSArray *contentArr=@[@"请输入联系人",@"请输入手机号",@"请输入图文验证",@"请输入手机验证",@"请输入公司名称",@"统一社会信用代码",@"请选择公司所在地",@"请输入详细地址",@"请选择公司类型",@"",@"请输入发票抬头",@"请输入税号",@"请选择开户行",@"请输入银行账号",@"请选择账户类型",@"请输入账户名称",@"请选择省市"];
            NSArray *contentTextArr=@[self.contactStr?:@"",self.mobileStr?:@"",self.imgCodeStr?:@"",self.numCodeStr?:@"",self.companyNameStr?:@"",self.tongyiStr?:@"",self.compAddressStr?:@"",self.detailAddressStr?:@"",self.compTypeStr?:@"",@"",self.fapiaoStr?:@"",self.shuihaoStr?:@"",self.bankTypeStr?:@"",self.bankNumStr?:@"",self.numTypeStr?:@"",self.numNameStr?:@"",self.provinceStr?:@""];
            cell.contentTF.placeholder = contentArr[indexPath.row];
            cell.contentTF.tag = indexPath.row;
            cell.contentTF.delegate =self;
            cell.contentTF.text = contentTextArr[indexPath.row];
            cell.contentTF.textAlignment =0;
            [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
            if (indexPath.row==6||indexPath.row==8||indexPath.row==12||indexPath.row==14||indexPath.row==16)
            {
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.contentTF.enabled =NO;
            }
            if (indexPath.row==2) {
                UIButton *imgCodeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
                imgCodeBtn.frame =CGRectMake(WScale(255), HScale(5), WScale(100), HScale(30));
               
                self.imgStr =[self acdomURLStr];
                [imgCodeBtn sd_setImageWithURL:[NSURL URLWithString:self.imgStr] forState:UIControlStateNormal];
                [imgCodeBtn addTarget:self action:@selector(imgCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:imgCodeBtn];
                
            }
            if (indexPath.row==3) {
                //时间按钮
                ZJBLTimerButton *TimerBtn = [[ZJBLTimerButton alloc] initWithFrame:CGRectMake(WScale(255), HScale(5), WScale(100), HScale(30))];
                __weak typeof(self) WeakSelf = self;
                TimerBtn.phoneStr =self.mobileStr;
                TimerBtn.imgCodeStr =self.imgCodeStr;
                TimerBtn.countDownButtonBlock = ^{
                    [WeakSelf qurestCode]; //开始获取验证码
                };
                [cell.contentView addSubview:TimerBtn];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}
-(NSString *)acdomURLStr
{
    NSString *tokenStr;
    if ([User currentUser].isLogin) {
        tokenStr =[User currentUser].token;
    }
    else{
        tokenStr =[DEFAULTS objectForKey:@"visitetoken"];
    }
    NSString *urlStr =[NSString stringWithFormat:@"%@%@?santieJwt=%@&%d",[SNAPIManager shareAPIManager].baseURL,@"openStResouces/getValidCode",tokenStr,[SNTool getRandomNumber:1000 to:9999]];
    return urlStr;
    
}
-(void)imgCodeBtnClick:(UIButton *)sender
{
    self.imgStr =[NSString stringWithFormat:@"%@%@?santieJwt=%@&%d",[SNAPIManager shareAPIManager].baseURL,@"openStResouces/getValidCode",[DEFAULTS objectForKey:@"visitetoken"],[SNTool getRandomNumber:1000 to:9999]];
    NSLog(@"wwwww+%d",[SNTool getRandomNumber:1000 to:9999]);
    [sender sd_setImageWithURL:[NSURL URLWithString:self.imgStr] forState:UIControlStateNormal];
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    
    if (textField.tag == 0)
    {
        self.contactStr = textField.text;
    }
    else if (textField.tag == 1)
    {
       self.mobileStr = textField.text;
    }
    else if (textField.tag == 2)
    {
        self.imgCodeStr = textField.text;
    }
    else if (textField.tag == 3)
    {
        self.numCodeStr = textField.text;
    } else if (textField.tag == 4)
    {
        self.companyNameStr = textField.text;
    }
    else if (textField.tag == 5)
    {
        self.tongyiStr = textField.text;
    }
//    else if (textField.tag == 6)
//    {
//        self.compAddressStr = textField.text;
//    }
    else if (textField.tag == 7)
    {
        self.detailAddressStr = textField.text;
    }
    else if (textField.tag == 10)
    {
        self.fapiaoStr = textField.text;
    } else if (textField.tag == 11)
    {
        self.shuihaoStr = textField.text;
    }
    else if (textField.tag == 13)
    {
        self.bankNumStr = textField.text;
    }
    else if (textField.tag == 15)
    {
        self.numNameStr = textField.text;
    }
    
    
    
    
}
//发生网络请求 --> 获取验证码
- (void)qurestCode {
    if (self.mobileStr.length==0||self.mobileStr.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    if (self.imgCodeStr.length==0||self.imgCodeStr.length!=4) {
        [MBProgressHUD showError:@"请输入正确的图文验证码"];
        return;
    }
    //    DRWeakSelf;
    [SNAPI commonMessageValidWithMobile:self.mobileStr validCode:self.imgCodeStr success:^(NSString *response) {
        if ([response isEqualToString:@"200"]) {
            [MBProgressHUD showError:@"验证码已发送"];
        }
    } failure:^(NSError *error) {
        
    }] ;
    NSLog(@"发生网络请求 --> 获取验证码");
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==9) {
            return HScale(80);
        }
        return HScale(40);
    }
    return HScale(70);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==6||indexPath.row==8||indexPath.row==12||indexPath.row==14||indexPath.row==16) {
        if (indexPath.row==6) {
            [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
                self.compAddressStr =[NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                self.compAddressIDStr =[NSString stringWithFormat:@"%@/%@/%@", selectAddressArr[3], selectAddressArr[4],selectAddressArr[5]];
                
                [self releadWithRow:6];
            }];
        }
        if (indexPath.row==8) {
            [CGXPickerView showStringPickerWithTitle:@"请选择公司类型" DataSource:@[@"厂家", @"批发商"] DefaultSelValue:@"厂家" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                self.compTypeStr = selectValue;
               [self releadWithRow:8];
            }];
        }
        if (indexPath.row==12) {
            ListSelectView *select_view = [[ListSelectView alloc] initWithFrame:self.view.bounds];
            select_view.choose_type = MORECHOOSETITLETYPE;
            select_view.isShowCancelBtn = YES;
            select_view.isShowSureBtn = YES;
            select_view.isShowTitle = YES;
            NSArray *arr= @[@"one",@"two",@"three",@"four",@"five",@"six"];
            [select_view addTitleArray:arr andTitleString:@"标题" animated:YES completionHandler:^(NSString * _Nullable string, NSString * _Nullable IDString) {
                self.bankTypeStr=string;
                self.bankIDTypeStr =IDString;
              [self releadWithRow:12];
//                [sender setTitle:string forState:UIControlStateNormal];
                NSLog(@"%@------%ld",string,(long)index);
            } withSureButtonBlock:^{
                NSLog(@"sure btn");
            }];
            [self.view addSubview:select_view];
        }
        if (indexPath.row==14) {
            [CGXPickerView showStringPickerWithTitle:@"请选择账户类型" DataSource:@[@"个人", @"企业"] DefaultSelValue:@"个人" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                self.numTypeStr = selectValue;
               [self releadWithRow:14];
            }];
        }
        if (indexPath.row==16) {
            [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
                NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
                self.provinceStr =[NSString stringWithFormat:@"%@%@", selectAddressArr[0], selectAddressArr[1]];
                self.provinceIDStr =selectAddressArr[3];
                self.cityIDStr=selectAddressArr[4];
                [self releadWithRow:16];
                //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@", selectAddressArr[0], selectAddressArr[1]];
            }];
        }
        
    }
}
-(void)releadWithRow:(NSInteger)row
{
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* sectionBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    sectionBackView.backgroundColor=BACKGROUNDCOLOR;
    UIView* backView=[[UIView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 50)];
    backView.backgroundColor=WHITECOLOR;
    UIImageView*  lineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    [lineImageView setImage:[UIImage imageNamed:@"Google模糊灰.png"]];
    [backView addSubview:lineImageView];
    UILabel*  nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH/2, 50)];
    nameLabel.text=[_sectionNameArr objectAtIndex:section];
    nameLabel.font =DR_BoldFONT(16);
    [backView addSubview:nameLabel];
    UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 5, SCREEN_WIDTH-10, 40)];
    button.tag=100+section;
    [backView addSubview:button];
    UILabel*  numLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, 0, 80, 50)];
//    NSArray* subArr=[_dataArr objectAtIndex:section];
    numLabel.textAlignment =NSTextAlignmentRight;
    numLabel.font =DR_FONT(13);
    if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"open"]) {
        numLabel.text=@"收起";
    }
    else if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"close"]) {
        numLabel.text=@"展开";
    }
   
    [backView addSubview:numLabel];
    UIImageView* stateImage=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 20, 15, 8)];
    if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"open"]) {
        [stateImage setImage:[UIImage imageNamed:@"sectionOpen"]];
    }
    else if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"close"]) {
        [stateImage setImage:[UIImage imageNamed:@"sectionClose"]];
    }
    if (section==1) {
         [stateImage setImage:[UIImage imageNamed:@"right_ico"]];
        stateImage.frame =CGRectMake(SCREEN_WIDTH-30, 17.5, 10, 15);
         numLabel.text=@"查看申请进度";
        button.tag=99;
    }
     [button addTarget:self action:@selector(ClickSection:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:stateImage];
    [sectionBackView addSubview:backView];
    return sectionBackView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return [UIView new];
    }
    UIView* sectionBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HScale(50))];
    sectionBackView.backgroundColor=BACKGROUNDCOLOR;
    UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(20, HScale(5), SCREEN_WIDTH-40, HScale(40))];
//    button.tag=100+section;
    button.backgroundColor =REDCOLOR;
    button.layer.cornerRadius =HScale(20);
     button.layer.masksToBounds =HScale(20);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.titleLabel.font =DR_FONT(15);
//    [button setBackgroundImage:[UIImage imageNamed:@"sure-btn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sectionBackView addSubview:button];
    return sectionBackView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
      return  HScale(50);
    }
    return 10;
}
-(void)submitBtnClick:(UIButton *)sender
{
    if (self.contactStr.length==0) {
        [MBProgressHUD showError:@"请输入联系人"];
        return;
    }
    if (self.mobileStr.length==0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (self.imgCodeStr.length==0) {
        [MBProgressHUD showError:@"请输入图文验证"];
        return;
    }
    if (self.numCodeStr.length==0) {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    if (self.companyNameStr.length==0) {
        [MBProgressHUD showError:@"请输入公司名称"];
        return;
    }
    if (self.tongyiStr.length==0) {
        [MBProgressHUD showError:@"请输入统一社会信用代码"];
        return;
    }
    if (self.compAddressStr.length==0) {
        [MBProgressHUD showError:@"请选择公司所在地"];
        return;
    }
    if (self.detailAddressStr.length==0) {
        [MBProgressHUD showError:@"请输入详细地址"];
        return;
    }
    if (self.compTypeStr.length==0) {
        [MBProgressHUD showError:@"请选择公司类型"];
        return;
    }
    if (self.fapiaoStr.length==0) {
        [MBProgressHUD showError:@"请输入发票抬头"];
        return;
    }
    if (self.shuihaoStr.length==0) {
        [MBProgressHUD showError:@"请输入税号"];
        return;
    }
    if (self.bankTypeStr.length==0) {
        [MBProgressHUD showError:@"请选择开户行"];
        return;
    }
    if (self.bankNumStr.length==0) {
        [MBProgressHUD showError:@"请输入银行账号"];
        return;
    }
    if (self.numTypeStr.length==0) {
        [MBProgressHUD showError:@"请选择账户类型"];
        return;
    }
    if (self.numNameStr.length==0) {
        [MBProgressHUD showError:@"请输入账户名"];
        return;
    }
    if (self.provinceStr.length==0) {
        [MBProgressHUD showError:@"请选择省市"];
        return;
    }
    NSString *comType;
    if ([self.compTypeStr isEqualToString:@"厂家"]) {
        comType =@"1";
    }else
    {
        comType =@"2";
    }
    NSString *numType;
    if ([self.numTypeStr isEqualToString:@"个人"]) {
        numType =@"11";
    }else
    {
        numType =@"12";
    }
    NSDictionary *dic=@{@"contact":self.contactStr,@"mobile":self.mobileStr,@"validCode":self.numCodeStr,@"compName":self.companyNameStr,@"busLic":[DRBuyerModel sharedManager].logo?:@"",@"code":self.numCodeStr,@"area":self.compAddressStr,@"areaCode":self.compAddressIDStr,@"address":self.detailAddressStr,@"compType":comType,@"creditId":self.tongyiStr,@"regType":@"1",@"invoiceHead":self.fapiaoStr,@"tfn":self.shuihaoStr,@"bankAccount":self.bankNumStr,@"openBank":self.bankIDTypeStr ,@"bankAccountType":numType,@"bankAccountName":self.bankNumStr,@"bankAccountProvince":self.provinceIDStr,@"bankAccountCity":self.cityIDStr};
//    NSDictionary *dic =@{keyArr[0]:valueArray[0],keyArr[1]:valueArray[1],keyArr[2]:valueArray[2],keyArr[3]:valueArray[3],keyArr[4]:valueArray[4],keyArr[5]:valueArray[5],keyArr[6]:valueArray[6],keyArr[7]:valueArray[7]};
    NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:[SNTool jsontringData:dic] forKey:@"sellerRegister"];
    [mudic setObject:@"" forKey:@"spread"];
    [SNAPI postWithURL:@"seller/sellerReg" parameters:mudic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:result.data];
            [self performSelector:@selector(back) withObject:self afterDelay:1];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 点击选择照片
-(void)photoButton:(UIButton *)button
{
    if ([[CanUsePhoto new] isCanUsePhotos]) {
        [self ChangeHeadImage];
    }
    else
    {
        [[CanUsePhoto new] showNotAllowed];
    }
}
#pragma mark 下一步
-(void)nextButton:(UIButton *)button
{
    
    
}


-(void)later
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark **************************  拍照 /相册 ***********************
-(void)ChangeHeadImage
{
    ///初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    ///按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          [self setHeadImageFromTakePhoto];
                      }]];
    ///按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self setHeadImageFromAlbum];
    }]];
    
    ///按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
///拍照选取头像
-(void)setHeadImageFromTakePhoto
{
    /**
     其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
     */
    UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
    //获取方式:通过相机
    PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
    PickerImage.allowsEditing = YES;
    PickerImage.delegate = self;
    [self presentViewController:PickerImage animated:YES completion:nil];
}
///从相册中选取头像
-(void)setHeadImageFromAlbum
{
    ///初始化UIImagePickerController
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    ///获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
    ///获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
    //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.mediaTypes = @[@"public.image"];
    pickerController.navigationBar.translucent = NO;
    pickerController.navigationController.navigationBar.tintColor = BLACKCOLOR;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = BLACKCOLOR;
    [pickerController.navigationBar setTitleTextAttributes:attrs];
    [pickerController.navigationBar setTintColor:BLACKCOLOR];
    ///允许剪裁，即放大裁剪
    pickerController.allowsEditing = YES;
    pickerController.delegate = self;
    ///页面跳转
    [self presentViewController:pickerController animated:YES completion:nil];
}
///PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //照片
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    //    [self.avatarBtn setImage:image forState:UIControlStateNormal];
    //    DRWeakSelf;
//    [SNAPI userAvatar:image nickName:nil success:^(SNResult *result){
//        [MBProgressHUD showSuccess:SNStandardString(@"上传成功")];
//        [DRBuyerModel sharedManager].logo =result.data[@"src"];
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//    }];
    [SNAPI userAvatar:image nickName:nil success:^(SNResult *result){
        [MBProgressHUD showSuccess:SNStandardString(@"上传成功")];
        [DRBuyerModel sharedManager].yingyeLogo =result.data[@"src"];
         [self releadWithRow:9];
    } failure:^(NSError *error) {
        
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
