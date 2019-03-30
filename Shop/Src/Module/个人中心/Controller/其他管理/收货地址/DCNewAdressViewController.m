//
//  DCNewAdressViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCNewAdressViewController.h"
#import "CGXPickerView.h"
// Controllers
#import "DRAdressListModel.h"
// Models
#import "DCAdressDateBase.h"
#import "SNIOTTool.h"

// Views
#import "DCNewAdressView.h"
// Vendors
#import "UIView+Toast.h"
#import <SVProgressHUD.h>
//#import "ChooseLocationView.h"
//#import "CitiesDataTool.h"
// Categories

// Others
#import "DCCheckRegular.h"

@interface DCNewAdressViewController ()<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UIGestureRecognizerDelegate>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
//@property (nonatomic,strong) ChooseLocationView *chooseLocationView;
@property (nonatomic,strong) UIView  *cover;
/* headView */
@property (strong , nonatomic)DCNewAdressView *adressHeadView;
@property (weak, nonatomic) IBOutlet UIButton *saveChangeButton;
@property (strong,nonatomic)NSArray *townArr;
@property (nonatomic,assign)NSInteger selectRow;
@property (nonatomic,retain)NSDictionary *dataSource;
@property (nonatomic,retain) DRAddressInfoModel *infoModel;
@end

@implementation DCNewAdressViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - (DRTopHeight+ 100));
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
    }
    return _tableView;
}
-(NSArray *)townArr
{
    if (!_townArr) {
        _townArr =[NSArray array];
    }
    return _townArr;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpHeadView];
    if (_saveType ==DCSaveAdressChangeType) {
        
        [self getaddressInfo];
    }
    [self getDistrict];
}
-(void)getaddressInfo
{
    DRWeakSelf;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.adressItem.address_id] forKeys:@[@"id"]];
    
    [SNIOTTool getWithURL:@"buyer/addressInfo" parameters:dic success:^(SNResult *result) {
        weakSelf.infoModel =[DRAddressInfoModel mj_objectWithKeyValues:result.data];
        if (weakSelf.saveType == DCSaveAdressChangeType) { //编辑
            weakSelf.adressHeadView.rePersonField.text =weakSelf.infoModel.receiver;
            weakSelf.adressHeadView.addressLabel.text = self.userModel.buyer.location;
            weakSelf.adressHeadView.rePhoneField.text =weakSelf.infoModel.mobile;
            //        _adressHeadView.provinceField.text =_adressItem.provAddress;
            weakSelf.adressHeadView.detailTextView.text = weakSelf.infoModel.address;
            weakSelf.adressHeadView.isDefautsBtn.selected =[weakSelf.adressItem.isdefault boolValue];
            
            
        }
       
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)getDistrict
{
    DRWeakSelf;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.userModel.buyer.locationcode] forKeys:@[@"parentId"]];
    [SNIOTTool getWithURL:@"mainPage/getDistrict" parameters:dic success:^(SNResult *result) {

        weakSelf.townArr =result.data;

        if (weakSelf.saveType ==DCSaveAdressChangeType&&weakSelf.townArr.count!=0) {
            if ([DEFAULTS objectForKey:@"town"]) {
                [weakSelf.adressHeadView.selectBtn setTitle:[DEFAULTS objectForKey:@"town"] forState:UIControlStateNormal];
                weakSelf.adressHeadView.selectBtn.selected =YES;
                NSMutableArray *nameArr =[NSMutableArray array];
                for (NSDictionary *dic in self.townArr) {
                    [nameArr addObject:dic[@"name"]];
                }
                self.selectRow =[nameArr indexOfObject:[DEFAULTS objectForKey:@"town"]];
            }
        }
        else if (weakSelf.saveType == DCSaveAdressNewType) {
            weakSelf.adressHeadView.addressLabel.text = self.userModel.buyer.location;
            weakSelf.adressHeadView.isDefautsBtn.selected =YES;
        }

    } failure:^(NSError *error) {

    }];
}
- (void)setUpBase
{
    self.title = (_saveType == DCSaveAdressNewType) ? @"新增地址" : @"编辑地址";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = self.view.backgroundColor;
//    [[CitiesDataTool sharedManager] requestGetData];
    [self.view addSubview:self.cover];
}
#pragma mark - 头部View
- (void)setUpHeadView
{
    _adressHeadView = [DCNewAdressView dc_viewFromXib];
    _adressHeadView.frame = CGRectMake(0, 0, ScreenW, HScale(270));
    self.saveChangeButton.layer.cornerRadius = 25;
    self.saveChangeButton.layer.masksToBounds = 25;
    self.tableView.tableHeaderView = _adressHeadView;
    self.tableView.tableFooterView = self.saveChangeButton;
    _adressHeadView.detailTextView.backgroundColor =BACKGROUNDCOLOR;
    _adressHeadView.detailTextView.layer.cornerRadius =5;
    _adressHeadView.detailTextView.layer.masksToBounds =5;
   
    DRWeakSelf;
    _adressHeadView.selectAdBlock = ^{
        if (self.townArr.count!=0)
        {
            [weakSelf.view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.cover.hidden = !weakSelf.cover.hidden;
                NSMutableArray *nameArr =[NSMutableArray array];
                for (NSDictionary *dic in weakSelf.townArr) {
                    [nameArr addObject:dic[@"name"]];
                }
                [CGXPickerView showStringPickerWithTitle:@"请选择城镇" DataSource:nameArr DefaultSelValue:nil IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                    NSLog(@"%@",selectValue);
                    [weakSelf.adressHeadView.selectBtn setTitle:selectValue forState:UIControlStateNormal];
                    weakSelf.adressHeadView.selectBtn.selected =YES;
                    NSLog(@"text=%@",weakSelf.adressHeadView.addressLabel.text);
                    weakSelf.selectRow=[selectRow integerValue];
                    [DEFAULTS setObject:selectValue forKey:@"town"];
                }];
                //            weakSelf.chooseLocationView.hidden = weakSelf.cover.hidden;
            });
        }
        else
        {
            [MBProgressHUD showError:@"暂无城镇"];
        }
        
    };
    _adressHeadView.isDefautsBlock = ^{
      
        weakSelf.adressHeadView.isDefautsBtn.selected =!weakSelf.adressHeadView.isDefautsBtn.selected;
    };
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - 保存新地址
- (IBAction)saveNewAdressClick {
    
    DRWeakSelf;

    if (_adressHeadView.rePersonField.text.length == 0 || _adressHeadView.rePhoneField.text.length == 0 || _adressHeadView.detailTextView.text.length == 0 || _adressHeadView.addressLabel.text.length == 0) {
        [self.view makeToast:@"请填写完整地址信息" duration:0.5 position:CSToastPositionCenter];
        [DCSpeedy dc_callFeedback]; //触动
        return;
    }
    if (![DCCheckRegular dc_checkTelNumber:_adressHeadView.rePhoneField.text]) {
        [self.view makeToast:@"手机号码格式错误" duration:0.5 position:CSToastPositionCenter];        
        return;
    }
    NSString *urlStr ;
    NSString *defautStr;
    NSDictionary *dic =[NSDictionary dictionary];
    if (_adressHeadView.isDefautsBtn.selected) {
        defautStr =@"true";
    }
    else{
         defautStr =@"false";
    }
    if (_saveType ==DCSaveAdressChangeType) {
        urlStr =@"buyer/updateAddress";
        dic=@{@"receiver":self.adressHeadView.rePersonField.text,@"mobile":self.adressHeadView.rePhoneField.text,@"districtid":self.townArr[self.selectRow][@"code"]?:@"",@"address": _adressHeadView.detailTextView.text,@"isdefault":defautStr,@"phone":@"",@"receiver":self.townArr[self.selectRow][@"name"]?:@"",@"id":self.infoModel.address_id?:@"",@"buyerid":self.infoModel.buyerid?:@""};
    }else
    {
        urlStr =@"buyer/addAddress";        dic=@{@"receiver":self.adressHeadView.rePersonField.text,@"mobile":self.adressHeadView.rePhoneField.text,@"districtId":self.townArr[self.selectRow][@"code"]?:@"",@"address": _adressHeadView.detailTextView.text,@"isdefault":[NSString stringWithFormat:@"%d",_adressHeadView.isDefautsBtn.selected],@"phone":@"",@"receiver":self.townArr[self.selectRow][@"name"]?:@""};
    }
    
    NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"address"];
    
    [SNAPI postWithURL:urlStr parameters:muDic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:result.data];
            [DEFAULTS setObject:weakSelf.adressHeadView.detailTextView.text forKey:@"detailAddress"];
            if (weakSelf.addressBlock) {
                weakSelf.addressBlock();
            }
            [self performSelector:@selector(back) withObject:self afterDelay:1];
        }
        
    } failure:^(NSError *error) {
    
    }];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
