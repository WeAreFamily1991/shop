//
//  FirstTableViewCell.m
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "Masonry.h"
#import "NSString+Extension.h"
#define ZF_FONT(__fontsize__) [UIFont systemFontOfSize:WScale(__fontsize__)]
@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setDataDict:(NSDictionary *)dataDict
{
    self.productImg.image = [UIImage imageNamed:@"product"];
    self.productName.text = @"哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";

    NSArray * array =[NSArray array];
    if (_selectRow==1) {
            }
    else
    {
        array = @[@"M14-2.0*110",@" 12.9级",@"40Cr(合金钢)",@"淬黑",@"紧固之星"];

    }


    HeightF = WScale(30);
    [self setStandWithArray:array];

    self.parameterLabel.text = @"包装参数：哈哈哈哈哈 哈哈哈哈哈 ";
    //    self.cellLabel.text = @"最小销售单位：哈哈哈哈哈 哈哈哈哈哈 或或或或或或或或 哈哈哈";
    //    self.countLabel.text = @"库存数：72.0000支 华东仓";
}
-(void)setGoodListModel:(GoodsListModel *)goodListModel
{
    _goodListModel =goodListModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodListModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodListModel.itemName;
    NSArray * array = @[goodListModel.spec?:@"",goodListModel.levelname?:@"",goodListModel.materialname?:@"",goodListModel.surfacename?:@"",goodListModel.brandname?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    HeightF = WScale(30);
    [self setStandWithArray:titArr.copy];
    self.parameterLabel.text = [NSString stringWithFormat:@"购买数量：%.3f%@  小计：￥%.2f",goodListModel.qty,goodListModel.basicUnitName,goodListModel.realAmt];
}

-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;

    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodsModel.imgurl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodsModel.itemname;
    NSArray * array = @[goodsModel.spec?:@"",goodsModel.levelname?:@"",goodsModel.materialname?:@"",goodsModel.surfacename?:@"",goodsModel.brandname?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    HeightF = WScale(30);
    [self setStandWithArray:titArr];

    NSString *baseStr;//basicunitid 5千支  6公斤  7吨
    if ([goodsModel.basicunitid intValue]==5) {
        baseStr =@"千支";
    }
    if ([goodsModel.basicunitid intValue]==6) {
        baseStr =@"公斤";
    }
    if ([goodsModel.basicunitid intValue]==7) {
        baseStr =@"吨";
    }
    
    
    NSString *nameStr,*cellStr;
    if (goodsModel.unitconversion1.length!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodsModel.unitconversion1 doubleValue],baseStr,goodsModel.unitname1];
        cellStr =goodsModel.unitname1;
    }
    if (goodsModel.unitconversion2.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion2 doubleValue],baseStr,goodsModel.unitname2];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitname2;

        }
    }
    if (goodsModel.unitconversion3.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion3 doubleValue],baseStr,goodsModel.unitname3];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitname3;

        }
    }
    if (goodsModel.unitconversion4.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion4 doubleValue],baseStr,goodsModel.unitname4];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitname4;

        }
    }
    if (goodsModel.unitconversion5.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion5 doubleValue],baseStr,goodsModel.unitname5];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitname5;

        }
    }

    self.parameterLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];;
    self.cellLabel.text =[NSString stringWithFormat:@"最小销售单位: %@  单规格起订量: %.3f%@",cellStr,[goodsModel.minquantity doubleValue],cellStr] ;
    self.countLabel.text =[NSString stringWithFormat:@"库存数(%@): %.3f  %@",baseStr,[goodsModel.qty doubleValue],goodsModel.storeName] ;
}

-(void)setGoodSellOutModel:(GoodsList *)goodSellOutModel
{
    _goodSellOutModel =goodSellOutModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodSellOutModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodSellOutModel.itemName;
    NSArray * array = @[goodSellOutModel.spec?:@"",goodSellOutModel.levelname?:@"",goodSellOutModel.materialname?:@"",goodSellOutModel.surfacename?:@"",goodSellOutModel.brandname?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
        HeightF = WScale(30);
        [self setStandWithArray:titArr.copy];
    NSString *baseStr;//basicunitid 5千支  6公斤  7吨
    if ([goodSellOutModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([goodSellOutModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([goodSellOutModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    NSString *nameStr,*cellStr;
    if (goodSellOutModel.unitConversion1.length!=0&&![goodSellOutModel.unitConversion1 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodSellOutModel.unitConversion1 doubleValue],baseStr,goodSellOutModel.unitName1];
        cellStr =goodSellOutModel.unitName1;
    }
    if (goodSellOutModel.unitConversion2.length!=0&&![goodSellOutModel.unitConversion2 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion2 doubleValue],baseStr,goodSellOutModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName2;
            
        }
    }
    if (goodSellOutModel.unitConversion3.length!=0&&![goodSellOutModel.unitConversion3 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion3 doubleValue],baseStr,goodSellOutModel.unitName3];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName3;
            
        }
    }
    if (goodSellOutModel.unitConversion4.length!=0&&![goodSellOutModel.unitConversion4 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion4 doubleValue],baseStr,goodSellOutModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName4;
            
        }
    }
    if (goodSellOutModel.unitConversion5.length!=0&&![goodSellOutModel.unitConversion5 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion5 doubleValue],baseStr,goodSellOutModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName5;            
        }
    }
    self.parameterLabel.text = [NSString stringWithFormat:@"价格：￥%.2f  包装参数：%@",[goodSellOutModel.returnPrice doubleValue],nameStr?:@""];
    
}
-(UIImageView *)productImg
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        [self addSubview:_productImg];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(WScale(5));
            make.height.mas_equalTo(WScale(50));
            make.width.mas_equalTo(WScale(60));
        }];
    }
    return _productImg;
}
-(UILabel *)productName
{
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.textColor = [UIColor blackColor];
        _productName.font = ZF_FONT(15);
        _productName.numberOfLines = 0;
        [self addSubview:_productName];
        [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productImg.mas_right).mas_equalTo(WScale(5));
            make.top.mas_equalTo(WScale(10));
            make.right.mas_equalTo(WScale(-5));
        }];
    }
    return _productName;
}
-(UIView *)standardView
{
    if (!_standardView) {
        _standardView = [[UIView alloc] init];
        [self addSubview:_standardView];
        [_standardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productName.mas_left);
            make.top.mas_equalTo(self.productName.mas_bottom).mas_equalTo(WScale(5));
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(HeightF);
        }];
    }
    return _standardView;
}
-(void)setStandWithArray:(NSArray *)array
{
    [self.standardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat tagBtnX = 0;
    CGFloat tagBtnY = 0;
    for (int i = 0; i<array.count; i++) {
        CGSize tagTextSize = [array[i] sizeWithFont:ZF_FONT(12) maxSize:CGSizeMake(WScale(280),WScale(25))];
        if (tagBtnX+tagTextSize.width+WScale(25) >WScale(280)) {
            
            tagBtnX = 0;
            tagBtnY += WScale(25)+WScale(5);
        }
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+WScale(5),WScale(25));
        label.text = array[i];
        label.textColor = [UIColor blackColor];
        label.font = ZF_FONT(11);
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
        label.backgroundColor = BACKGROUNDCOLOR;
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
    }
    HeightF = tagBtnY +WScale(25);
    [self.standardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(HeightF);
    }];
//    [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.productName.mas_left);
//        make.top.mas_equalTo(self.productName.mas_bottom).mas_equalTo(self->Height+WScale(10));
//        make.right.mas_equalTo(WScale(-5));
//        make.bottom.mas_equalTo(WScale(-5));
//    }];
}
-(UILabel *)parameterLabel
{
    if (!_parameterLabel) {
        _parameterLabel = [[UILabel alloc] init];
        _parameterLabel.textColor = [UIColor blackColor];
        _parameterLabel.font = ZF_FONT(12);
        _parameterLabel.numberOfLines = 0;
        [self addSubview:_parameterLabel];
        [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productName.mas_left);         
            make.top.mas_equalTo(self.standardView.mas_bottom).mas_equalTo(WScale(10));
            make.right.mas_equalTo(WScale(-5));
           
            make.bottom.mas_equalTo(WScale(-5));
           
            
        }];
    }
    return _parameterLabel;
}
-(UILabel *)cellLabel
{
    if (!_cellLabel) {
        _cellLabel = [[UILabel alloc] init];
        _cellLabel.textColor = [UIColor blackColor];
        _cellLabel.font = ZF_FONT(12);
        _cellLabel.numberOfLines = 0;
        [self addSubview:_cellLabel];
        [_cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productName.mas_left);
            make.top.mas_equalTo(self.parameterLabel.mas_bottom).mas_equalTo(WScale(7));
            make.right.mas_equalTo(WScale(-5));
             make.bottom.mas_equalTo(WScale(-5));
        }];
    }
    return _cellLabel;
}
-(UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.font = ZF_FONT(12);
        _countLabel.numberOfLines = 0;
        [self addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productName.mas_left);
            make.top.mas_equalTo(self.cellLabel.mas_bottom).mas_equalTo(WScale(7));
            make.right.mas_equalTo(WScale(-5));
            make.bottom.mas_equalTo(WScale(-10));
        }];
    }
    return _countLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
