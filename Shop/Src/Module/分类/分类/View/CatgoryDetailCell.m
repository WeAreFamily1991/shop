
//
//  CatgoryDetailCell.m
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CatgoryDetailCell.h"
#import "ShopCarDetailModel.h"
#import "GoodsModel.h"


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
    if ([_goodsModel.qty intValue]!=0) {
        
        if (_shopCarBlock) {
            _shopCarBlock(sender.tag);
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    NSLog(@"id =%@",goodsModel.favariteId);
//    if (goodsModel.favariteId.length!=0) {
//        self.shoucangBtn.selected =YES;
//    }
//    else
//    {
//       self.shoucangBtn.selected =NO;
//    }
    if ([goodsModel.qty intValue]==0) {
        self.shopCarBtn.selected =YES;
    }
    else
    {
       self.shopCarBtn.selected =NO;
    }
    
    
    
}
@end
@interface  CatgoryDetailCell1 ()<NumberCalculateDelegate>

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
    cell.numberCalculate.delegate =cell;
    [cell.danweiBtn addTarget:cell action:@selector(danweiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    cell.selectCountTF.layer.borderColor =[UIColor lightGrayColor].CGColor;
//    cell.selectCountTF.layer.borderWidth =1;
    return cell;
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    
   
}
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
