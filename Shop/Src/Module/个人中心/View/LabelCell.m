//
//  LabelCell.m
//  LXTagsView
//
//  Created by 万众创新 on 2018/7/25.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LabelCell.h"
#import "LXTagsView.h"
@interface LabelCell()
@property (nonatomic ,strong)LXTagsView *tagsView;

@property (nonatomic ,strong)UIView *container;

@end
@implementation LabelCell
//-(void)setItems:(NSArray *)items{
//    _items = items;
//    self.tagsView.dataA = items;
//    [self.contentView layoutIfNeeded];
//
//
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
    self.tagsView.dataA =titArr.copy;
//    HeightF = WScale(30);
//    [self setStandWithArray:titArr.copy];
    self.parameterLabel.text = [NSString stringWithFormat:@"购买数量：%.3f%@  小计：￥%.2f",goodListModel.qty,goodListModel.basicUnitName,goodListModel.realAmt];
}

-(void)setGoodSellOutModel:(GoodsListModel *)goodSellOutModel
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
    self.tagsView.dataA =titArr.copy;
    //    HeightF = WScale(30);
    //    [self setStandWithArray:titArr.copy];
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
    if (goodSellOutModel.unitConversion1.length!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodSellOutModel.unitConversion1 doubleValue],baseStr,goodSellOutModel.unitName1];
        cellStr =goodSellOutModel.unitName1;
    }
    if (goodSellOutModel.unitConversion2!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion2,baseStr,goodSellOutModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName2;
            
        }
    }
    if (goodSellOutModel.unitConversion3!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion3,baseStr,goodSellOutModel.unitName1];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName3;
            
        }
    }
    if (goodSellOutModel.unitConversion4.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion4 doubleValue],baseStr,goodSellOutModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName4;
            
        }
    }
    if (goodSellOutModel.unitConversion5.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion5 doubleValue],baseStr,goodSellOutModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName5;
            
        }
    }
    
    self.parameterLabel.text = [NSString stringWithFormat:@"价格：￥%.2f%@  包装参数：%@",goodSellOutModel.price,goodSellOutModel.basicUnitName,nameStr];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _productImg = [[UIImageView alloc] init];
        [self addSubview:_productImg];
       

        _productName = [[UILabel alloc] init];
        _productName.textColor = [UIColor blackColor];
        _productName.font = DR_FONT(14);
        _productName.numberOfLines = 0;
        [self addSubview:_productName];
       
        self.tagsView =[[LXTagsView alloc]init];
//        self.tagsView.layer.borderWidth = 1;
//        self.tagsView.layer.borderColor = [UIColor redColor].CGColor;
        [self.contentView addSubview:self.tagsView];

       
        self.tagsView.tagClick = ^(NSString *tagTitle) {
            NSLog(@"cell打印---%@",tagTitle);
        };
        _parameterLabel = [[UILabel alloc] init];
        _parameterLabel.textColor = [UIColor blackColor];
        _parameterLabel.font = DR_FONT(12);
        _parameterLabel.numberOfLines = 0;
        [self addSubview:_parameterLabel];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(DCMargin);
            make.top.equalTo(self.contentView).offset(5);
            make.height.mas_equalTo(WScale(50));
            make.width.mas_equalTo(WScale(60));
        }];
        
        [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.productImg.mas_right).offset(5);
            make.top.equalTo(self.contentView).offset(DCMargin);
            make.right.mas_equalTo(WScale(-5));
            make.height.mas_equalTo(HScale(30));
        }];
        [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(WScale(70));
            make.top.equalTo(self.contentView).offset(HScale(40));
            make.right.equalTo(self.contentView).offset(-5);
            make.bottom.equalTo(self.contentView).offset(-HScale(30));
        }];
        
        
        [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.productName.mas_left);
            make.top.equalTo(self.tagsView.mas_bottom).offset(WScale(5));
            make.right.equalTo(self.contentView).offset(WScale(5));
            make.height.mas_equalTo(HScale(20));
            
        }];
        
    }
    return self;
}
-(void)layoutSubviews
{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
