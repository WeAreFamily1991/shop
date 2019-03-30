//
//  CollectionCell.m
//  Shop
//
//  Created by BWJ on 2019/2/25.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CollectionCell.h"
#import "VoucherModel.h"
@implementation CollectionCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell";
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.collectSelectBtn addTarget:cell action:@selector(collectSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [cell.phoneBtn addTarget:cell action:@selector(phoneBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)collectSelectBtnClick:(UIButton *)sender
{
    if (_collectionSelectBlock) {
        _collectionSelectBlock(sender.tag);
    }
}
-(void)phoneBtnBtnClick:(UIButton *)sender
{
    if (_phoneBlock) {
        _phoneBlock(sender.tag);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation CollectionCell1
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell1";
    CollectionCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }  
    return cell;
}
-(void)setVouchModel:(VoucherModel *)vouchModel
{
    _vouchModel =vouchModel;
    
    self.moneyCountLab.text =[NSString stringWithFormat:@"￥%.0f",vouchModel.voucherSum];
    self.manjianLab.text =[NSString stringWithFormat:@"满%.0f可用",vouchModel.voucherCond];
    self.titleLab.text =vouchModel.topicType?@"店铺抵用券":@"平台抵用券";
    self.titleLab.textColor =vouchModel.topicType?RGBHex(0x0094ec):[UIColor redColor];
    
    self.conditionLab.text =[NSString stringWithFormat:@"￥%@",vouchModel.descriptionStr];
    if (vouchModel.endtime==4102329600000) {
        self.timeLab.text =@"无门槛、无时间限制、无产品限制";
    }
    else
    {
        self.timeLab.text =[NSString stringWithFormat:@"%@-%@",[SNTool yearMonthTimeFormat:[NSString stringWithFormat:@"%ld",(long)vouchModel.starttime]],[SNTool yearMonthTimeFormat:[NSString stringWithFormat:@"%ld",(long)vouchModel.endtime]]];
    }
    self.hidenBtn.hidden =!vouchModel.valid;
    self.moneyCountLab.text =[NSString stringWithFormat:@"￥%.0f",vouchModel.voucherSum];
    
}
-(void)BtnClick:(UIButton *)sender
{
   
}
- (IBAction)statusBtnClick:(id)sender {
    !_selectlickBlock?:_selectlickBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

@implementation CollectionCell2
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell2";
    CollectionCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    cell.groundView.layer.cornerRadius =5;
    //    cell.groundView.layer.masksToBounds =5;
    //    [cell.shopOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.kaipiaoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shenqingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.jiluBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.kaipiaoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shenqingBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.jiluBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end



@implementation CollectionCell3
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell3";
    CollectionCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    cell.groundView.layer.cornerRadius =5;
    //    cell.groundView.layer.masksToBounds =5;
    //    [cell.shopOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.kaipiaoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shenqingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.jiluBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.kaipiaoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shenqingBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.jiluBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end






@implementation CollectionCell4
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell4";
    CollectionCell4 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:4];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}
- (IBAction)btnClick:(id)sender {
    UIButton *btn =(UIButton *)sender;
    NSLog(@"btn=%ld",(long)btn.tag);
    if (_BtnBlock) {
        _BtnBlock(btn.tag);
    }
}
-(void)setStatus:(NSInteger)status
{
    switch (status) {
        case 0:
        {
            
        }
            
            break;
            
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];    
    // Configure the view for the selected state
}
@end



@implementation CollectionCell5
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell5";
    CollectionCell5 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:5];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    cell.groundView.layer.cornerRadius =5;
    //    cell.groundView.layer.masksToBounds =5;
    //    [cell.shopOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.kaipiaoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shenqingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.jiluBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.kaipiaoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shenqingBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.jiluBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end



@implementation CollectionCell6
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell6";
    CollectionCell6 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:6];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    cell.groundView.layer.cornerRadius =5;
    //    cell.groundView.layer.masksToBounds =5;
    //    [cell.shopOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.kaipiaoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shenqingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.jiluBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.kaipiaoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shenqingBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.jiluBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end


@implementation CollectionCell7
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CollectionCell7";
    CollectionCell7 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:nil options:nil] objectAtIndex:7];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    cell.groundView.layer.cornerRadius =5;
    //    cell.groundView.layer.masksToBounds =5;
    //    [cell.shopOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.kaipiaoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shenqingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.jiluBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.kaipiaoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shenqingBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.jiluBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
@end
