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
@property (nonatomic, strong) NNValidationView *testView;
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
   
    self.loginBtn.layer.cornerRadius =25;
    self.loginBtn.layer.masksToBounds =25;
    [self.loginBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.loginBtn.layer setBorderWidth:1.0];
    self.registeBtn.layer.cornerRadius =25;
    self.registeBtn.layer.masksToBounds =25;
    //时间按钮
    ZJBLTimerButton *TimerBtn = [[ZJBLTimerButton alloc] initWithFrame:self.codeView.bounds];
    __weak typeof(self) WeakSelf = self;
    TimerBtn.countDownButtonBlock = ^{
        [WeakSelf qurestCode]; //开始获取验证码
    };
    [self.codeView addSubview:TimerBtn];
    
}
//发生网络请求 --> 获取验证码
- (void)qurestCode {
    
    NSLog(@"发生网络请求 --> 获取验证码");
    
    
}
- (void)setupViews {
    _testView = [[NNValidationView alloc] initWithFrame:self.imgCodeView.bounds andCharCount:4 andLineCount:4];
    [self.imgCodeView addSubview:_testView];
    
    __weak typeof(self) weakSelf = self;
    /// 返回验证码数字
    _testView.changeValidationCodeBlock = ^(void){
        NSLog(@"验证码被点击了：%@", weakSelf.testView.charString);
    };
    NSLog(@"第一次打印：%@", self.testView.charString);
}

- (IBAction)selectAreaBtnClick:(id)sender {
    [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
        
        NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
        //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
    }];
    
}
- (IBAction)selectBtnClick:(id)sender {
    self.selectBtn.selected =!self.selectBtn.selected;
    
}
- (IBAction)xieyiBtnClick:(id)sender {
    
}
- (IBAction)registBtnClick:(id)sender {
    
}
- (IBAction)loginBtnClick:(id)sender {
    
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
