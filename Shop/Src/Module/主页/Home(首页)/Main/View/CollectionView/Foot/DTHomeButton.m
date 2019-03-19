//
//  DTHomeButton.m
//  DTcollege
//
//  Created by 信达 on 2018/7/24.
//  Copyright © 2018年 ZDQK. All rights reserved.
//

#import "DTHomeButton.h"

@implementation DTHomeButton


- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
           withImageURLString:(NSString *)imageURLString{
    
    if (self = [super initWithFrame:frame]) {
        self.titleString = title;
        self.imageURLString = imageURLString;
        self.titleColor = @"#343434";
        [self createSubViews];
        
    }
    return self;
}

- (void)createSubViews
{
//    self.layer.cornerRadius =5;
//    self.layer.masksToBounds =5;
//    self.backgroundColor =[UIColor redColor];
    self.backgroundColor =[UIColor whiteColor];
    self.backView =[[UIView alloc]initWithFrame:CGRectZero];
    self.backView.backgroundColor =[UIColor whiteColor];
    self.backView.layer.cornerRadius =5;
    
    [self addShadowToView:self.backView withColor:[UIColor lightGrayColor]];
    [self addSubview:self.backView];
    self.btnTitle = [[UILabel alloc]initWithFrame:CGRectZero];
    self.btnTitle.textColor = [UIColor blackColor];
    self.btnTitle.font = [UIFont systemFontOfSize:14];
    self.btnTitle.textAlignment = NSTextAlignmentCenter;
    
    self.btnTitle.text = self.titleString;
    [self.backView addSubview:self.btnTitle];
    
    self.btnImage = [[UIImageView alloc]initWithFrame:CGRectZero];
   
    //加载网络图片
    [self.btnImage sd_setImageWithURL:[NSURL URLWithString:self.imageURLString] placeholderImage:[UIImage imageNamed:@"yongnian"]];
    
    [self.backView addSubview:self.btnImage];

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

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.backView.frame =CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10);
    self.btnImage.frame = CGRectMake((self.frame.size.width - 55)/2,10, 45, 45);
    self.btnTitle.frame = CGRectMake(0,CGRectGetMaxY(self.btnImage.frame) + 10, self.frame.size.width-10, 14.5);
   
}

@end
