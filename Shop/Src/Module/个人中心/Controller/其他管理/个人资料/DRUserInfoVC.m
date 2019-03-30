//
//  InfoChangeViewController.m
//  Dache
//
//  Created by 解辉 on 2018/8/16.
//  Copyright © 2018年 NaDao. All rights reserved.
//

#import "DRUserInfoVC.h"
#import "InfoTableViewCell.h"
#import "CGXPickerView.h"
#import "ChangeUserNameVC.h"
#import "ChangePhoneVC.h"
@interface DRUserInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (nonatomic,retain)UIButton *selectBtn;
@property (nonatomic,retain)UIButton *normelBtn;
@property (nonatomic,retain)UIButton *saveBtn;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation DRUserInfoVC
-(void)GetUserInfo
{
    //    name =[UserModel sharedManager].username;
    //    phone =[UserModel sharedManager].mobile;
    //    identifyID =[UserModel sharedManager].idcard;
    //    carID =[UserModel sharedManager].car_no;
    //    [self.dataDic setObject:[UserModel sharedManager].car_brand forKey:@"car_brand"];
    //    [self.dataDic setObject:[UserModel sharedManager].car_series forKey:@"car_series"];
    //    NSArray *idArr = [[UserModel sharedManager].idcard_pics componentsSeparatedByString:@","];
    //    NSArray *jiaArr = [[UserModel sharedManager].drive_card componentsSeparatedByString:@","];
    //    NSArray *xingArr = [[UserModel sharedManager].driving_card componentsSeparatedByString:@","];
    //    [self.dataDic setObject:idArr[0] forKey:@"shenfenzheng"];
    //    [self.dataDic setObject:idArr[1] forKey:@"shenfenfan"];
    //    [self.dataDic setObject:jiaArr[0] forKey:@"jiazhaozheng"];
    //    [self.dataDic setObject:jiaArr[1] forKey:@"jiazhaofan"];
    //    [self.dataDic setObject:xingArr[0] forKey:@"xingshizheng"];
    //    [self.dataDic setObject:xingArr[1] forKey:@"xingshifan"];
    //    [self.dataDic setObject:[UserModel sharedManager].man_car_img forKey:@"renche"];
    //
    //    jiaImg1 =jiaArr[0];
    //    jiaImg2 =jiaArr[1];
    //    identifyImg1 =idArr[0];
    //    identifyImg2 =idArr[1];
    //    xingImg1 =xingArr[0];
    //    xingImg2 =xingArr[1];
    //    heImg1 =[UserModel sharedManager].man_car_img;
    //    carType =[UserModel sharedManager].car_brand_desc;
    //    time =[UserModel sharedManager].car_register_time;
    //
    //    name =[UserModel sharedManager].username;
    //    name =[UserModel sharedManager].username;
    //    name =[UserModel sharedManager].username;
    //    name =[UserModel sharedManager].username;
    
    
    //    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:[UserModel sharedManager].token,@"token", nil];
    //
    //    [Interface_Base Post:@"GetConfig" dic:dic sccessBlock:^(NSDictionary *data, NSString *message) {
    //          data[@"data"][@"car_level"];
    //
    //    } failBlock:^(NSDictionary *data, NSString *message) {
    //        [MBProgressHUD showError:message];
    //    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.dataDic =[NSMutableDictionary dictionary];
    self.title = @"个人资料";
    ///左侧返回按钮
    //    [self setLeftImageNamed:@"back" action:@selector(back)];
    //
    //    ///右侧按钮
    //    [self setRightImageNamed:@"" action:@selector(info)];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_questions" highlightedIcon:@"" target:self action:@selector(rightBarButtonItem)];
    
    [self.view addSubview:self.tableView];
    [self GetUserInfo];
//    if (self.status==0) {
//
//        [self addTableViewHeaderView];
//
//    }
    [self addTableViewfooterView];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_questions" highlightedIcon:@"" target:self action:@selector(rightBarButtonItem)];
}
#pragma mark 添加表头
-(void)addTableViewHeaderView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, HScale(55))];
    headView.backgroundColor =[UIColor whiteColor];
    self.tableView.tableHeaderView =headView;
    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, HScale(55))];
    headLab.font =DR_FONT(14);
    headLab.textColor =[UIColor blackColor];
    headLab.textAlignment = 0;
    headLab.text=@"发票类型:";
    [headView addSubview:headLab];
    
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(headLab.width+30, 0,SCREEN_WIDTH/3, HScale(55));
    [self.selectBtn setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
    [self.selectBtn setTitle:@"增值税专用发票" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    self.selectBtn.titleLabel.font =DR_FONT(13);
    self.selectBtn.selected =self.userModel.status;
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.selectBtn];
    
    self.normelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.normelBtn.frame = CGRectMake(headLab.width+40+self.selectBtn.width, 0,SCREEN_WIDTH/3, HScale(55));
    [self.normelBtn setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [self.normelBtn setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
    [self.normelBtn setTitle:@"增值税普通发票" forState:UIControlStateNormal];
    
    [self.normelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.normelBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    self.normelBtn.titleLabel.font = DR_FONT(13);
    self.normelBtn.selected =!self.userModel.status;
    [self.normelBtn addTarget:self action:@selector(normelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.normelBtn];
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, HScale(55)-1, SCREEN_WIDTH, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [headView addSubview:lineView];
    
}
#pragma mark 添加表尾
-(void)addTableViewfooterView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, HScale(60))];
    headView.backgroundColor =[UIColor clearColor];
    self.tableView.tableFooterView =headView;
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(20, 10,SCREEN_WIDTH-40, HScale(40));
    [self.saveBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveBtn.layer.cornerRadius =HScale(20);
    self.saveBtn.layer.masksToBounds =HScale(20);
    self.saveBtn.titleLabel.font = DR_FONT(15);
    self.saveBtn.backgroundColor =[UIColor redColor];
    [self.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.saveBtn];
    
}
#pragma mark 按钮点击事件
-(void)saveBtnClick:(UIButton *)sender
{
    NSArray *valueArray = @[self.userModel.buyer.logo?:@"",self.userModel.buyer.mobilephone?:@"",self.userModel.buyer.name?:@"",self.userModel.buyer.companyAddress?:@"",self.userModel.buyer.cName?:@"",self.userModel.buyer.cPhone?:@"",self.userModel.buyer.cTel?:@"",[NSString stringWithFormat:@"%d",self.selectBtn.selected]];
    NSArray *keyArr =@[@"logo",@"mobilephone",@"name",@"companyAddress",@"cName",@"cPhone",@"cTel",@"ticketType"];
    NSDictionary *dic =@{keyArr[0]:valueArray[0],keyArr[1]:valueArray[1],keyArr[2]:valueArray[2],keyArr[3]:valueArray[3],keyArr[4]:valueArray[4],keyArr[5]:valueArray[5],keyArr[6]:valueArray[6],keyArr[7]:valueArray[7]};
    NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:[SNTool jsontringData:dic] forKey:@"buyer"];
    
    [SNAPI postWithURL:@"buyer/updateBuyInfo" parameters:mudic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [self performSelector:@selector(back) withObject:self afterDelay:1];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)rightBarButtonItem
{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"溫馨提示" message:@"請您填寫前準備一下個人證件\n●身份證：男性需要在21-60周歲內，女性需在21-55周歲內。\n●駕駛證：實際駕齡至少3年\n●行駛證：車齡不超過8年\n●其他：網約車從業資格證\n\n請您確認APP開放訪問相機和相冊的權限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
    [al show];
}


///表
-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            
            _tableView.estimatedRowHeight = 0;
            
            _tableView.estimatedSectionHeaderHeight = 0;
            
            _tableView.estimatedSectionFooterHeight = 0;
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark 隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 7;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row==0) {
       return HScale(60);
    }
    
    return HScale(50);
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return HScale(55);
}
#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///司机信息
    NSArray *titleArray =[NSArray array];
    NSArray *placeholdArray=[NSArray array];
    if (indexPath.row==0) {
        InfoTableViewCell6 *cell = [InfoTableViewCell6 cellWithTableView:tableView];
        NSString *tagStr = [NSString stringWithFormat:@"%ld%@",indexPath.row-3,@"1"];
        cell.photoBtn.tag = [tagStr intValue];
        cell.titleLabel.text =@"选择图片";
        [cell.photoBtn addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
        id imgStr1 = self.userModel.buyer.logo?:@"default_head";
        
        if (![imgStr1 isEqualToString:@"default_head"]) {
            
            [cell.photoBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:imgStr1] forState:UIControlStateNormal];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        titleArray = @[@"手机号：",@"公司名称：",@"公司地址：",@"联系人：",@"固定电话：",@"手机号码："];
        placeholdArray= @[@"请输入手机号",@"请输入公司名称",@"请输入公司地址",@"请输入联系人",@"请输入固定电话",@"请输入手机号码"];
        NSArray *contentArray = @[self.userModel.buyer.mobilephone?:@"",self.userModel.buyer.name?:@"",self.userModel.buyer.companyAddress?:@"",self.userModel.buyer.cName?:@"",self.userModel.buyer.cTel?:@"",self.userModel.buyer.cPhone?:@""];
        InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
        if (indexPath.row==1) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.titleLabel.text = titleArray[indexPath.row-1];
        cell.titleLabel.font = DR_FONT(15);
        cell.contentTF.placeholder = placeholdArray[indexPath.row-1];
        cell.contentTF.tag = indexPath.row+1;
        cell.contentTF.delegate =self;
        cell.contentTF.text = contentArray[indexPath.row-1];
        
        [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
       
    }

}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, HScale(55))];
    headView.backgroundColor =[UIColor whiteColor];
   
    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, HScale(55))];
    headLab.font =DR_FONT(14);
    headLab.textColor =[UIColor blackColor];
    headLab.textAlignment = 0;
    headLab.text=@"发票类型:";
    [headView addSubview:headLab];
    
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(headLab.width+30, 0,SCREEN_WIDTH/3, HScale(55));
    [self.selectBtn setImage:[UIImage imageNamed:@"Unchecked"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.selectBtn setTitle:@"增值税专用发票" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    self.selectBtn.titleLabel.font =DR_FONT(13);
    self.selectBtn.selected =YES;
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.selectBtn];
    
    self.normelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.normelBtn.frame = CGRectMake(headLab.width+40+self.selectBtn.width, 0,SCREEN_WIDTH/3, HScale(55));
    [self.normelBtn setImage:[UIImage imageNamed:@"Unchecked"] forState:UIControlStateNormal];
    [self.normelBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.normelBtn setTitle:@"增值税普通发票" forState:UIControlStateNormal];
    
    [self.normelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.normelBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    self.normelBtn.titleLabel.font = DR_FONT(13);
    self.normelBtn.selected =NO;
    [self.normelBtn addTarget:self action:@selector(normelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.normelBtn];
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, HScale(55)-1, SCREEN_WIDTH, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [headView addSubview:lineView];
    return headView;
}

-(void)selectBtnClick:(UIButton *)sender
{
    self.normelBtn.selected =NO;
    self.selectBtn.selected =YES;
    
    
}
-(void)normelBtnClick:(UIButton *)sender
{
    
    self.normelBtn.selected =YES;
    self.selectBtn.selected =NO;
   
}
-(void)textFieldChangeAction:(UITextField *)textField
{
   
     if (textField.tag == 2)
    {
        self.userModel.buyer.mobilephone = textField.text;
    }
    else if (textField.tag == 3)
    {
        self.userModel.buyer.name = textField.text;
    }
    else if (textField.tag == 4)
    {
        self.userModel.buyer.companyAddress = textField.text;
    }
    else if (textField.tag == 5)
    {
        self.userModel.buyer.cPhone = textField.text;
    } else if (textField.tag == 6)
    {
        self.userModel.buyer.cName = textField.text;
    }
    else if (textField.tag == 7)
    {
        self.userModel.buyer.cTel = textField.text;
    }
    
   
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==2) {
        return NO;
    }
    return YES;
}
    
///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.view endEditing:YES];
    if (indexPath.row==1)
    {
        ChangeUserNameVC *phoneVC =[[ChangeUserNameVC alloc]init];
        phoneVC.userModel =self.userModel;
        [self.navigationController pushViewController:phoneVC animated:YES];
        NSLog(@"index=%ld",(long)indexPath.row);
    }
//    else if (indexPath.row==2)
//    {
//        [self.navigationController pushViewController:[ChangePhoneVC new] animated:YES];
//        NSLog(@"index=%ld",(long)indexPath.row);
//    }

}

#pragma mark ************  按钮的点击事件  *************
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)info
{
    
}
#pragma mark 点击选择照片
-(void)photoButton:(UIButton *)button
{
    if ([[CanUsePhoto new] isCanUsePhotos]) {
        [self ChangeHeadImage];
    }
    else
    {
        [[CanUsePhoto new] showNotAllowed];
    }
}
#pragma mark 下一步
-(void)nextButton:(UIButton *)button
{
    
    
}


-(void)later
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark **************************  拍照 /相册 ***********************
-(void)ChangeHeadImage
{
    ///初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    ///按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          [self setHeadImageFromTakePhoto];
                      }]];
    ///按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self setHeadImageFromAlbum];
    }]];
    
    ///按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
///拍照选取头像
-(void)setHeadImageFromTakePhoto
{
    /**
     其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
     */
    UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
    //获取方式:通过相机
    PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
    PickerImage.allowsEditing = YES;
    PickerImage.delegate = self;
    [self presentViewController:PickerImage animated:YES completion:nil];
}
///从相册中选取头像
-(void)setHeadImageFromAlbum
{
    ///初始化UIImagePickerController
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    ///获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
    ///获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
    //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.mediaTypes = @[@"public.image"];
    pickerController.navigationBar.translucent = NO;
    [pickerController.navigationBar setBarTintColor:[UIColor whiteColor]];
    pickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [pickerController.navigationBar setTitleTextAttributes:attrs];
    [pickerController.navigationBar setTintColor:[UIColor whiteColor]];
    ///允许剪裁，即放大裁剪
    pickerController.allowsEditing = YES;
    pickerController.delegate = self;
    ///页面跳转
    [self presentViewController:pickerController animated:YES completion:nil];
}
///PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //照片
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
//    [self.avatarBtn setImage:image forState:UIControlStateNormal];
    DRWeakSelf;
    
    [SNAPI userAvatar:image nickName:nil success:^(SNResult *result){
        [MBProgressHUD showSuccess:SNStandardString(@"上传成功")];
        self.userModel.buyer.logo =result.data[@"src"];
        if (weakSelf.changeInfo) {
            weakSelf.changeInfo();
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
