
//
//  CatgoryDetailCell.m
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CatgoryDetailCell.h"

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
