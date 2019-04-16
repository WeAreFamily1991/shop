//
//  DCGoodsSortCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsSortCell.h"

// Controllers

// Models
#import "DCClassMianItem.h"
#import "DCClassMianItem.h"
// Views
#import <UIImageView+WebCache.h>
// Vendors

// Categories

// Others

@interface DCGoodsSortCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* label */
@property (strong , nonatomic)UILabel *goodsTitleLabel;
/* Contentlabel */
@property (strong , nonatomic)UILabel *goodsContentLabel;
@end

@implementation DCGoodsSortCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsImageView];
    _goodsTitleLabel = [[UILabel alloc] init];
    _goodsTitleLabel.font = DR_FONT(14);
    _goodsTitleLabel.textColor =[UIColor blackColor];
    _goodsTitleLabel.textAlignment = 0;
    [self addSubview:_goodsTitleLabel];
    _goodsContentLabel = [[UILabel alloc] init];
    _goodsContentLabel.font = DR_FONT(13);
    _goodsContentLabel.textColor =[UIColor darkGrayColor];
    _goodsContentLabel.textAlignment = 0;
    _goodsContentLabel.numberOfLines =0;
    [self addSubview:_goodsContentLabel];
    
}
#pragma mark - 布局
- (void)layoutSubviews
{
//    DRWeakSelf;
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(10);
        make.bottom.mas_equalTo(self);
        make.width.mas_offset(HScale(70));
    }];
    [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(HScale(20));
        make.left.mas_offset(HScale(90));
        //make.right.mas_equalTo(self);
        make.height.mas_offset(HScale(20));
    }];
    [_goodsContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(HScale(40));
        make.left.mas_offset(HScale(90));
        make.right.mas_equalTo(self).offset(5);
        make.height.mas_offset(HScale(20));
//        make.bottom.mas_offset(weakSelf.goodsImageView).offset(-5);
    }];
}
#pragma mark - Setter Getter Methods
-(void)setMainItem:(DCClassMianItem *)mainItem
{
    _mainItem =mainItem;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:mainItem.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
//    if ([mainItem.img containsString:@"http"]){
//        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:mainItem.img]];
//    }else
//    {
//        _goodsImageView.image = [UIImage imageNamed:@"santie_default_img"];
//    }
    _goodsTitleLabel.text = mainItem.code;
    _goodsContentLabel.text = mainItem.name;
}


@end
