//
//  ChildAddVC.m
//  Shop
//
//  Created by BWJ on 2019/3/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChildAddVC.h"

@interface ChildAddVC ()
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *sureTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic,retain)UIButton *addBtn;
@end

@implementation ChildAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =self.selectType?@"修改子账号":@"新增子账号";
    self.submitBtn.selected =self.selectType;
    self.submitBtn.layer.masksToBounds =self.submitBtn.height/2;
    self.submitBtn.layer.cornerRadius =self.submitBtn.height/2;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)submitBtnClick:(id)sender {
    
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
