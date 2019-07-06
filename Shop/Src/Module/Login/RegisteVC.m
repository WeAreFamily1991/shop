//
//  RegisteVC.m
//  Shop
//
//  Created by BWJ on 2019/2/18.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "RegisteVC.h"
#import "NNValidationView.h"
#import "ZJBLTimerButton.h"
#import "CGXPickerView.h"
#import "SNAPIManager.h"
#import "DRAgreementVC.h"
@interface RegisteVC ()
@property (weak, nonatomic) IBOutlet UITextField *companyTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *imgCodeTF;
@property (weak, nonatomic) IBOutlet UIView *imgCodeView;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UIView *codeView;

@property (weak, nonatomic) IBOutlet UIButton *selectAreaBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *xieyiBtn;
@property (weak, nonatomic) IBOutlet UIButton *registeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic)UIImageView *codeIMG;
@property (strong, nonatomic) ZJBLTimerButton *TimerBtn;

@property (nonatomic, strong) NNValidationView *testView;
@property (nonatomic,retain)NSString *validCodeIMGStr;
@property (nonatomic,retain)NSString * selectAreaCodeStr,*imgStr;

@end

@implementation RegisteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"注册";
   
//     self.navigationItem.leftBarButtonItem =[UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"back"] WithSelected:nil Target:self action:@selector(leftBarButtonItem)];
    [self setupViews];
    [self layout];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)leftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)layout
{
   
    self.loginBtn.layer.cornerRadius =self.loginBtn.dc_height/2;
    self.loginBtn.layer.masksToBounds =self.loginBtn.dc_height/2;
    [self.loginBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.loginBtn.layer setBorderWidth:1.0];
    self.registeBtn.layer.cornerRadius =self.loginBtn.dc_height/2;
    self.registeBtn.layer.masksToBounds =self.loginBtn.dc_height/2;
    [self.phoneTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.imgCodeTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    //时间按钮
  self.TimerBtn = [[ZJBLTimerButton alloc] initWithFrame:self.codeView.bounds];
    __weak typeof(self) WeakSelf = self;
   
    self.TimerBtn.countDownButtonBlock = ^{
        WeakSelf.TimerBtn.phoneStr =WeakSelf.phoneTF.text;
        WeakSelf.TimerBtn.imgCodeStr =WeakSelf.imgCodeTF.text;
        [WeakSelf qurestCode]; //开始获取验证码
    };
    [self.codeView addSubview:self.TimerBtn];
    
}
//发生网络请求 --> 获取验证码
- (void)qurestCode {
    
//    DRWeakSelf;
    [SNAPI commonMessageValidWithMobile:self.phoneTF.text validCode:self.imgCodeTF.text success:^(NSString *response) {
        if ([response isEqualToString:@"200"]) {
            [MBProgressHUD showError:@"验证码已发送"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }] ;
        

    NSLog(@"发生网络请求 --> 获取验证码");
    
    
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
        {
            if (textField.text.length>11) {
                self.phoneTF.text = [self.phoneTF.text substringToIndex:11];
               
               
            }
        }
            break;
        case 2:
        {
            if (textField.text.length>4) {
              self.imgCodeTF.text = [self.imgCodeTF.text substringToIndex:4];
           
            }
        }
            break;
        case 3:
        {
            if (textField.text.length>4) {
                self.codeTF.text = [self.codeTF.text substringToIndex:4];
            }
        }
        
            break;
            
        default:
            break;
    }
}
- (IBAction)codeBtnClick:(id)sender {
   self.imgStr =[NSString stringWithFormat:@"%@%@?santieJwt=%@&%d",[SNAPIManager shareAPIManager].baseURL,@"openStResouces/getValidCode",[DEFAULTS objectForKey:@"visitetoken"],[SNTool getRandomNumber:1000 to:9999]];
     NSLog(@"wwwww+%d",[SNTool getRandomNumber:1000 to:9999]);
     [self.codeBtn sd_setImageWithURL:[NSURL URLWithString:self.imgStr] forState:UIControlStateNormal];
}

- (void)setupViews {
    
    self.imgStr =[NSString stringWithFormat:@"%@%@?santieJwt=%@&%d",[SNAPIManager shareAPIManager].baseURL,@"openStResouces/getValidCode",[DEFAULTS objectForKey:@"visitetoken"],[SNTool getRandomNumber:1000 to:9999]];
    [self.codeBtn sd_setImageWithURL:[NSURL URLWithString:self.imgStr] forState:UIControlStateNormal];
}
-(void)addIMG
{

   
}
- (IBAction)selectAreaBtnClick:(id)sender {
    [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
        self.selectAreaBtn.selected =YES;
        [self.selectAreaBtn setTitle:[NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]] forState:UIControlStateNormal];
        NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
        self.selectAreaCodeStr =[NSString stringWithFormat:@"%@",[selectAddressArr lastObject]];
        [DEFAULTS setObject:[NSString stringWithFormat:@"%@,%@,%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]] forKey:@"address"];
        [DEFAULTS setObject:[selectAddressArr lastObject] forKey:@"locationcode"];
        //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
        
    }];
    
}
- (IBAction)selectBtnClick:(id)sender {
    self.selectBtn.selected =!self.selectBtn.selected;
    
}
- (IBAction)xieyiBtnClick:(id)sender {
    [self.navigationController pushViewController:[DRAgreementVC new] animated:YES];
}
- (IBAction)registBtnClick:(id)sender {
    if (self.companyTF.text.length==0) {
        [MBProgressHUD showError:@"请输入您的公司名称"];
        return;
    }
    if (self.phoneTF.text.length==0||self.phoneTF.text.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    
    if (self.imgCodeTF.text.length==0||self.imgCodeTF.text.length!=4) {
        [MBProgressHUD showError:@"请输入正确的图文验证码"];
        return;
    }
    if (self.codeTF.text.length==0||self.codeTF.text.length!=4) {
        [MBProgressHUD showError:@"请输入正确的验证码"];
        return;
    }

    if (self.selectAreaCodeStr.length==0) {
        [MBProgressHUD showError:@"请选择您所在地区"];
        return;
    }
    if (!self.selectBtn.selected) {
        [MBProgressHUD showError:@"请勾选注册服务协议"];
        return;
    }
    DRWeakSelf;
    [SNAPI userRegisterMobileWithCompany:self.companyTF.text mobile:self.phoneTF.text valid_code:self.codeTF.text location:self.selectAreaBtn.titleLabel.text locationCode:self.selectAreaCodeStr success:^(NSString *userDigit) {
        if ([userDigit isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:SNStandardString(@"注册成功")];
            [weakSelf success];            
        }
    } failure:^(NSError *error) {
        [weakSelf failure];
    }];
//    [SNAPI userRegisterMobileWithEmail:nil password:self.phoneTF.text type:0 ticket:self.ticket validCode:self.validCodeField.text success:^(NSString *userDigit) {
//
//        [weakSelf success];
//        [MBProgressHUD showSuccess:SNStandardString(@"register_success")];
//
//    } failure:^(NSError *error) {
//        [weakSelf failure];
//    }];
    NSLog(@"走走走");
    
}
- (void)success {
    
    [MBProgressHUD hideHUDForView:self.view];
    [self performSelector:@selector(back) withObject:nil afterDelay:1];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)failure {
    
   
    [MBProgressHUD hideHUDForView:self.view];
}

- (IBAction)loginBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
