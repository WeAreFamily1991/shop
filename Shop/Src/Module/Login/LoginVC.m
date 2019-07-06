//
//  LoginVC.m
//  Shop
//
//  Created by BWJ on 2019/2/18.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "LoginVC.h"
#import "ForgetVC.h"
#import "RegisteVC.h"
#import "SNAPI.h"
#import "SNToken.h"
#import "SNAccount.h"
@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *remmberBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registebTN;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];
    self.title =@"会员登录";
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"close"] WithSelected:nil Target:self action:@selector(leftBarButtonItem)];
    // Do any additional setup after loading the view from its nib.
    SNAccount *account = [SNAccount loadAccount];
    if (account.account.length) {
        self.phoneTF.text = account.account;
        if ([[DEFAULTS objectForKey:@"selected"] boolValue]) {
            self.passwordTF.text =account.password;
        }
        
       
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)leftBarButtonItem
{
    [self.view endEditing:YES];
   
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
-(void)layout
{
    self.phoneView.layer.cornerRadius =25;
    self.phoneView.layer.masksToBounds =25;
    self.passwordView.layer.cornerRadius =25;
    self.passwordView.layer.masksToBounds =25;
    self.loginBtn.layer.cornerRadius =22.5;
    self.loginBtn.layer.masksToBounds =22.5;
    self.registebTN.layer.cornerRadius =22.5;
    self.registebTN.layer.masksToBounds =22.5;
    [self.registebTN.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.registebTN.layer setBorderWidth:1.0];
    self.remmberBtn.selected =[[DEFAULTS objectForKey:@"selected"] boolValue];
    
}
#pragma mark - 退出当前界面
- (IBAction)closeBtnClick:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController setNavigationBarHidden:NO animated:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)remmberBtnCLICK:(id)sender
{
    self.remmberBtn.selected =!self.remmberBtn.selected;
    [DEFAULTS setObject:[NSString stringWithFormat:@"%d",self.remmberBtn.selected] forKey:@"selected"];
}
- (IBAction)forgetBtnCLICK:(id)sender
{
    [self.navigationController pushViewController:[ForgetVC new] animated:YES];
}
- (IBAction)loginBtnClick:(id)sender
{
    if (!self.phoneTF.text.length) {
        [MBProgressHUD showSuccess:SNStandardString(@"手机号为空") toView:self.view];
        [self.phoneTF becomeFirstResponder];
        return;
    } else if (!self.passwordTF.text.length) {
        [MBProgressHUD showSuccess:SNStandardString(@"密码为空") toView:self.view];
        [self.passwordTF becomeFirstResponder];
        return;
    }
    
    [self.view endEditing:YES];
    [MBProgressHUD showMessage:@"" toView:self.view];
    
//    __block NSString *regionCode = [self.accountField.text isEmailAddress] ? nil : @"86";
//    __block NSString *regionName = [self.accountField.text isEmailAddress] ? nil : self.regionName;
    
    __weak typeof(self) weakSelf = self;
    [SNAPI userLoginWithAccount:self.phoneTF.text password:self.passwordTF.text success:^{
        [MBProgressHUD hideHUDForView:weakSelf.view];
        
//        [SNDatabase setDefaultSSID:[SNTool SSID]];
        [SNAccount saveAccount:self.phoneTF.text password:self.passwordTF.text];
        
//        if (weakSelf.loginSuccess) {
//            weakSelf.loginSuccess();
//        }
        [MBProgressHUD showSuccess:@"登录成功"];
        [weakSelf success];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
        [MBProgressHUD hideHUDForView:weakSelf.view];
    }];
}
- (IBAction)registBtnClick:(id)sender
{
    
    [self.navigationController pushViewController:[RegisteVC new] animated:YES];
}
- (void)success {
    
    [MBProgressHUD hideHUDForView:self.view];
    [self performSelector:@selector(back) withObject:nil afterDelay:1];
}
-(void)back
{
    [self.view endEditing:YES];
    [self.navigationController setNavigationBarHidden:NO animated:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
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
