//
//  FirstTableViewCell.m
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import "ThirdCell.h"
#import "Masonry.h"
#import "NSString+Extension.h"


#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度
#define HScale(v) v / 667. * kWindowH //高度比
#define WScale(w) w / 375. * kWindowW //宽度比
#define ZF_FONT(__fontsize__) [UIFont systemFontOfSize:WScale(__fontsize__)]
@implementation ThirdCell

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
//    self.allCountLabel.text =@"小计:0.00";
//     [self.saleOutBtn setTitle:@"申请售后" forState:UIControlStateNormal];
//}


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
    Height = WScale(30);
    [self setStandWithArray:titArr];
    NSString *baseStr;//basicunitid 5千支  6公斤  7吨
    if ([goodListModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([goodListModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([goodListModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    NSString *nameStr,*cellStr;
    if (goodListModel.unitConversion1.length!=0&&![goodListModel.unitConversion1 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodListModel.unitConversion1 doubleValue],baseStr,goodListModel.unitName1];
        cellStr =goodListModel.unitName1;
    }
    if (goodListModel.unitConversion2.length!=0&&![goodListModel.unitConversion2 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[[NSString stringWithFormat:@"%f",[goodListModel.unitConversion2 doubleValue]] doubleValue],baseStr,goodListModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodListModel.unitName2;
            
        }
    }
    if (goodListModel.unitConversion3.length!=0&&![goodListModel.unitConversion3 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[[NSString stringWithFormat:@"%f",[goodListModel.unitConversion3 doubleValue]] doubleValue],baseStr,goodListModel.unitName3];
        if (cellStr.length==0) {
            cellStr =goodListModel.unitName3;
            
        }
    }
    if (goodListModel.unitConversion4.length!=0&&![goodListModel.unitConversion4 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodListModel.unitConversion4 doubleValue],baseStr,goodListModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodListModel.unitName4;
        }
    }
    if (goodListModel.unitConversion5.length!=0&&![goodListModel.unitConversion5 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodListModel.unitConversion5 doubleValue],baseStr,goodListModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodListModel.unitName5;
            
        }
    }
     self.parameterLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
    self.cellLabel.text =[NSString stringWithFormat:@"订单数量(%@)：%.3f",baseStr,goodListModel.qty];
    self.countLabel.text = [NSString stringWithFormat:@"单价：￥%.2f",goodListModel.realPrice];
    self.allCountLabel.text =[NSString stringWithFormat:@"小计：%.2f",goodListModel.qty*goodListModel.realPrice];
    
    [SNTool setTextColor:self.cellLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(self.cellLabel.text.length-[NSString stringWithFormat:@"%.3f",goodListModel.qty].length, [NSString stringWithFormat:@"%.3f",goodListModel.qty].length) AndColor:REDCOLOR];
    
    [SNTool setTextColor:self.countLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(3, [NSString stringWithFormat:@"%.2f",goodListModel.realPrice].length+1) AndColor:REDCOLOR];
}
-(void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel =orderModel;
    if (orderModel.status==4||orderModel.status==5) {
        
        [self.saleOutBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        [self.saleOutBtn addTarget:self action:@selector(saleOutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (orderModel.status ==5) {
            self.saleOutBtn.hidden = !orderModel.orderpaytype;
        }
    }
    if (orderModel.isReturn==1) {
        self.saleOutBtn.hidden =YES;
    }
}
-(void)saleOutBtnClick:(UIButton *)sender
{
     !_saleOutClickBlock ? : _saleOutClickBlock();
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
        CGSize tagTextSize = [array[i] sizeWithFont:ZF_FONT(12) maxSize:CGSizeMake(WScale(300),WScale(25))];
        if (tagBtnX+tagTextSize.width+WScale(25) >WScale(300)) {
            
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
    [self.standardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Height);
    }];
    
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

-(UILabel *)allCountLabel
{
    if (!_allCountLabel) {
        _allCountLabel = [[UILabel alloc] init];
        _allCountLabel.textColor = REDCOLOR;
        _allCountLabel.font = ZF_FONT(12);
//        _allCountLabel.numberOfLines = 0;
        [self addSubview:_allCountLabel];
        [_allCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(WScale(15));
            make.top.mas_equalTo(self.countLabel.mas_bottom).mas_equalTo(WScale(7));
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
        _saleOutBtn.layer.cornerRadius =HScale(10);
        _saleOutBtn.layer.masksToBounds =HScale(10);
//        [_saleOutBtn setBackgroundImage:[UIImage imageNamed:@"分类购买_16"] forState:UIControlStateNormal];
        _saleOutBtn.backgroundColor =REDCOLOR;
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
