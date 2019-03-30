//
//  SaleOrderCell.m
//  Shop
//
//  Created by BWJ on 2019/2/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SaleOrderCell.h"
#import "SalesOrderModel.h"
@implementation SaleOrderCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell";
    SaleOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    [cell.collectSelectBtn addTarget:cell action:@selector(collectSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.phoneBtn addTarget:cell action:@selector(phoneBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.detailBtn.layer.masksToBounds=cell.detailBtn.dc_height/2;
    cell.detailBtn.layer.cornerRadius =cell.detailBtn.dc_height/2;
    return cell;
}
-(void)setSaleModel:(SalesOrderModel *)saleModel
{
    self.orderLab.text =[NSString stringWithFormat:@"对账单号：%@",saleModel.dzNo];
    self.getTimeLab.text =[NSString stringWithFormat:@"生成日期：%@",[SNTool StringTimeFormat:saleModel.createTime]];
    self.saleTimeLab.text =[NSString stringWithFormat:@"对账账期：%@",saleModel.dzPeriod];
    self.saleCountLab.text =[NSString stringWithFormat:@"对账数量：%.2f",[saleModel.qty doubleValue]];
    self.moneyCountLab.text =[NSString stringWithFormat:@"对账金额：%.2f",[saleModel.totalOrderAmt doubleValue]];
}

- (IBAction)detailBtnClick:(id)sender {
    !_detailClickBlock ? : _detailClickBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end



@implementation SaleOrderCell1
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell1";
    SaleOrderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
 
    cell.detailBtn.layer.masksToBounds=cell.detailBtn.dc_height/2;
    cell.detailBtn.layer.cornerRadius =cell.detailBtn.dc_height/2;
    return cell;
}
-(void)setSaleModel:(SalesOrderModel *)saleModel
{
    
    self.orderLab.text =[NSString stringWithFormat:@"对账单号：%@",saleModel.dzNo];
    self.getTimeLab.text =[NSString stringWithFormat:@"生成日期：%@",[SNTool StringTimeFormat:saleModel.createTime]];
    self.saleTimeLab.text =[NSString stringWithFormat:@"对账账期：%@",saleModel.dzPeriod];
    self.saleCountLab.text =[NSString stringWithFormat:@"对账数量：%.2f",[saleModel.qty doubleValue]];
}
- (IBAction)detailBtnClick:(id)sender {
     !_detailClickBlock ? : _detailClickBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@implementation SaleOrderCell2
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell2";
    SaleOrderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] objectAtIndex:2];
        
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
    
    
    cell.contentBtn.layer.borderWidth =1;
    cell.contentBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.contentBtn.layer.cornerRadius=cell.contentBtn.dc_height/2;
    cell.contentBtn.layer.masksToBounds =cell.contentBtn.dc_height/2;
    
    cell.returnBackBtn.layer.borderWidth =1;
    cell.returnBackBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.returnBackBtn.layer.cornerRadius=cell.returnBackBtn.dc_height/2;
    cell.returnBackBtn.layer.masksToBounds =cell.returnBackBtn.dc_height/2;
    
    cell.detailBtn.layer.borderWidth =1;
    cell.detailBtn.layer.borderColor =[UIColor redColor].CGColor;
    cell.detailBtn.layer.cornerRadius=cell.detailBtn.dc_height/2;
    cell.detailBtn.layer.masksToBounds =cell.detailBtn.dc_height/2;
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
}
- (IBAction)btn:(id)sender {
    UIButton *btn =(UIButton *)sender;
    if (_BtntagBlock) {
        _BtntagBlock(btn.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end



@implementation SaleOrderCell3
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SaleOrderCell3";
    SaleOrderCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SaleOrderCell" owner:nil options:nil] objectAtIndex:3];
        
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
