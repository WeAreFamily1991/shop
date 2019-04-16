//
//  FirstTableViewCell.m
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import "SecondCell.h"
#import "Masonry.h"
#import "NSString+Extension.h"
#import "UIView+Ext.h"

#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度
#define HScale(v) v / 667. * kWindowH //高度比
#define WScale(w) w / 375. * kWindowW //宽度比
#define ZF_FONT(__fontsize__) [UIFont systemFontOfSize:WScale(__fontsize__)]
@implementation SecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodsModel.imgurl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodsModel.itemname;
    [self.moreBtn setImage: [UIImage imageNamed: @"arrow_right_grey" ]forState:UIControlStateSelected];
    
    [self.moreBtn setImage: [UIImage imageNamed: @"arrow_down_grey" ]forState:UIControlStateNormal];
    
    //设置分组标题
    
    [self.moreBtn setTitle:@"更多信息"  forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"收起更多"  forState:UIControlStateSelected];
    
    [self.moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
      [self.moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleBottom imageTitleSpace:5];

    NSArray * array = @[goodsModel.spec?:@"",goodsModel.levelname?:@"",goodsModel.materialname?:@"",goodsModel.surfacename?:@"",goodsModel.brandname?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    Height = WScale(30);
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
    NSString *nameStr;
    if (goodsModel.unitconversion1.length!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodsModel.unitconversion1 doubleValue],baseStr,goodsModel.unitname1];
    }
    if (goodsModel.unitconversion2.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion2 doubleValue],baseStr,goodsModel.unitname2];
    }
    if (goodsModel.unitconversion3.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion3 doubleValue],baseStr,goodsModel.unitname3];
    }
    if (goodsModel.unitconversion4.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion4 doubleValue],baseStr,goodsModel.unitname4];
    }
    if (goodsModel.unitconversion5.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion5 doubleValue],baseStr,goodsModel.unitname5];
    }
   
    self.parameterLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
    self.cellLabel.text = nil;
    self.countLabel.text =[NSString stringWithFormat:@"库存数(%@)：%.3f  %@",baseStr,[goodsModel.qty doubleValue],goodsModel.storeName] ;
}
-(UIImageView *)productImg
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        [self addSubview:_productImg];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(5));
            make.top.mas_equalTo(WScale(5));
            make.width.height.mas_equalTo(WScale(65));
        }];
    }
    return _productImg;
}
-(UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font =DR_FONT(10);
        
        [self addSubview:_moreBtn];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(5));
//            make.top.mas_equalTo(WScale(5));
            make.bottom.mas_equalTo(WScale(-20));
            make.width.mas_equalTo(WScale(65));
            
        }];
    }
    return _moreBtn;
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
            make.height.mas_equalTo(Height);
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
        label.font = ZF_FONT(12);
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
        label.backgroundColor = BACKGROUNDCOLOR;
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
    }
    Height = tagBtnY +WScale(25);
    self.standardView.height = Height;
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
            make.top.mas_equalTo(self.productName.mas_bottom).mas_equalTo(Height+WScale(10));
            make.right.mas_equalTo(WScale(-5));
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
