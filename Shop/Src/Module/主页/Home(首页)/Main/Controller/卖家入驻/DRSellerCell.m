//
//  DRSellerCell.m
//  StretchTableView
//
//  Created by BWJ on 2019/5/21.
//  Copyright © 2019 田相强. All rights reserved.
//

#import "DRSellerCell.h"
#import "DRComeModel.h"
@implementation DRSellerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setComModel:(DRComeModel *)comModel
{
    _comModel =comModel;
    [self.iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:comModel.imgM] forState:UIControlStateNormal];
    self.titleLab.text =comModel.title;
    self.contentLab.text =[NSString stringWithFormat:@"%@(Tel：%@)",comModel.linkUrl,comModel.linkUrlM];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
