//
//  DCReceivingAddressViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/18.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCReceivingAddressViewController.h"
#import "SNIOTTool.h"
// Controllers
#import "DCNewAdressViewController.h" //新增地址
// Models
#import "DCAdressItem.h"
#import "DCAdressDateBase.h"
// Views
#import "DCUserAdressCell.h"
// Vendors
#import <SVProgressHUD.h>
#import "UIView+Toast.h"
#import "DRAdressListModel.h"
// Categories

// Others

@interface DCReceivingAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
/* 暂无收获提示 */
@property (strong , nonatomic)DCUpDownButton *bgTipButton;
@property (nonatomic,retain)UIButton *addBtn;
/* tableView */
@property (strong , nonatomic)UITableView *tableView;

/* 地址信息 */
@property (strong , nonatomic)DRAdressListModel *addressListModel;
@property (strong,nonatomic)NSMutableArray *dataArray;

@end

static NSString *const DCUserAdressCellID = @"DCUserAdressCell";

@implementation DCReceivingAddressViewController

#pragma mark - LazyLoad

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor =[UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCUserAdressCell class]) bundle:nil] forCellReuseIdentifier:DCUserAdressCellID];
        
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH -HScale(60));
        
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"MG_Empty_dizhi"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"您还没有收货地址" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-DRTopHeight , 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];

    [self setUpAccNote];
}

- (void)setUpAccNote
{
    DRWeakSelf;
   
//    NSMutableDictionary *paramers =[NSMutableDictionary dictionary];
   
    [SNIOTTool getWithURL:@"buyer/addressList" parameters:nil success:^(SNResult *result) {
        
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.dataArray =[NSMutableArray array];
            NSArray *sourArr =result.data;
            if (sourArr.count!=0) {
                for (NSDictionary *dic in sourArr) {
                    weakSelf.addressListModel =[DRAdressListModel mj_objectWithKeyValues:dic];
                    [weakSelf.dataArray addObject:weakSelf.addressListModel];
                }
            }
           
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
  
}

#pragma mark - initialize
- (void)setUpBase
{
    self.title = @"收货地址";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.bgTipButton];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [UIView new];
    
    [self addTableViewfooterView];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = -15;
//
//    UIButton *button = [[UIButton alloc] init];
//    [button setImage:[UIImage imageNamed:@"nav_btn_tianjia"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"nav_btn_tianjia"] forState:UIControlStateHighlighted];
//    button.frame = CGRectMake(0, 0, 44, 44);
//    [button addTarget:self action:@selector(addButtonBarItemClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//
//    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.bgTipButton.hidden = (_dataArray.count > 0) ? YES : NO;
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRWeakSelf;
    self.addressListModel =self.dataArray[indexPath.row];
    DCUserAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:DCUserAdressCellID forIndexPath:indexPath];
    cell.adItem = self.addressListModel;
    
    cell.deleteClickBlock = ^{  //删除地址
        
       
        NSDictionary *dic =@{@"id":self.addressListModel.address_id};
//        [SNAPI postWithURL:@"buyer/deleteAddress" parameters:dic success:^(SNResult *result) {
//           
//        } failure:^(NSError *error) {
//            
//        }];
        [SNIOTTool deleteWithURL:@"buyer/deleteAddress" parameters:[dic mutableCopy] success:^(SNResult *result) {
             [self setUpAccNote];
        } failure:^(NSError *error) {
            
        }];
        
    };
    cell.editClickBlock = ^{ //编辑地址
    
        DCNewAdressViewController *dcNewVc = [DCNewAdressViewController new];
        dcNewVc.adressItem = weakSelf.dataArray[indexPath.row];
    
        dcNewVc.addressBlock = ^{
            [weakSelf setUpAccNote];
        };
//        dcNewVc.userModel =self.userModel;
        dcNewVc.saveType = DCSaveAdressChangeType;
        [weakSelf.navigationController pushViewController:dcNewVc animated:YES];
        
    };
    
    cell.selectBtnClickBlock = ^(BOOL isSelected) { //默认选择点击
       
        NSDictionary *dic =@{@"id":self.addressListModel.address_id};
        [SNAPI postWithURL:@"buyer/setAddressDefault" parameters:dic success:^(SNResult *result) {
            [self setUpAccNote];
        } failure:^(NSError *error) {
            
        }];
    
    };
    
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.addressListModel.cellHeight;
}

#pragma mark - 添加地址点击
- (void)addBtnClick
{
    DRWeakSelf;
    DCNewAdressViewController *dcNewVc = [DCNewAdressViewController new];
//    dcNewVc.userModel =self.userModel;
    dcNewVc.addressBlock = ^{
        [weakSelf setUpAccNote];
    };
    dcNewVc.saveType = DCSaveAdressNewType;
    [self.navigationController pushViewController:dcNewVc animated:YES];
}

#pragma mark 添加表尾
-(void)addTableViewfooterView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-HScale(60)-DRTopHeight, SCREEN_WIDTH, HScale(60))];
    headView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:headView];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(20, 10,SCREEN_WIDTH-40, HScale(40));
    [self.addBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    
   
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addBtn.layer.cornerRadius =HScale(20);
    self.addBtn.layer.masksToBounds =HScale(20);
    self.addBtn.titleLabel.font = DR_FONT(15);
    self.addBtn.backgroundColor =[UIColor redColor];
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.addBtn];
    
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
