//
//  MineViewController.m
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "HaveShopNewsDetailVC.h"
#import "ChangeOrderVC.h"
#import "SelloutVC.h"
#import "CollectionVC.h"
#import "VoucherVC.h"
#import "SalesOrderVC.h"
#import "BillingInformationVC.h"
#import "BillApplicationVC.h"
#import "BillMessageVC.h"
#import "MessageVC.h"
#import "DRUserInfoModel.h"
#import "DRUserInfoVC.h"
#import "PasswordChangeVC.h"
#import "DCReceivingAddressViewController.h"
#import "ChildVC.h"
#import "SNIOTTool.h"
@interface MineViewController ()
//@property (nonatomic,strong)DRUserInfoModel *usermodel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
   
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self footerViewCustom];
     [self loadUser];
}
- (void)loadUser {
    
    if (![User currentUser].isLogin) {
        return;
    }
//    DRWeakSelf;
    [SNAPI userInfoSuccess:^(SNResult *result) {
        [[DRUserInfoModel sharedManager] setValuesForKeysWithDictionary:result.data];
        [[DRBuyerModel sharedManager] setValuesForKeysWithDictionary:result.data[@"buyer"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
          self.tabBarController.selectedIndex=0;
//        [self logOut];
        
    }];
//    [SNAPI userInfoSuccess:^(DRUserInfoModel *user) {
//
//        weakSelf.usermodel = user;
//        [weakSelf.tableView reloadData];
////        [weakSelf.avatarBtn sd_setImageWithURL:[NSURL URLWithString:user.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_touxiang"]];
////        weakSelf.nameLB.text = user.user_nickname;
//    } failure:^(NSError *error) {
//
//        [self logOut];
//    }];
}
-(void)footerViewCustom
{
    UIView *footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    footView.backgroundColor =[UIColor clearColor];
    self.tableView.tableFooterView =footView;
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    titleLab.text =@"- 热线电话:0573-83108631 -";
    titleLab.textColor =[UIColor lightGrayColor];
    titleLab.font=DR_FONT(12);
    titleLab.textAlignment =NSTextAlignmentCenter;
    [footView addSubview:titleLab];
    UIButton *titleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame =CGRectMake(0, 0, ScreenW, 30);
    [titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:titleBtn];
}
-(void)titleBtnClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0573-83108631"]];
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row == 0) {
        MineCell *cell = [MineCell cellWithTableView:tableView];
        NSString *nameStr =[DRBuyerModel sharedManager].name;
        if (nameStr) {
            cell.nameLab.text =[DRBuyerModel sharedManager].name;
        }
        
       else
       {
            cell.nameLab.text =[DRUserInfoModel sharedManager].account;
       }
       
        cell.phoneLab.text =[DRUserInfoModel sharedManager].mobilePhone;
        [cell.iconBtn sd_setImageWithURL:[NSURL URLWithString:[DRBuyerModel sharedManager].logo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_head"]];
        cell.BtnManagetagBlock = ^(NSInteger manageBtntag) {
            [self managePushVC:manageBtntag];
        };
        return cell;
    }else if(indexPath.row == 1){
        MineCell2 *cell = [MineCell2 cellWithTableView:tableView];
        cell.BtnMoneytagBlock = ^(NSInteger moneyBtntag) {
            [self managePushVC:moneyBtntag];
        };
        return cell;
    }
    NSString *childID =[DRUserInfoModel sharedManager].parentid;
    if (childID.length!=0) {
        MineCell4 *cell = [MineCell4 cellWithTableView:tableView];
        cell.BtnOthertagBlock = ^(NSInteger moneyBtntag) {
            [self managePushVC:moneyBtntag];
        };
    }
    MineCell3 *cell = [MineCell3 cellWithTableView:tableView];
    cell.BtnOthertagBlock = ^(NSInteger moneyBtntag) {
        [self managePushVC:moneyBtntag];
    };
    
    return cell;
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self hideNavigationBar];
    [self loadUser];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
       
        return 250;
    }else if (indexPath.row == 1){
        return 150;
    }else if (indexPath.row == 2){
        return 250;
    }
    return 0;
}
#pragma mark - 跳转二级页面
-(void)managePushVC:(NSInteger )pushTag
{
    DRWeakSelf;
    NSLog(@"pushTag=%ld",(long)pushTag);
//    [self.navigationController pushViewController:[@[@"ChangeOrderVC",@"SelloutVC",@"SelloutVC",@"CollectionVC"][pushTag] new] animated:YES];
    switch (pushTag) {
        case 0:
        {
            [self.navigationController pushViewController:[ChangeOrderVC new] animated:YES];
        }
            break;

        case 2:
        {
            [self.navigationController pushViewController:[HaveShopNewsDetailVC new] animated:YES];
        }
            break;

        case 1:
        {
            [self.navigationController pushViewController:[SelloutVC new] animated:YES];
        }
            break;
        case 3:
        {
            [self.navigationController pushViewController:[CollectionVC new] animated:YES];
        }
            break;
        case 4:
        {
            [self.navigationController pushViewController:[VoucherVC new] animated:YES];
        }
            break;
            
        case 10:
        {
            [self.navigationController pushViewController:[SalesOrderVC new] animated:YES];
        }
            break;
        case 11:
        {
            [self.navigationController pushViewController:[BillingInformationVC new] animated:YES];
        }
            break;
        case 12:
        {
            [self.navigationController pushViewController:[BillApplicationVC new] animated:YES];
        }
            break;
        case 13:
        {
            [self.navigationController pushViewController:[BillMessageVC new] animated:YES];
        }
            break;
            
        case 20:
        {
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4006185027"]];
        }
            break;
        case 21:
        {
            [self.navigationController pushViewController:[MessageVC new] animated:YES];
        }
            break;
        case 22:
        {
            DRUserInfoVC *userInfoVC =[[DRUserInfoVC alloc]init];
//            userInfoVC.userModel =self.usermodel;
            userInfoVC.changeInfo = ^{
                [weakSelf loadUser];
            };
            [self.navigationController pushViewController:userInfoVC animated:YES];
        }
            break;
        case 23:
        {
            [self.navigationController pushViewController:[PasswordChangeVC new] animated:YES];
        }
            break;
        case 24:
        {
            DCReceivingAddressViewController *addressVC=[[DCReceivingAddressViewController alloc]init];
//            addressVC.userModel =self.usermodel;
            [self.navigationController pushViewController:addressVC animated:YES];
        }
            break;
        case 25:
        {
            [self.navigationController pushViewController:[ChildVC new] animated:YES];
        }
            break;
        case 26:
            
        {
            [MBProgressHUD showError:@"敬请期待！"];
//            [self.navigationController pushViewController:[BillMessageVC new] animated:YES];
        }
            break;
        case 27:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:@"是否退出登录"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action)
                                      {
                                         
                                          self.tabBarController.selectedIndex=0;
                                          [DRAppManager showLoginView];
//                                          [self logOut];
                                      }];
            [alertController addAction:action1];
            
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:nil];
//            [action2 setValue:HQColorRGB(0xFF8010) forKey:@"titleTextColor"];
            [alertController addAction:action2];
            
            dispatch_async(dispatch_get_main_queue(),^{
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
            break;
    
        default:
            break;
    }
}
-(void)logOut
{
    [[User currentUser] loginOut];
    
    LoginVC *dcLoginVc = [LoginVC new];
    
    DCNavigationController *nav =  [[DCNavigationController alloc] initWithRootViewController:dcLoginVc];
    [self presentViewController:nav animated:YES completion:nil];
  
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    [SNIOTTool postWithURL:USER_LOGOUT parameters:dic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
           
        }
        
    } failure:^(NSError *error) {
        
    }];
    
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
