
//
//  CatgoryDetailCell.m
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CatgoryDetailCell.h"
#import "ShopCarDetailModel.h"
@implementation CatgoryDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CatgoryDetailCell";
    CatgoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.shoucangBtn addTarget:cell action:@selector(shoucangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopCarBtn addTarget:cell action:@selector(shopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)shoucangBtnClick:(UIButton *)sender
{
    if (_shopCarBlock) {
        _shoucangBlock(sender.tag);
    }
}
-(void)shopCarBtnClick:(UIButton *)sender
{
    if (_shopCarBlock) {
        _shopCarBlock(sender.tag);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation CatgoryDetailCell1
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
//    static NSString *identify = @"CatgoryDetailCell1";
    CatgoryDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] objectAtIndex:1];        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.danweiBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.danweiBtn.layer.borderWidth =1;
    cell.countTF.layer.borderWidth =1;
    cell.countTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.numberCalculate.delegate =self;
    [cell.danweiBtn addTarget:cell action:@selector(danweiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    cell.selectCountTF.layer.borderColor =[UIColor lightGrayColor].CGColor;
//    cell.selectCountTF.layer.borderWidth =1;
    return cell;
}
//- (IBAction)selectedBtn:(id)sender {
//    UIButton *button =(UIButton *)sender;
//    switch (button.tag) {
//        case 0:
//        {
//            if ([_selectCountTF.text intValue] == 1) {
//                _cutCountBtn.userInteractionEnabled = NO;
//            }else{
//                _selectCountTF.text = [NSString stringWithFormat:@"%d",[_selectCountTF.text intValue] - 1];
//            }
//
//        }
//            break;
//        case 1:
//        {
//            if ([_selectCountTF.text intValue] == [_goodsModel.stock intValue]) {
//                _selectCountTF.text = _goodsModel.stock;
//
//            }else{
//                _selectCountTF.text = [NSString stringWithFormat:@"%d",[_selectCountTF.text intValue] + 1];
//            }
//
//        }
//            break;
//        default:
//            break;
//    }
//
//    _goodsModel.count = _selectCountTF.text;
//
////    [_shopNumBtn setTitle:[NSString stringWithFormat:@"x%@",_changeCountField.text] forState:UIControlStateNormal];
//    if ([self.delegate respondsToSelector:@selector(changeShopCount:)]) {
//        [self.delegate changeShopCount:sender];
//    }
//}
-(void)danweiBtnClick:(UIButton *)sender
{
    if (_danweiBtnBlock) {
        _danweiBtnBlock(sender.tag);
    }
}
- (void)resultNumber:(NSString *)number{
    self.numberCalculate =number;
    NSLog(@"%@>>>resultDelegate>>",number);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
