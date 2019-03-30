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
-(void)setDataDict:(NSDictionary *)dataDict
{
    self.productImg.image = [UIImage imageNamed:@"product"];
    self.productName.text = @"哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    
    NSArray * array = @[@"M1.6-0.35*2",@"12.9级",@"35CrMo(合金钢)",@"淬黑",@"哈哈",@"紧固之星"];
    Height = WScale(30);
    [self setStandWithArray:array];
    
    self.parameterLabel.text = @"包装参数：哈哈哈哈哈 哈哈哈哈哈 或或或或或或或或 哈哈哈";
    self.cellLabel.text = @"最小销售单位：哈哈哈哈哈 哈哈哈哈哈 或或或或或或或或 哈哈哈";
    self.countLabel.text = @"库存数：72.0000支 华东仓";
    self.number.baseNum = @"2";
    self.danweiLab.text =@"千支";
    self.allCountLabel.text =@"小计:0.00";
    [self.saleOutBtn setTitle:@"申请售后" forState:UIControlStateNormal];
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
            make.left.mas_equalTo(self.countLabel.mas_left).offset(WScale(100));
            make.top.mas_equalTo(self.countLabel.mas_bottom).mas_equalTo(WScale(7));
            make.width.mas_offset(WScale(40));
            make.height.mas_offset(HScale(30));
        }];
    }
    return _danweiLab;
}
-(NumberCalculate *)number
{
    if (!_number) {
        _number=[[NumberCalculate alloc]initWithFrame:CGRectMake(self.countLabel.dc_x, self.countLabel.dc_bottom, WScale(100), HScale(30))];
        _number.baseNum=@"2";
        _number.multipleNum=2;//数值增减基数（倍数增减） 默认1的倍数增减
        _number.minNum=2;
        _number.maxNum=10;//最大值
        [self addSubview:_number];
//        [_number mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.danweiLab.centerX);
//            make.right.mas_equalTo (self.danweiLab.left);
//            make.left.mas_equalTo(self.countLabel.mas_left);
//            make.top.mas_equalTo(self.countLabel.mas_bottom).mas_equalTo(WScale(7));
////            make.width.mas_offset(WScale(80));
//            make.height.mas_offset(HScale(30));
//        }];
        _number.resultNumber = ^(NSString *number) {
            NSLog(@"%@>>>resultBlock>>",number);
        };
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
