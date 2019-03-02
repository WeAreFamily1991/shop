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
@interface LoginVC ()
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
    self.phoneTF.backgroundColor =RGBHex(0XF5F5F5);
    self.phoneTF.layer.cornerRadius =self.phoneTF.dc_size.height/2;
    self.phoneTF.layer.masksToBounds =self.phoneTF.dc_size.height/2;
    self.passwordTF.backgroundColor =RGBHex(0XF5F5F5);
    self.passwordTF.layer.cornerRadius =self.passwordTF.dc_size.height/2;
    self.passwordTF.layer.masksToBounds =self.passwordTF.dc_size.height/2;
    self.loginBtn.layer.cornerRadius =25;
    self.loginBtn.layer.masksToBounds =25;
    self.registebTN.layer.cornerRadius =25;
    self.registebTN.layer.masksToBounds =25;
    [self.registebTN.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.registebTN.layer setBorderWidth:1.0];
    
    
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
}
- (IBAction)forgetBtnCLICK:(id)sender
{
    [self.navigationController pushViewController:[ForgetVC new] animated:YES];
}
- (IBAction)loginBtnClick:(id)sender
{
    
}
- (IBAction)registBtnClick:(id)sender
{
    
    [self.navigationController pushViewController:[RegisteVC new] animated:YES];
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
