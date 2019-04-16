//
//  FirstTableViewCell.m
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import "FourthCell.h"
#import "Masonry.h"
#import "NSString+Extension.h"
#import "UIView+Ext.h"


#define ZF_FONT(__fontsize__) [UIFont systemFontOfSize:WScale(__fontsize__)]
@implementation FourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
//-(void)setDataDict:(NSDictionary *)dataDict
//{
//    self.productImg.image = [UIImage imageNamed:@"product"];
//    self.productName.text = @"哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
//    
//    NSArray * array = @[@"M1.6-0.35*2",@"12.9级",@"35CrMo(合金钢)",@"淬黑",@"哈哈",@"紧固之星"];
//    Height = WScale(30);
//    [self setStandWithArray:array];
//    
//    self.parameterLabel.text = @"包装参数：哈哈哈哈哈 哈哈哈哈哈 或或或或或或或或 哈哈哈";
//    self.cellLabel.text = @"最小销售单位：哈哈哈哈哈 哈哈哈哈哈 或或或或或或或或 哈哈哈";
//    self.countLabel.text = @"库存数：72.0000支 华东仓";
//    self.number.baseNum = @"2";
//    self.danweiLab.text =@"千支";
//    self.allCountLabel.text =@"小计:0.00";
//    [self.saleOutBtn setTitle:@"申请售后" forState:UIControlStateNormal];
//}
-(void)setGoodModel:(GoodModel *)goodModel
{
    _goodModel =goodModel;
    if (_numStr) {
        self.number.baseNum = _numStr;
    }
    else
    {
        self.number.baseNum = [NSString stringWithFormat:@"%.3f",goodModel.canReturnQty];
    }
    self.number.multipleNum=goodModel.saleUnitConversion;
    self.number.minNum =goodModel.saleUnitConversion;
    self.number.maxNum =[[NSString stringWithFormat:@"%.3f",goodModel.canReturnQty] doubleValue];
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodModel.itemName;
    NSArray * array = @[goodModel.spec?:@"",goodModel.levelName?:@"",goodModel.materialName?:@"",goodModel.surfaceName?:@"",goodModel.brandName?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    Height = WScale(30);
    [self setStandWithArray:titArr];
    NSString *baseStr;//basicunitid 5千支  6公斤  7吨
    if ([goodModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([goodModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([goodModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    self.danweiLab.text =baseStr;
    
    NSString *nameStr,*cellStr;
    if (goodModel.unitConversion1.length!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodModel.unitConversion1 doubleValue],baseStr,goodModel.unitName1];
        cellStr =goodModel.unitName1;
    }
    if ([NSString stringWithFormat:@"%f",goodModel.unitConversion2].length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[[NSString stringWithFormat:@"%f",goodModel.unitConversion2] doubleValue],baseStr,goodModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName2;
        }
    }
    if ([NSString stringWithFormat:@"%f",goodModel.unitConversion3].length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[[NSString stringWithFormat:@"%f",goodModel.unitConversion3] doubleValue],baseStr,goodModel.unitName3];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName3;
        }
    }
    if (goodModel.unitConversion4.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodModel.unitConversion4 doubleValue],baseStr,goodModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName4;
        }
    }
    if (goodModel.unitConversion5.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodModel.unitConversion5 doubleValue],baseStr,goodModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodModel.unitName5;
        }
    }
    self.parameterLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
    self.cellLabel.text =[NSString stringWithFormat:@"订单数量(%@)：%.3f  已退数量：%.3f",baseStr,goodModel.qty,goodModel.returnQty];
    self.cellLabel.textColor =[UIColor redColor];
    self.countLabel.text = [NSString stringWithFormat:@"单价：￥%.3f  销售单位：%@",goodModel.price,goodModel.saleUnitName];
    self.countLabel.textColor =[UIColor redColor];
    self.allCountLabel.text =[NSString stringWithFormat:@"小计：%.3f",goodModel.realAmt];
    
//    [SNTool setTextColor:self.cellLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(0, [NSString stringWithFormat:@"%.3f",goodModel.qty].length) AndColor:[UIColor redColor]];
    
    [SNTool setTextColor:self.countLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(3, [NSString stringWithFormat:@"%.3f",goodModel.price].length+1) AndColor:[UIColor redColor]];
}
- (void)resultNumber:(NSString *)number
{
//    _numStr =number;
    if (_numberBlock) {
        _numberBlock(number);
    }
}
-(UIImageView *)productImg
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        [self addSubview:_productImg];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(5));
            make.top.mas_equalTo(WScale(5));
            make.width.height.mas_equalTo(WScale(50));
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
            
            make.top.mas_equalTo(self.productName.mas_bottom).mas_equalTo(Height+WScale(10));
            make.left.mas_equalTo(self.productName.mas_left);
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
            //            make.bottom.mas_equalTo(WScale(-10));
        }];
    }
    return _countLabel;
}
-(UILabel *)danweiLab
{
    if (!_danweiLab) {
        _danweiLab = [[UILabel alloc] init];
        _danweiLab.textColor = [UIColor redColor];
        _danweiLab.font = ZF_FONT(12);
        _danweiLab.textAlignment =NSTextAlignmentLeft;
        //        _allCountLabel.numberOfLines = 0;
        [self addSubview:_danweiLab];
        [_danweiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.countLabel.mas_left).offset(WScale(115));
            make.top.mas_equalTo(self.countLabel.mas_bottom).mas_equalTo(WScale(7));
            make.width.mas_offset(WScale(40));
            make.height.mas_offset(HScale(25));
        }];
    }
    return _danweiLab;
}
//-(UIView *)backView
//{
//    if (!_backView) {
//        _backView =[[UIView alloc]init];
//        _backView.backgroundColor =[UIColor redColor];
//        [self addSubview:_backView];
////        _number=[[NumberCalculate alloc]initWithFrame:_backView.bounds];
////        _number.delegate =self;
////        [_backView addSubview:_number];
//        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.countLabel.mas_left).offset(WScale(115));
//            make.top.mas_equalTo(self.countLabel.mas_bottom).mas_equalTo(WScale(7));
//            make.width.mas_offset(WScale(110));
//            make.height.mas_offset(HScale(25));
//        }];
//
//    }
//
//    return _backView;
//}
-(NumberCalculate *)number
{
    if (!_number) {
        [_number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(WScale(55));
            make.width.mas_offset(WScale(110));
            make.height.mas_offset(HScale(25));
            make.bottom.mas_equalTo(WScale(-41));
        }];
    }
    return _number;
}
-(UILabel *)allCountLabel
{
    if (!_allCountLabel) {
        _allCountLabel = [[UILabel alloc] init];
        _allCountLabel.textColor = [UIColor redColor];
        _allCountLabel.font = ZF_FONT(12);
        //        _allCountLabel.numberOfLines = 0;
        [self addSubview:_allCountLabel];
        [_allCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(WScale(15));
            make.top.mas_equalTo(self.danweiLab.mas_bottom).mas_equalTo(WScale(7));
            make.width.mas_offset(100);
            make.height.mas_offset(HScale(20));
            make.bottom.mas_equalTo(WScale(-10));
        }];
    }
    return _allCountLabel;
}

-(UIButton *)saleOutBtn
{
    if (!_saleOutBtn) {
        _saleOutBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_saleOutBtn];
        _saleOutBtn.layer.cornerRadius =10;
        _saleOutBtn.layer.masksToBounds =10;
        //        [_saleOutBtn setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        _saleOutBtn.backgroundColor =[UIColor redColor];
        [_saleOutBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        [_saleOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saleOutBtn.titleLabel.font =DR_FONT(14);
        [_saleOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.allCountLabel.mas_top);
            make.right.mas_equalTo(-15);
            make.height.mas_offset(HScale(20));
            make.width.mas_offset(WScale(80));
            //            make.bottom.mas_equalTo(WScale(-10));
        }];
        
    }
    return _saleOutBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
