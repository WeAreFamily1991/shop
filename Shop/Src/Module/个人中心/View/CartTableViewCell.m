//
//  CartTableViewCell.m
//  ArtronUp
//
//  Created by Artron_LQQ on 15/12/1.
//  Copyright © 2015年 ArtronImages. All rights reserved.
//

#import "CartTableViewCell.h"
//#import "LQQPictureManager.h"

@interface CartTableViewCell ()

//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;

//商品名
@property (nonatomic,retain) UILabel *nameLabel;

//时间
@property (nonatomic,retain) UILabel *dateLabel;

//line
@property (nonatomic,retain) UIView *lineView;

@end

@implementation CartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.backgroundColor = RGBCOLOR(245, 246, 248);
//        [self setupMainView];
//    }
//    return self;
//}
//选中按钮点击事件
-(void)selectBtnClick:(UIButton*)button
{
    button.selected = !button.selected;
    if (self.cartBlock) {
        self.cartBlock(button.selected);
    }
}

// 数量加按钮
-(void)addBtnClick
{
    if (self.numAddBlock) {
        self.numAddBlock();
    }
}

//数量减按钮
-(void)cutBtnClick
{
    if (self.numCutBlock) {
        self.numCutBlock();
    }
}

-(void)reloadDataWith:(CartModel*)model
{
    self.nameLabel.text =model.title;
    
    self.dateLabel.text =[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)model.addTime]];

    self.nameLabel.textColor =model.isRead?[UIColor blackColor]:REDCOLOR;
    self.dateLabel.textColor =model.isRead?[UIColor lightGrayColor]:REDCOLOR;

    self.selectBtn.selected = self.isSelected;

}
-(UIButton *)selectBtn
{
    if (!_selectBtn) {
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectBtn.selected = self.isSelected;
        [self.selectBtn setImage:[UIImage imageNamed:@"Unchecked"] forState:UIControlStateNormal];
        [self.selectBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectBtn];
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
    }
    return _selectBtn;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc]init];
        //    self.nameLabel.text = @"海报";
        self.nameLabel.numberOfLines =0;
        self.nameLabel.font = DR_FONT(15);
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectBtn.mas_right).offset(10);
            make.top.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
        }];
    }
    return _nameLabel;
}
-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.font = DR_FONT(12);
    
        //    self.dateLabel.text = @"2015-12-03 17:49";
        [self addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(WScale(-5));
           make.bottom.mas_equalTo(WScale(-10));
            
        }];
    }
    return _dateLabel;
}


@end
