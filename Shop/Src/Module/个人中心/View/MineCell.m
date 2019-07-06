//
//  MineCell.m
//  Shop
//
//  Created by BWJ on 2019/2/19.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"MineCell";
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.iconBtn.layer.masksToBounds =30;
    cell.iconBtn.layer.cornerRadius =30;
    cell.groundView.layer.cornerRadius =5;
    cell.groundView.layer.masksToBounds =5;
    [cell.dealOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.aftersaleBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.arrivalnoticeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.shoucangBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.diyongBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.dealOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.aftersaleBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.arrivalnoticeBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shoucangBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.diyongBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.setBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.iconBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    

    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
    if (_BtnManagetagBlock) {
        _BtnManagetagBlock (sender.tag);
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end



@implementation MineCell2
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"MineCell2";
    MineCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineCell" owner:nil options:nil] objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.groundView.layer.cornerRadius =5;
    cell.groundView.layer.masksToBounds =5;
    [cell.shopOrderBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.kaipiaoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.shenqingBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.jiluBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.kaipiaoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shenqingBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.jiluBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopOrderBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
    if (_BtnMoneytagBlock) {
        _BtnMoneytagBlock (sender.tag);
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@implementation MineCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"MineCell3";
    MineCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineCell" owner:nil options:nil] objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.groundView.layer.cornerRadius =5;
    cell.groundView.layer.masksToBounds =5;
    [cell.kefuBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.messageBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.personBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.changePWBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.shouhuoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.childBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.guanlianBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.loginOutBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    
    [cell.kefuBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.personBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.changePWBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shouhuoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.childBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.guanlianBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.loginOutBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
    if (_BtnOthertagBlock) {
        _BtnOthertagBlock (sender.tag);
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end



@implementation MineCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"MineCell4";
    MineCell4 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineCell" owner:nil options:nil] objectAtIndex:3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.groundView.layer.cornerRadius =5;
    cell.groundView.layer.masksToBounds =5;
    [cell.kefuBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.messageBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.personBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.changePWBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.shouhuoBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.guanlianBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [cell.loginOutBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    
    [cell.kefuBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.personBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.changePWBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shouhuoBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.guanlianBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.loginOutBtn addTarget:cell action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}
-(void)BtnClick:(UIButton *)sender
{
    
    if (_BtnOthertagBlock) {
        _BtnOthertagBlock (sender.tag);
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
