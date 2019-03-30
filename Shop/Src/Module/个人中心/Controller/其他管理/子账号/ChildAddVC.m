//
//  ChildAddVC.m
//  Shop
//
//  Created by BWJ on 2019/3/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChildAddVC.h"
#import "NSStringSNCategory.h"
@interface ChildAddVC ()

@property (weak, nonatomic) IBOutlet UIView *surnView;
@property (weak, nonatomic) IBOutlet UIView *selectBtnView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *sureTF;
@property (weak, nonatomic) IBOutlet UIButton *lockBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (nonatomic,retain)UIButton *addBtn;
@end

@implementation ChildAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =self.selectType?@"修改子账号":@"新增子账号";
    self.submitBtn.selected =self.selectType;
    self.submitBtn.layer.masksToBounds =self.submitBtn.height/2;
    self.submitBtn.layer.cornerRadius =self.submitBtn.height/2;
    [self.phoneTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    
    [self loadBase];
    // Do any additional setup after loading the view from its nib.
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    if (textField.text.length>11) {
        self.phoneTF.text = [self.phoneTF.text substringToIndex:11];
    }
    
}
-(void)loadBase
{
    if (self.selectType) {
        
        self.surnView.hidden =YES;
        self.nameTF.text =self.childModel.accountName;
        self.phoneTF.text =self.childModel.mobilePhone;
        self.passwordTF.text =[DEFAULTS objectForKey:@"password"];
        self.sureTF.text =[DEFAULTS objectForKey:@"password"];
        self.startBtn.selected=!self.childModel.status;
        self.lockBtn.selected=self.childModel.status;
    }
    else
    {
        self.selectBtnView.top =self.passwordTF.bottom;
       
        self.selectBtnView.hidden =YES;
    }
    
}

- (IBAction)startBtnClick:(id)sender {
    self.startBtn.selected=YES;
    self.lockBtn.selected=NO;
}
- (IBAction)lockBtnclICK:(id)sender {
    self.startBtn.selected=NO;
    self.lockBtn.selected=YES;
}

- (IBAction)submitBtnClick:(id)sender {
    DRWeakSelf;
    if (self.nameTF.text.length==0) {
        [MBProgressHUD showError:@"请输入姓名"];
        return;
    }
    if (self.phoneTF.text.length==0||self.phoneTF.text.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    if (self.passwordTF.text.length<6) {
        [MBProgressHUD showError:@"请输入正确的密码"];
        return;
    }
    if (!self.selectType) {
        if (self.sureTF.text.length<6) {
            [MBProgressHUD showError:@"请输入正确的确认密码"];
            return;
        }
        if (![self.passwordTF.text isEqualToString:self.sureTF.text]) {
            [MBProgressHUD showError:@"两次密码输入不一致"];
            return;
        }
        
    }
    NSMutableDictionary *muDic =[NSMutableDictionary dictionary];
    NSString *urlStr ;
    if (self.selectType) {
//        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObject:@[,,,,,,] forKey:@[]];
        NSDictionary *dic =@{@"accountName":self.nameTF.text,@"mobilePhone":self.phoneTF.text,@"password":[self.passwordTF.text MD5],@"status":[NSString stringWithFormat:@"%d",self.lockBtn.selected],@"id":self.childModel.child_id,@"buyerid":self.childModel.buyerid,@"parentid":self.childModel.parentid};
        
        muDic =[NSMutableDictionary dictionaryWithObject:[dic mj_JSONString] forKey:@"account"];
        urlStr =@"buyer/updateChildAccount";
    }
    else
    {
//        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObject:@[,,,[self.passwordTF.text MD5],[self.sureTF.text MD5]] forKey:@[]];
        NSDictionary *dic=@{@"account":self.phoneTF.text,@"accountName":self.nameTF.text,@"mobile":self.phoneTF.text,@"password":[self.passwordTF.text MD5],@"confirmPassword":[self.sureTF.text MD5]};
       muDic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"childAccount"];
       urlStr =@"buyer/addChildAccount";
    }
    
    [SNAPI postWithURL:urlStr parameters:muDic success:^(SNResult *result) {
        [MBProgressHUD showSuccess:result.data];
        if (weakSelf.childBlock) {
            weakSelf.childBlock();
        }
        [DEFAULTS setObject:self.passwordTF.text forKey:@"password"];
         [DEFAULTS setObject:self.sureTF.text forKey:@"Surepassword"];
        
        [self performSelector:@selector(back) withObject:self afterDelay:1];
    
     
     } failure:^(NSError *error) {
         
     }];
}
-(void)back
{
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
