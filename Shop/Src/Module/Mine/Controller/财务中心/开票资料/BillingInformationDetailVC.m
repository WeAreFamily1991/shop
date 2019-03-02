//
//  InfoChangeViewController.m
//  Dache
//
//  Created by 解辉 on 2018/8/16.
//  Copyright © 2018年 NaDao. All rights reserved.
//

#import "BillingInformationDetailVC.h"
#import "InfoTableViewCell.h"
#import "CGXPickerView.h"

@interface BillingInformationDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,retain)UIButton *selectBtn;
@property (nonatomic,retain)UIButton *normelBtn;
@property (nonatomic,retain)UIButton *saveBtn;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation BillingInformationDetailVC
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
    self.dataDic =[NSMutableDictionary dictionary];
    self.title = @"开票资料";
    ///左侧返回按钮
    //    [self setLeftImageNamed:@"back" action:@selector(back)];
    //
    //    ///右侧按钮
    //    [self setRightImageNamed:@"" action:@selector(info)];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_questions" highlightedIcon:@"" target:self action:@selector(rightBarButtonItem)];
    
    [self.view addSubview:self.tableView];
    [self GetUserInfo];
    if (self.status==0) {
        
        [self addTableViewHeaderView];
        
    }
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
    self.selectBtn.selected =YES;
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
    self.normelBtn.selected =NO;
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
    [self.saveBtn setTitle:@"保存开票资料" forState:UIControlStateNormal];
     [self.saveBtn setTitle:@"保存地址" forState:UIControlStateSelected];

    if (self.status==0) {

        self.saveBtn.selected =NO;
    }
    else
    {
        self.saveBtn.selected =YES;
    }
    
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
    
}
-(void)selectBtnClick:(UIButton *)sender
{
    self.normelBtn.selected =NO;
    self.selectBtn.selected =YES;
    [self.tableView reloadData];
    
}
-(void)normelBtnClick:(UIButton *)sender
{
    
    self.normelBtn.selected =YES;
    self.selectBtn.selected =NO;
    [self.tableView reloadData];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
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
    if (self.status==1) {
        return 4;
    }
    if (section == 0) {
        if (self.selectBtn.selected==YES) {
            return 7;
        }
        else
        {
            return 4;
        }
        
        return 7;
    }
    return 8;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.status==1) {
        return HScale(50);
    }

    if (self.selectBtn.selected==YES) {
        if (indexPath.row==6) {
            return HScale(100);
        }
        return HScale(50);
    }
    else
    {
        return HScale(50);
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
    return 0.01;
}
#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///司机信息
   
        
        NSArray *titleArray =[NSArray array];
        NSArray *placeholdArray=[NSArray array];
        if (self.status==0) {
            titleArray = @[@"单位名称：",@"税号：",@"注册地址：",@"注册电话：",@"开户行：",@"银行账号："];
            placeholdArray= @[@"请输入发票抬头",@"请输入税号",@"请输入注册地址",@"请输入注册电话",@"请输入人开户行名称",@"请输入银行账号"];
             if (indexPath.row <6) {
                 NSArray *contentArray = @[@" ",name?:@"",phone?:@""];
                 
                 
                 InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
                 
                 cell.titleLabel.text = titleArray[indexPath.row];
                 cell.titleLabel.font = DR_FONT(15);
                 cell.contentTF.placeholder = placeholdArray[indexPath.row];
                 cell.contentTF.tag = indexPath.row;
                 //            cell.contentTF.text = contentArray[indexPath.row];
                 
                 [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
                 
                 //            if (indexPath.row == 0) {
                 //                cell.contentTF.hidden = YES;
                 //                cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WScale(15)];
                 //            }
                 //            if (indexPath.row == 2) {
                 //                cell.contentTF.keyboardType = UIKeyboardTypePhonePad;
                 //            }
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 return cell;
             }
            ///身份证号码,上传照片
             else
             {
                 InfoTableViewCell4 *cell = [InfoTableViewCell4 cellWithTableView:tableView];
                 NSString *tagStr = [NSString stringWithFormat:@"%ld%@",indexPath.row-3,@"1"];
                 cell.photoBtn.tag = [tagStr intValue];
                 [cell.photoBtn addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
                 id imgStr1 = heImg1?:@"1";
                 
                 if ([imgStr1 isKindOfClass:[NSString class]]) {
                     
                     [cell.photoBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:imgStr1] forState:UIControlStateNormal];
                 }
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 return cell;
             }
        }
        else
        {
            NSArray *contentArray = @[name?:@"",name?:@"",phone?:@"",name?:@""];
            
            titleArray= @[@"所在地区：",@"详细地址：",@"收票人：",@"联系电话："];
            placeholdArray = @[@"请选择所在地区",@"请输入详细地址",@"请输入收票人",@"请输入联系电话"];
            InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
            if (indexPath.row == 0)
            {
                cell.contentTF.enabled = NO;
            }
            cell.titleLabel.text = titleArray[indexPath.row];
            cell.titleLabel.font = DR_FONT(15);
            cell.contentTF.placeholder = placeholdArray[indexPath.row];
            cell.contentTF.tag = indexPath.row;
            //            cell.contentTF.text = contentArray[indexPath.row];
            
            [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
            
            //            if (indexPath.row == 0) {
            //                cell.contentTF.hidden = YES;
            //                cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WScale(15)];
            //            }
            //            if (indexPath.row == 2) {
            //                cell.contentTF.keyboardType = UIKeyboardTypePhonePad;
            //            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
          
        }
        
//        NSArray *titleArray = @[@"单位名称：",@"税号：",@"注册地址：",@"注册电话：",@"开户行：",@"银行账号："];
//        NSArray *placeholdArray = @[@"请输入发票抬头",@"请输入税号",@"请输入注册地址",@"请输入注册电话",@"请输入人开户行名称",@"请输入银行账号"];
      
    
//    else
//    {
//        ///车辆信息
//        NSArray *titleArray = @[@"車輛信息",@"車牌號",@"車型",@"車輛註冊時間"];
//        NSArray *placeholdArray = @[@" ",@"請輸入車牌號",@"請選擇車型",@"請選擇車輛註冊時間"];
//        NSArray *contentArray = @[@" ",carID?:@"",carType?:@"",time?:@""];
//        if (indexPath.row <4)
//        {
//            InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
//            cell.titleLabel.text = titleArray[indexPath.row];
//            cell.contentTF.placeholder = placeholdArray[indexPath.row];
//            cell.contentTF.tag = indexPath.row+3;
//            cell.contentTF.text = contentArray[indexPath.row];
//            cell.titleLabel.font = DR_FONT(14);
//            [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
//            if (indexPath.row == 0) {
//                cell.contentTF.hidden = YES;
//                cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WScale(15)];
//            }
//            if (indexPath.row == 2 || indexPath.row == 3) {
//                cell.contentTF.enabled = NO;
//            }
//            else
//            {
//                cell.contentTF.enabled = YES;
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//        ///上传照片
//        else if (indexPath.row < 6)
//        {
//            InfoTableViewCell2 *cell = [InfoTableViewCell2 cellWithTableView:tableView];
//            NSArray *titleArray = @[@"駕駛證",@"行駛證",@"人車合影(45度拍攝,勿遮擋車牌)"];
//            cell.contentTF2.hidden = YES;
//            cell.titleLabel2.text = titleArray[indexPath.row-4];
//            NSString *tagStr = [NSString stringWithFormat:@"%ld%@",indexPath.row-3,@"1"];
//            NSString *tagStr2 = [NSString stringWithFormat:@"%ld%@",indexPath.row-3,@"2"];
//            cell.photoButton1.tag = [tagStr intValue];
//            cell.photoButton2.tag = [tagStr2 intValue];
//            [cell.photoButton1 addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.photoButton2 addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
//            NSArray *imgArray1 = @[jiaImg1?:@"pic_jiashizhengzuoce",xingImg1?:@"pic_xingshizhengzuoce",heImg1?:@"pic_rencheheying"];
//            NSArray *imgArray2 = @[jiaImg2?:@"pic_jiashizhengyouce",xingImg2?:@"pic_xingshizhengyouce",heImg2?:@"pic_rencheheying"];
//            id imgStr1 = imgArray1[indexPath.row-4];
//            id imgStr2 = imgArray2[indexPath.row-4];
//            if ([imgStr1 isKindOfClass:[NSString class]]) {
//                NSLog(@"YYYYYYYYYY == %@",imgStr1);
//                [cell.photoButton1 sd_setBackgroundImageWithURL:[NSURL URLWithString:imgStr1] forState:UIControlStateNormal];
//            }
//            if ([imgStr2 isKindOfClass:[NSString class]]) {
//                [cell.photoButton2 sd_setBackgroundImageWithURL:[NSURL URLWithString:imgStr2] forState:UIControlStateNormal];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//        else if (indexPath.row == 6)
//        {
//            InfoTableViewCell4 *cell = [InfoTableViewCell4 cellWithTableView:tableView];
//
//            cell.titleLabel.text = @"人車合影(45度拍攝,勿遮擋車牌)";
//            NSString *tagStr = [NSString stringWithFormat:@"%ld%@",indexPath.row-3,@"1"];
//            cell.photoBtn.tag = [tagStr intValue];
//            [cell.photoBtn addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
//            id imgStr1 = heImg1?:@"pic_rencheheying";
//
//            if ([imgStr1 isKindOfClass:[NSString class]]) {
//
//                [cell.photoBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:imgStr1] forState:UIControlStateNormal];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//        ///下一步
//        InfoTableViewCell3 *cell = [InfoTableViewCell3 cellWithTableView:tableView];
//        [cell.nextButton setTitle:@"完成" forState:UIControlStateNormal];
//        [cell.nextButton addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    if (textField.tag == 1) {
        name = textField.text;
    }
    else if (textField.tag == 2)
    {
        phone = textField.text;
    }
    else if (textField.tag == 3)
    {
        identifyID = textField.text;
    }
    else if (textField.tag == 4)
    {
        carID = textField.text;
    }
}
///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    if (indexPath.row==0&&self.status==1) {
        [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
            
            NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
//            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
        }];
    }
//    ///选择车型
//    if (indexPath.row == 2) {
//
//    }
//    ///选择注册时间
//    else if (indexPath.row == 3)
//    {
//
//
//    }
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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

        Tag = button.tag;
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
    
    UIImage *newPhoto = info[UIImagePickerControllerEditedImage];
//    NSData *imgData = UIImageJPEGRepresentation(newPhoto, 0.2f);
    heImg1 = newPhoto;
    [self.tableView reloadData];
    // NSString*imgStr = [imgData base64EncodedStringWithOptions:0];
//    [Interface_UploadPhoto UploadPhoto:newPhoto
//                           sccessBlock:^(NSDictionary *data, NSString *message)
//     {
//         [self.tableView reloadData];
//         [self dismissViewControllerAnimated:YES completion:nil];
//     } FailBlock:^() {
//         [MBProgressHUD showError:@"上传图片失败,请重试"];
//     }];
    NSLog(@"TTTTTTTT == %ld",Tag);
    //    switch (Tag) {
    //        case 1:
    //            identifyImg1 = newPhoto;
    //            break;
    //        case 2:
    //            identifyImg2 = newPhoto;
    //            break;
    //        case 11:
    //            jiaImg1 = newPhoto;
    //            break;
    //        case 12:
    //            jiaImg2 = newPhoto;
    //            break;
    //        case 21:
    //            xingImg1 = newPhoto;
    //            break;
    //        case 22:
    //            xingImg2 = newPhoto;
    //            break;
    //        case 31:
    //            heImg1 = newPhoto;
    //            break;
    //        case 32:
    //            heImg2 = newPhoto;
    //            break;
    //        default:
    //            break;
    //    }
    //    [self.tableView reloadData];
    //    [self dismissViewControllerAnimated:YES completion:nil];
//    [Interface_UploadPhoto UploadPhoto:newPhoto
//                           sccessBlock:^(NSDictionary *data, NSString *message)
//     {
//         switch (Tag) {
//             case 1:
//                 identifyImg1 = data[@"data"][@"pic"] ;
//                 //                 [UserModel sharedManager].identifyImg1 =identifyImg1;
//                 [self.dataDic setObject:data[@"data"][@"pic"] forKey:@"shenfenzheng"];
//                 break;
//             case 2:
//                 identifyImg2 = data[@"data"][@"pic"] ;
//                 //                 [UserModel sharedManager].identifyImg2 =identifyImg2;
//                 [self.dataDic setObject:data[@"data"][@"pic"] forKey:@"shenfenfan"];
//                 break;
//             case 11:
//                 jiaImg1 = data[@"data"][@"pic"] ;
//                 //                 [UserModel sharedManager].jiaImg1 =jiaImg1;
//                 [self.dataDic setObject:data[@"data"][@"pic"] forKey:@"jiazhaozheng"];
//                 break;
//             case 12:
//                 jiaImg2 = data[@"data"][@"pic"] ;
//                 //                 [UserModel sharedManager].jiaImg2 =jiaImg2;
//                 [self.dataDic setObject:data[@"data"][@"pic"] forKey:@"jiazhaofan"];
//                 break;
//             case 21:
//                 xingImg1 = data[@"data"][@"pic"] ;
//                 //                 [UserModel sharedManager].xingImg1 =xingImg1;
//                 [self.dataDic setObject:data[@"data"][@"pic"] forKey:@"xingshizheng"];
//                 break;
//             case 22:
//                 xingImg2 = data[@"data"][@"pic"] ;
//                 //                 [UserModel sharedManager].xingImg2 =xingImg2;
//                 [self.dataDic setObject:data[@"data"][@"pic"] forKey:@"xingshifan"];
//                 break;
//             case 31:
//                 heImg1 = data[@"data"][@"pic"] ;
//                 //                 [UserModel sharedManager].heImg1 =heImg1;
//                 [self.dataDic setObject:data[@"data"][@"pic"] forKey:@"renche"];
//                 break;
//             case 32:
//                 heImg2 = data[@"data"][@"pic"] ;
//                 break;
//             default:
//                 break;
//         }
//         [self.tableView reloadData];
//         [self dismissViewControllerAnimated:YES completion:nil];
//     } FailBlock:^() {
//         [MBProgressHUD showError:@"上传图片失败,请重试"];
//     }];
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
