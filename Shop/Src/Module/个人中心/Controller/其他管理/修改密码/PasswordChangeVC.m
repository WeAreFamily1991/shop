//
//  InfoChangeViewController.m
//  Dache
//
//  Created by 解辉 on 2018/8/16.
//  Copyright © 2018年 NaDao. All rights reserved.
//

#import "PasswordChangeVC.h"
#import "InfoTableViewCell.h"
#import "CGXPickerView.h"
#import "SNIOTTool.h"
#import "NSStringSNCategory.h"
@interface PasswordChangeVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *orderPassWord,*newPassword,*surePassword;
}
@property (nonatomic,retain)UIButton *selectBtn;
@property (nonatomic,retain)UIButton *normelBtn;
@property (nonatomic,retain)UIButton *saveBtn;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PasswordChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.dataDic =[NSMutableDictionary dictionary];
    self.title = @"修改密码";
    ///左侧返回按钮
    //    [self setLeftImageNamed:@"back" action:@selector(back)];
    //
    //    ///右侧按钮
    //    [self setRightImageNamed:@"" action:@selector(info)];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_questions" highlightedIcon:@"" target:self action:@selector(rightBarButtonItem)];
    
    [self.view addSubview:self.tableView];
    
   
    [self addTableViewfooterView];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_questions" highlightedIcon:@"" target:self action:@selector(rightBarButtonItem)];
}

#pragma mark 添加表尾
-(void)addTableViewfooterView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HScale(80))];
    headView.backgroundColor =[UIColor clearColor];
    self.tableView.tableFooterView =headView;
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(20, 30,SCREEN_WIDTH-40, HScale(40));
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveBtn.layer.cornerRadius =HScale(20);
    self.saveBtn.layer.masksToBounds =HScale(20);
    self.saveBtn.titleLabel.font = DR_FONT(15);
    self.saveBtn.backgroundColor =REDCOLOR;
    [self.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.saveBtn];
    
    
}

-(void)selectBtnClick:(UIButton *)sender
{
    self.normelBtn.selected =NO;
    self.selectBtn.selected =YES;
    [self.tableView reloadData];
    
}
-(void)normelBtnClick:(UIButton *)sender
{
    
    self.normelBtn.selected =YES;
    self.selectBtn.selected =NO;
    [self.tableView reloadData];
}

-(void)rightBarButtonItem
{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"溫馨提示" message:@"請您填寫前準備一下個人證件\n●身份證：男性需要在21-60周歲內，女性需在21-55周歲內。\n●駕駛證：實際駕齡至少3年\n●行駛證：車齡不超過8年\n●其他：網約車從業資格證\n\n請您確認APP開放訪問相機和相冊的權限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
    [al show];
}


///表
-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled =NO;
        if (@available(iOS 11.0, *)) {
            
            _tableView.estimatedRowHeight = 0;
            
            _tableView.estimatedSectionHeaderHeight = 0;
            
            _tableView.estimatedSectionFooterHeight = 0;
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark 隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    return HScale(50);
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///司机信息
    
    
    NSArray *titleArray =[NSArray array];
    NSArray *placeholdArray=[NSArray array];
        titleArray = @[@"旧密码：",@"新密码：",@"确认新密码："];
        placeholdArray= @[@"请输入旧密码",@"请输入新密码",@"请确认新密码"];
    
    InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
    
   
    cell.titleLabel.text = titleArray[indexPath.row];
    cell.titleLabel.font = DR_FONT(15);
    cell.contentTF.placeholder = placeholdArray[indexPath.row];
    cell.contentTF.tag = indexPath.row+1;
    cell.contentTF.keyboardType =UIKeyboardTypeASCIICapable;
    cell.contentTF.secureTextEntry =YES;
    //            cell.contentTF.text = contentArray[indexPath.row];
    
    [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    
    //            if (indexPath.row == 0) {
    //                cell.contentTF.hidden = YES;
    //                cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WScale(15)];
    //            }
    //            if (indexPath.row == 2) {
    //                cell.contentTF.keyboardType = UIKeyboardTypePhonePad;
    //            }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(void)textFieldChangeAction:(UITextField *)textField
{
    if (textField.tag == 1)
    {
        orderPassWord = textField.text;
    }
    else if (textField.tag == 2)
    {
        newPassword = textField.text;
    }
    else if (textField.tag == 3)
    {
        surePassword = textField.text;
    }
}
///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
//    if (indexPath.row==0&&self.status==1) {
//        [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
//
//            NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
//            //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
//        }];
//    }
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark ************  按钮的点击事件  *************
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)info
{
    
}

#pragma mark 下一步
-(void)nextButton:(UIButton *)button
{
    
    
}
-(void)later
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 按钮点击事件
-(void)saveBtnClick:(UIButton *)sender
{
    
    if (orderPassWord.length<6) {
        [MBProgressHUD showError:@"请输入正确的旧密码"];
        return;
    }
    if (newPassword.length<6) {
        [MBProgressHUD showError:@"请输入正确的新密码"];
        return;
    }
    if (surePassword.length<6) {
        [MBProgressHUD showError:@"请输入正确的确认密码"];
        return;
    }
    if (![newPassword isEqualToString:surePassword]) {
        [MBProgressHUD showError:@"两次密码输入不一致"];
        return;
    }
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[[orderPassWord MD5],[newPassword MD5]] forKeys:@[@"oldPassword",@"newPassword"]];
    [SNAPI postWithURL:@"buyer/updatePassword" parameters:dic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [self performSelector:@selector(showLogin) withObject:self afterDelay:1];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
    
}
-(void)showLogin
{
     [DRAppManager showLoginView];
}
-(void)logOut
{
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    [SNIOTTool postWithURL:USER_LOGOUT parameters:dic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
            [DRAppManager showLoginView];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
    
    
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
