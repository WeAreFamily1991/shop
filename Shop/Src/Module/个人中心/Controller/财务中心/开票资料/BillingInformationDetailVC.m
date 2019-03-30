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
#import "BillInfoModel.h"
@interface BillingInformationDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,retain)UIButton *selectBtn;
@property (nonatomic,retain)UIButton *normelBtn;
@property (nonatomic,retain)UIButton *saveBtn;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,retain)BillInfoModel *infoModel;
@property (nonatomic,retain)InvoiceReceiverModel *receiverModel;
@end

@implementation BillingInformationDetailVC
-(void)GetInfo
{
    DRWeakSelf;
    
    NSString *urlStr =self.status?@"buyer/invoiceInfo":@"buyer/ticketInfo";
    
    [SNIOTTool getWithURL:urlStr parameters:nil success:^(SNResult *result) {
        
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            if (weakSelf.status==0) {
                
                weakSelf.infoModel =[BillInfoModel mj_objectWithKeyValues:result.data];
                 self.selectBtn.selected =[self.infoModel.ticketType boolValue];
                self.normelBtn.selected =![self.infoModel.ticketType boolValue];
            }else
            {
                weakSelf.receiverModel =[InvoiceReceiverModel mj_objectWithKeyValues:result.data];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataDic =[NSMutableDictionary dictionary];
    self.title = @"开票资料";
    [self.view addSubview:self.tableView];
    [self GetInfo];
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
    [self.selectBtn setImage:[UIImage imageNamed:@"Unchecked"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.selectBtn setTitle:@"增值税专用发票" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    self.selectBtn.titleLabel.font =DR_FONT(13);
   
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
            return HScale(60);
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
                 NSArray *contentArray = @[self.infoModel.ticketCompany?:@"",self.infoModel.taxNumber?:@"",self.infoModel.regAddress?:@"",self.infoModel.regPhone?:@"",self.infoModel.bank?:@"",self.infoModel.bankNo?:@""];
                 
                 
                 InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
                 cell.titleLabel.text = titleArray[indexPath.row];
                 cell.titleLabel.font = DR_FONT(15);
                 cell.contentTF.placeholder = placeholdArray[indexPath.row];
                 cell.contentTF.tag = indexPath.row;
                 cell.contentTF.text = contentArray[indexPath.row];
                 
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
                 InfoTableViewCell6 *cell = [InfoTableViewCell6 cellWithTableView:tableView];
                 NSString *tagStr = [NSString stringWithFormat:@"%ld%@",indexPath.row-3,@"1"];
                 cell.photoBtn.tag = [tagStr intValue];
                 [cell.photoBtn addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
                 id imgStr1 = self.infoModel.imgUrl?:@"default_head";
//                 cell.photoBtn sd_ba
                 [cell.photoBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:imgStr1] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_head"] options:0];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 return cell;
             }
        }
        else
        {
            NSArray *contentArray = @[self.receiverModel.invoiceReceiverlocationArea?:@"",self.receiverModel.invoiceReceiverAddress?:@"",self.receiverModel.invoiceReceiverName?:@"",self.receiverModel.invoiceReceiverMobile?:@""];
            
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
            cell.contentTF.text = contentArray[indexPath.row];
//            if (indexPath.row==3) {
//                cell.contentTF.keyboardType =UIKeyboardTypeNumberPad;
//            }
            [cell.contentTF addTarget:self action:@selector(textFieldfirstChangeAction:) forControlEvents:UIControlEventEditingChanged];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
          
        }
}
-(void)textFieldfirstChangeAction:(UITextField *)textField
{
    
    if (textField.tag==0) {
        self.receiverModel.invoiceReceiverlocationArea = textField.text;
    }
    else if (textField.tag == 1) {
        self.receiverModel.invoiceReceiverAddress = textField.text;
    }
    else if (textField.tag == 2)
    {
        self.receiverModel.invoiceReceiverName = textField.text;
    }
    else if (textField.tag == 3)
    {
        self.receiverModel.invoiceReceiverMobile = textField.text;
    }
}
-(void)textFieldChangeAction:(UITextField *)textField
{
  
    if (textField.tag==0) {
        
        self.infoModel.ticketCompany = textField.text;
    }
    else if (textField.tag == 1) {
        self.infoModel.taxNumber = textField.text;
    }
    else if (textField.tag == 2)
    {
        self.infoModel.regAddress = textField.text;
    }
    else if (textField.tag == 3)
    {
        self.infoModel.regPhone = textField.text;
    }
    else if (textField.tag == 4)
    {
        self.infoModel.bank = textField.text;
    }
    else if (textField.tag==5)
    {
        self.infoModel.bankNo =textField.text;
    }
}
///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    if (indexPath.row==0&&self.status==1) {
        [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
            
            NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
            self.receiverModel.invoiceReceiverlocationArea =[NSString stringWithFormat:@"%@/%@/%@",selectAddressArr[0],selectAddressArr[1],selectAddressArr[2]];
            self.receiverModel.invoiceReceiverlocation =[NSString stringWithFormat:@"%@/%@/%@",selectAddressArr[3],selectAddressArr[4],selectAddressArr[5]];
            [self.tableView reloadData];
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
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    //    [self.avatarBtn setImage:image forState:UIControlStateNormal];
    DRWeakSelf;
    
    [SNAPI userAvatar:image nickName:nil success:^(SNResult *result){
        [MBProgressHUD showSuccess:SNStandardString(@"上传成功")];
        weakSelf.infoModel.imgUrl =result.data[@"src"];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 按钮点击事件
-(void)saveBtnClick:(UIButton *)sender
{
    
    if (self.status==0) {
    
        NSDictionary *dic =[NSDictionary dictionary];
        NSMutableDictionary *muDic  =[NSMutableDictionary dictionary];
        NSString *  urlStr;
        if (self.selectBtn.selected)
        {
            dic=@{@"ticketCompany":self.infoModel.ticketCompany?:@"",@"taxNumber":self.infoModel.taxNumber?:@"",@"regAddress":self.infoModel.regAddress?:@"",@"regPhone":self.infoModel.regPhone?:@"",@"bank":self.infoModel.bank?:@"",@"bankNo":self.infoModel.bankNo?:@"",@"ticketType":@"1",@"imgUrl":self.infoModel.imgUrl?:@""};
            urlStr=@"buyer/updateIncrementTickert";
            muDic=[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"ticket"];
        }
        else
        {
            dic=@{@"ticketCompany":self.infoModel.ticketCompany?:@"",@"taxNumber":self.infoModel.taxNumber?:@"",@"regAddress":self.infoModel.regAddress?:@"",@"regPhone":self.infoModel.regPhone?:@"",@"ticketType":@"0"};
            urlStr=@"buyer/updateTicket";
            muDic=[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"ticket"];
        }
        
        [SNAPI postWithURL:urlStr parameters:muDic success:^(SNResult *result) {
            if (result.state==200) {
                [MBProgressHUD showSuccess:result.data];
            }
        } failure:^(NSError *error) {
        }];
    }
    else
    {
       
        NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.receiverModel.invoiceReceiverlocation?:@"",self.receiverModel.invoiceReceiverAddress?:@"",self.receiverModel.invoiceReceiverName?:@"",self.receiverModel.invoiceReceiverMobile?:@""] forKeys:@[@"invoiceReceiverlocation",@"invoiceReceiverAddress",@"invoiceReceiverName",@"invoiceReceiverMobile"]];
        [SNAPI postWithURL:@"buyer/updateInvoice" parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                [MBProgressHUD showSuccess:result.data];
            }
        } failure:^(NSError *error) {
        }];
    }
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
