//
//  DCGoodsYouLikeCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#define cellWH ScreenW * 0.5 - 50

#import "DRNullGoodLikesCell.h"

// Controllers

// Models
#import "DCRecommendItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DRNullGoodLikesCell ()


@end

@implementation DRNullGoodLikesCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - Setter Getter Methods
-(void)setNullGoodModel:(DRNullGoodModel *)nullGoodModel
{
    _nullGoodModel =nullGoodModel;
    if ([nullGoodModel.bursttype intValue]!=2) {
        _nullImageView.hidden =YES;
        _baoImageView.hidden =YES;
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        
    }else
    { _nullImageView.hidden =NO;
      _baoImageView.hidden =NO;
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(HScale(15));
           
        }];
    }
    [_btnImage setTitle:nullGoodModel.brandname forState:UIControlStateNormal];
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:nullGoodModel.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
//    NSArray * array = @[nullGoodModel.spec?:@"",nullGoodModel.levelname?:@"",nullGoodModel.surfacename?:@"",nullGoodModel.materialname?:@""];
//    NSMutableArray *titArr =[NSMutableArray array];
//    for (NSString *str in array) {
//        if (str.length!=0) {
//            [titArr addObject:str];
//        }
//    }
//    Height = WScale(30);
//    [self setStandWithArray:titArr];
     _standedLabel.text =[NSString stringWithFormat:@"%@  %@  %@  %@",nullGoodModel.spec?:@"",nullGoodModel.levelname?:@"",nullGoodModel.surfacename?:@"",nullGoodModel.materialname?:@""];
     [SNTool setTextColor:_standedLabel FontNumber:DR_BoldFONT(12) AndRange:NSMakeRange(0,nullGoodModel.spec.length) AndColor:REDCOLOR];
    _goodsLabel.text =nullGoodModel.itemname;
    _priceLabel.text =[NSString stringWithFormat:@"%.2f/%@",nullGoodModel.userprice,nullGoodModel.basicunitname];
    [SNTool setTextColor:_priceLabel FontNumber:DR_BoldFONT(14) AndRange:NSMakeRange(0, [NSString stringWithFormat:@"%.2f",nullGoodModel.userprice].length) AndColor:REDCOLOR];
    _orderPriceLabel.text =[NSString stringWithFormat:@"%.2f/%@",nullGoodModel.bidprice,nullGoodModel.basicunitname];
    [_addressBtn setTitle:[NSString stringWithFormat:@"发货地：%@",nullGoodModel.factoryArea] forState:UIControlStateNormal];
    present=nullGoodModel.qtyPercent;
    [self.custompro setPresent:present];
    
}
- (void)setYouLikeItem:(DCRecommendItem *)youLikeItem
{
    _youLikeItem =youLikeItem;
    if ([youLikeItem.bursttype intValue]!=2) {
        _nullImageView.hidden =YES;
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WScale(0));
        }];
//        _goodsLabel.frame =CGRectMake(DCMargin, _standardView.dc_bottom, ScreenW-2*DCMargin, HScale(30));
    }else
    {
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo( HScale(15));
        }];
    }
    [_btnImage setTitle:youLikeItem.brandname forState:UIControlStateNormal];
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
//    NSArray * array = @[youLikeItem.spec?:@"",youLikeItem.levelname?:@"",youLikeItem.surfacename?:@"",youLikeItem.materialname?:@""];
//    NSMutableArray *titArr =[NSMutableArray array];
//    for (NSString *str in array) {
//        if (str.length!=0) {
//            [titArr addObject:str];
//        }
//    }
//    Height = WScale(30);
//    [self setStandWithArray:titArr];
       _standedLabel.text =[NSString stringWithFormat:@"%@  %@  %@  %@",youLikeItem.spec?:@"",youLikeItem.levelname?:@"",youLikeItem.surfacename?:@"",youLikeItem.materialname?:@""];
     [SNTool setTextColor:_standedLabel FontNumber:DR_BoldFONT(12) AndRange:NSMakeRange(0,youLikeItem.spec.length) AndColor:REDCOLOR];
    _goodsLabel.text =youLikeItem.itemname;
    _priceLabel.text =[NSString stringWithFormat:@"%.2f/%@",youLikeItem.userprice,youLikeItem.basicunitname];
    [SNTool setTextColor:_priceLabel FontNumber:DR_BoldFONT(14) AndRange:NSMakeRange(0, [NSString stringWithFormat:@"%.2f",youLikeItem.userprice].length) AndColor:REDCOLOR];
    _orderPriceLabel.text =[NSString stringWithFormat:@"%.2f/%@",youLikeItem.bidprice,youLikeItem.basicunitname];
    [_addressBtn setTitle:[NSString stringWithFormat:@"发货地：%@",youLikeItem.factoryArea] forState:UIControlStateNormal];
    
    [self.custompro setPresent:present];
}
/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
}
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.backView =[[UIView alloc]initWithFrame:CGRectZero];
    self.backView.backgroundColor =[UIColor whiteColor];
    self.backView.layer.cornerRadius =5;
    [self addSubview:self.backView];
  
   
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.backgroundColor =[UIColor clearColor];
//    _goodsImageView.contentMode =UIViewContentModeScaleAspectFill;
    [ self.backView addSubview:_goodsImageView];
    _btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnImage setBackgroundImage:[UIImage imageNamed:@"移动端-首页_02"] forState:UIControlStateNormal];
    [_btnImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnImage setTitle:@"金润雨" forState:UIControlStateNormal];
    _btnImage.titleLabel.font = DR_FONT(10);
    [ self.backView addSubview:_btnImage];
    
    _baoImageView = [[UIImageView alloc] init];
    
    _baoImageView.image =[UIImage imageNamed:@"hot-ico"];
    [ self.backView addSubview:_baoImageView];
    _standardView = [[UIView alloc] init];
    [ self.backView addSubview:_standardView];
//    NSArray * array = @[@"M14-2.0*110",@"40Cr(合金钢)",@"紧固之星"];
//    Height = WScale(30);
//    [self setStandWithArray:array];
    _nullImageView = [[UIImageView alloc] init];
    _nullImageView.backgroundColor =[UIColor clearColor];
    _nullImageView.image =[UIImage imageNamed:@"nius-ico_03"];
    [ self.backView addSubview:_nullImageView];
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = DR_FONT(14);
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    
    [ self.backView addSubview:_goodsLabel];
    
    _standedLabel = [[UILabel alloc] init];
    _standedLabel.textColor = BLACKCOLOR;
    _standedLabel.numberOfLines = 2;
    _standedLabel.font = DR_FONT(12);
    [ self.backView addSubview:_standedLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = REDCOLOR;
    _priceLabel.font = DR_FONT(12);
    [ self.backView addSubview:_priceLabel];
    
    _orderPriceLabel = [[UILabel alloc] init];
    _orderPriceLabel.textColor = [UIColor lightGrayColor];
    _orderPriceLabel.font = DR_FONT(12);
    [ self.backView addSubview:_orderPriceLabel];
    
//    _isHaveLabel = [[UILabel alloc] init];
//    _isHaveLabel.textColor = [UIColor blackColor];
//    _isHaveLabel.font = DR_FONT(13);
//    _isHaveLabel.text =@"剩余：";
//    [ self.backView addSubview:_isHaveLabel];
    
    _lineView =[[UIView alloc]init];
    _lineView.backgroundColor =[UIColor lightGrayColor];
    [self.backView addSubview:_lineView];
    
    _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addressBtn.titleLabel.font = DR_FONT(10);
    [_addressBtn setImage:[UIImage imageNamed:@"位置"] forState:UIControlStateNormal];
    _addressBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [_addressBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_addressBtn setTitle:@"---" forState:UIControlStateNormal];
    [_addressBtn addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_addressBtn];
    
    _sameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sameButton.titleLabel.font = DR_FONT(10);
    [_sameButton setImage:[UIImage imageNamed:@"eye-ico"] forState:UIControlStateNormal];
    [_sameButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_sameButton setTitle:@"找相似" forState:UIControlStateNormal];
    [_sameButton addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_sameButton];
    //    [DCSpeedy dc_chageControlCircularWith:_sameButton AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
//    self.custompro = [[CustomProgress alloc]initWithFrame:CGRectMake(1.5*DCMargin+HScale(35), self.dc_height*0.9-DCMargin-HScale(15), self.dc_width-2.5*DCMargin-HScale(35), HScale(15))];
//    self.custompro.maxValue = 100;
//    
//    //设置背景色
//    self.custompro.bgimg.backgroundColor =[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];
//    self.custompro.leftimg.backgroundColor =[UIColor redColor];
//    //也可以设置图片
//    //    custompro.leftimg.image = [UIImage imageNamed:@"leftimg"];
//    //    custompro.bgimg.image = [UIImage imageNamed:@"bgimg"];
//    //可以更改lab字体颜色
//    self.custompro.presentlab.textColor = [UIColor whiteColor];
//
//    [self.backView addSubview:self.custompro];
    
    _centerShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerShopBtn.backgroundColor =[UIColor whiteColor];
    _centerShopBtn.titleLabel.font = DR_FONT(12);
    [_centerShopBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
    [_centerShopBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
    [_centerShopBtn addTarget:self action:@selector(centerShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_centerShopBtn];
    [DCSpeedy dc_chageControlCircularWith:_centerShopBtn AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:REDCOLOR canMasksToBounds:YES];
    
    _sureBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBuyBtn.titleLabel.font = DR_FONT(12);
    _sureBuyBtn.backgroundColor =REDCOLOR;
    [_sureBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [_sureBuyBtn addTarget:self action:@selector(sureBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_sureBuyBtn];
    //    [DCSpeedy dc_chageControlCircularWith:_sureBuyBtn AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
}
-(void)setShopStr:(NSString *)shopStr
{
    if (shopStr) {
        [_orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.left.mas_equalTo(self)setOffset:DCMargin];
            make.height.mas_equalTo(HScale(15));
            make.top.mas_equalTo(self->_priceLabel.mas_bottom);
            [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
        }];
        
        _sameButton.hidden =YES;
        _centerShopBtn.hidden =YES;        
        _sureBuyBtn.hidden =YES;
        _isHaveLabel.hidden =YES;
        _custompro.hidden =YES;
        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
        //    [_goodsImageView sd_setImageWithURL:@""];
        _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[@"333" floatValue]];
        _orderPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[@"555" floatValue]];
        _goodsLabel.text = @"徐林飞你好骚徐林飞你好骚徐林飞你好骚啊啊啊啊";
        _isHaveLabel.text =@"剩余:";
        present=50;
        [self.custompro setPresent:present];
        
    }
}

-(void)setNullShopModel:(DRNullShopModel *)nullShopModel
{
    _nullShopModel =nullShopModel;
    if ([nullShopModel.bursttype intValue]!=2) {
        _nullImageView.hidden =YES;
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WScale(0));
        }];
    }
    else
    {
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo( HScale(15));
        }];
    }
    [_orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.height.mas_equalTo(HScale(15));
        make.top.mas_equalTo(self->_priceLabel.mas_bottom);
        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
    }];
    _addressBtn.hidden =YES;
    _sameButton.hidden =YES;
    _centerShopBtn.hidden =YES;
    _sureBuyBtn.hidden =YES;
    _isHaveLabel.hidden =YES;
    _custompro.hidden =YES;
  
    [_btnImage setTitle:nullShopModel.brandname forState:UIControlStateNormal];
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:nullShopModel.img?:@""] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
//    NSArray * array = @[nullShopModel.spec?:@"",nullShopModel.levelname?:@"",nullShopModel.surfacename?:@"",nullShopModel.materialname?:@""];
//    NSMutableArray *titArr =[NSMutableArray array];
//    for (NSString *str in array) {
//        if (str.length!=0) {
//            [titArr addObject:str];
//        }
//    }
//    Height = WScale(30);
//    [self setStandWithArray:titArr];
    _standedLabel.text =[NSString stringWithFormat:@"%@  %@  %@  %@",nullShopModel.spec?:@"",nullShopModel.levelname?:@"",nullShopModel.surfacename?:@"",nullShopModel.materialname?:@""];
    [SNTool setTextColor:_standedLabel FontNumber:DR_BoldFONT(12) AndRange:NSMakeRange(0,nullShopModel.spec.length) AndColor:REDCOLOR];
    _goodsLabel.text =nullShopModel.itemname;
    _priceLabel.text =[NSString stringWithFormat:@"%.2f/%@",nullShopModel.userprice,nullShopModel.basicunitname];
    [SNTool setTextColor:_priceLabel FontNumber:DR_BoldFONT(14) AndRange:NSMakeRange(0, [NSString stringWithFormat:@"%.2f",nullShopModel.userprice].length) AndColor:REDCOLOR];
    _orderPriceLabel.text =[NSString stringWithFormat:@"%.2f/%@",nullShopModel.bidprice,nullShopModel.basicunitname];
   
}
-(void)setStandWithArray:(NSArray *)array
{
    [self.standardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat tagBtnX = 0;
    CGFloat tagBtnY = 0;
    for (int i = 0; i<array.count; i++) {
        CGSize tagTextSize = [array[i] sizeWithFont:DR_FONT(12) maxSize:CGSizeMake(ScreenW/2,WScale(20))];
        if (tagBtnX+tagTextSize.width>ScreenW/2-DCMargin) {
            
            tagBtnX = 0;
            tagBtnY += WScale(20)+WScale(5);
        }
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+WScale(5),WScale(20));
        label.text = array[i];
        if (i==0) {
            
            label.textColor = REDCOLOR;
        }else
        {
            label.textColor = BLACKCOLOR;
        }
        label.font = DR_FONT(12);
        label.textAlignment = NSTextAlignmentCenter;
//        label.layer.cornerRadius = 2;
//        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor whiteColor];
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
//        [DCSpeedy dc_chageControlCircularWith:label AndSetCornerRadius:3.0 SetBorderWidth:1.0 SetBorderColor:UIColor.clearColor canMasksToBounds:YES];
    }
    Height = tagBtnY +WScale(20);
    self.standardView.dc_height = Height;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backView.frame =self.bounds;
    [_standedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.centerY.mas_equalTo(self)setOffset:3*DCMargin];
        make.right.mas_equalTo(WScale(-DCMargin));
        make.height.mas_equalTo(HScale(50));
    }];
    
    [_btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(WScale(45) , WScale(25)));
    }];
  
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerX.mas_equalTo(self);
        make.bottom.equalTo(self.standedLabel.mas_top);
        make.left.mas_equalTo(_nullImageView.mas_right);
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(HScale(35));
    }];
    
    [_nullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.centerY.mas_equalTo(_goodsLabel);
        make.size.mas_equalTo(CGSizeMake(HScale(15) , HScale(15)));
    }];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(_goodsLabel.mas_top);
        [make.left.mas_equalTo(self)setOffset:3*DCMargin];
        make.top.mas_equalTo(self);
    }];
    
//    [_standedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.edges.mas_equalTo(_standardView);
//    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.height.mas_equalTo(HScale(15));
        [make.top.mas_equalTo(self)setOffset:self.dc_height/2+HScale(55)];
        
    }];
    [_baoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(_btnImage.mas_top)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(WScale(16) , WScale(20)));
    }];
    
    [_orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.height.mas_equalTo(HScale(15));
        [make.top.mas_equalTo(_priceLabel.mas_bottom)setOffset:5];
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.width.mas_equalTo(_orderPriceLabel);
        make.centerY.mas_equalTo(_orderPriceLabel);
        make.height.mas_offset(1);
        
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       [make.left.mas_equalTo(self)setOffset:DCMargin];
//        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(_orderPriceLabel.mas_bottom)setOffset:DCMargin/2];
        make.height.mas_equalTo(HScale(15));
         make.width.mas_offset(self.dc_width-WScale(60)-2*DCMargin);
        
    }];
    [_sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        make.centerY.mas_equalTo(_addressBtn);
        make.size.mas_equalTo(CGSizeMake(WScale(60) , WScale(20)));
    }];
    [_centerShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_offset(self.dc_width/2);
        make.height.mas_equalTo(self).multipliedBy(0.1);
        [make.top.mas_equalTo(_addressBtn.mas_bottom)setOffset:DCMargin/2];
        make.bottom.mas_equalTo(self);
    }];
    
    [_sureBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.width.mas_offset(self.dc_width/2);
        make.height.mas_equalTo(self).multipliedBy(0.1);
        [make.top.mas_equalTo(_addressBtn.mas_bottom)setOffset:DCMargin/2];
        make.bottom.mas_equalTo(self);
    }];
    //    self.btnImage.frame = CGRectMake((self.frame.size.width - 55)/2,10, 45, 45);
    //    self.btnTitle.frame = CGRectMake(0,CGRectGetMaxY(self.btnImage.frame) + 10, self.frame.size.width-10, 14.5);
    
}
#pragma mark - 点击事件
- (void)lookSameGoods
{
    !_lookSameBlock ? : _lookSameBlock();
}
-(void)centerShopBtnClick
{
    !_centerShopBtnBlock ? : _centerShopBtnBlock();
}
-(void)sureBuyBtnClick
{
    !_sureBuyBtnBlock ? : _sureBuyBtnBlock();
}
@end
