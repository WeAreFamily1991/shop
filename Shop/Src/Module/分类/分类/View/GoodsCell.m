//
//  GoodsCell.m
//  Shop
//
//  Created by BWJ on 2019/4/2.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"GoodsCell";
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    if ([goodsModel.serviceType isEqualToString:@"0"]) {
        self.cangkuLab.text =@"本地云仓（三铁配送）";
        
    }
    else if ([goodsModel.serviceType isEqualToString:@"st"])
    {
        self.cangkuLab.text =@"卖家库存（三铁配送）";
    }
    else if ([goodsModel.serviceType isEqualToString:@"zf"])
    {
        self.cangkuLab.text =@"卖家库存（卖家直发）";
    }
    if ([goodsModel.sellerTypeCode intValue]==0) {
        [self.ziyingBtn setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [self.ziyingBtn setTitle:@"自营" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =[UIColor redColor];
    }else if ([goodsModel.sellerTypeCode intValue]==1)
    {
        [self.ziyingBtn setBackgroundImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
         [self.ziyingBtn setTitle:@"厂家" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =[UIColor blackColor];
    }
    else if ([goodsModel.sellerTypeCode intValue]==2)
    {
         [self.ziyingBtn setBackgroundImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
         [self.ziyingBtn setTitle:@"批发商" forState:UIControlStateNormal];
        self.ziyingpeisongLab.textColor =[UIColor blackColor];
    }
    self.ziyingpeisongLab.text =goodsModel.compName;
    self.kaipiaoLab.text =[NSString stringWithFormat:@"开票方：%@",goodsModel.kpName];
    NSString *sellTypeCodeStr;
    if (![goodsModel.sellerTypeCode isEqualToString:@"0"]) {
        sellTypeCodeStr =@"";
        
        if ([goodsModel.priceType isEqualToString:@"0"]) {
            sellTypeCodeStr =@"含税";
        }
        else if ([goodsModel.priceType isEqualToString:@"1"]) {
            sellTypeCodeStr =@"未税";
        }
        
        if ([goodsModel.isHy isEqualToString:@"0"]) {
            sellTypeCodeStr =[NSString stringWithFormat:@"%@含运",sellTypeCodeStr];
        }
        else if ([goodsModel.isHy isEqualToString:@"1"]) {
            sellTypeCodeStr =[NSString stringWithFormat:@"%@不含运",sellTypeCodeStr];
        }
    }
    self.jiesuanLab.text =[NSString stringWithFormat:@"%@ |%@",goodsModel.payType?@"月结":@"现金",sellTypeCodeStr];//未完待续
    
    
}
- (IBAction)callBtnClick:(id)sender {
     !_selectlickBlock?:_selectlickBlock();
}

@end
