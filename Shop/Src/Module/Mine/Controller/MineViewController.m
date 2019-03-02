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
#import "DRUserInfoTVC.h"
@interface MineViewController ()
@property (nonatomic,strong)DRUserInfoModel *usermodel;
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
    
}
-(void)footerViewCustom
{
    UIView *footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    footView.backgroundColor =[UIColor clearColor];
    self.tableView.tableFooterView =footView;
    UILabel *titleLab =[[UILabel alloc]initWithFrame:footView.bounds];
    titleLab.text =@"- 热线电话:0573-83108631 -";
    titleLab.textColor =[UIColor lightGrayColor];
    titleLab.font=DR_FONT(12);
    titleLab.textAlignment =1;
    [footView addSubview:titleLab];
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
            DRUserInfoTVC *userInfoVC =[[DRUserInfoTVC alloc]init];
            userInfoVC.user =self.usermodel;
            userInfoVC.changeInfo = ^{
                
            };
            [self.navigationController pushViewController:userInfoVC animated:YES];
        }
            break;
        case 23:
        {
            [self.navigationController pushViewController:[BillMessageVC new] animated:YES];
        }
            break;
        case 24:
        {
            [self.navigationController pushViewController:[BillMessageVC new] animated:YES];
        }
            break;
        case 25:
        {
            [self.navigationController pushViewController:[BillMessageVC new] animated:YES];
        }
            break;
        case 26:
        {
            [self.navigationController pushViewController:[BillMessageVC new] animated:YES];
        }
            break;
        case 27:
        {
            [self.navigationController pushViewController:[BillMessageVC new] animated:YES];
        }
            break;
    
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
