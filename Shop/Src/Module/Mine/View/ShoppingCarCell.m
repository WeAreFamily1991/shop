//
//  ShoppingCarCell.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "UIViewExt.h"
@implementation ShoppingCarCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, (120-20)/2.0, 20, 20)];
    
    self.checkImg.image =IMAGENAMED(@"check_p");
    [self addSubview:self.checkImg];
    
//
    
    
    self.orderLab = [[UILabel alloc]initWithFrame:CGRectMake(self.checkImg.right+10,10,kScreenWidth-self.checkImg.right-20-self.typeRightLab.width, 20)];
    self.orderLab.text = @"单据编码：XD-00005-201902-D00019";
    self.orderLab.numberOfLines = 0;
    self.orderLab.font = DR_FONT(13);
    [self addSubview:self.orderLab];
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.orderLab.left,self.orderLab.bottom,self.orderLab.width, 20)];
    self.timeLab.text = @"单据时间：2019/2/19 10:44:52";
    self.timeLab.textColor = [UIColor lightGrayColor];
    self.timeLab.font = DR_FONT(13);
    [self addSubview:self.timeLab];
    
    self.orderPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.timeLab.left,self.timeLab.bottom,self.timeLab.width, 20)];
    self.orderPriceLab.text = @"单据金额：￥0.00";
    self.orderPriceLab.textColor = [UIColor grayColor];
    self.orderPriceLab.font = DR_FONT(12);
    [self addSubview:self.orderPriceLab];
    
    self.backPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.orderPriceLab.left,self.orderPriceLab.bottom,self.orderPriceLab.width, 20)];
    self.backPriceLab.text = @"退货金额：￥0.00";
    self.backPriceLab.textColor = [UIColor grayColor];
    self.backPriceLab.font = DR_FONT(12);
    [self addSubview:self.backPriceLab];
    
    self.numberLab = [[UILabel alloc]initWithFrame:CGRectMake(self.backPriceLab.left,self.backPriceLab.bottom,self.backPriceLab.width, 20)];
    self.numberLab.text = @"可开票金额：￥0.00";
    self.numberLab.textColor = [UIColor grayColor];
    self.numberLab.font = DR_FONT(12);
    [self addSubview:self.numberLab];
    
    self.typeRightLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50-10,10,50, 20)];
    self.typeRightLab.text = @"可开票";
    self.typeRightLab.textAlignment =NSTextAlignmentRight;
    self.typeRightLab.textColor = [UIColor redColor];
    self.typeRightLab.font = DR_FONT(13);
    [self addSubview:self.typeRightLab];
    
    
    self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.detailBtn.frame = CGRectMake(SCREEN_WIDTH-WScale(90)-10,self.numberLab.bottom-30,WScale(90), 30);
    [self.detailBtn setBackgroundColor:[UIColor redColor]];
    
//    [self.detailBtn addTarget:self action:@selector(detailBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.detailBtn.layer.masksToBounds = YES;
    self.detailBtn.layer.cornerRadius = 15;
    [self.detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    
    [self.detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.detailBtn.titleLabel.font = DR_FONT(14.0);
    self.detailBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self addSubview:self.detailBtn];

  
    
    
//    self.addNumberView = [[AddNumberView alloc]initWithFrame:CGRectMake(numberTitleLab.right+5, numberTitleLab.top-2, 93, 22)];
//    self.addNumberView.delegate = self;
//    self.addNumberView.backgroundColor = [UIColor clearColor];
//    [self addSubview:self.addNumberView];
   
}



-(void)setShoppingModel:(ShoppingModel *)shoppingModel{
    
    _shoppingModel = shoppingModel;
    self.orderLab.text = shoppingModel.order;
    
    if (shoppingModel.selectState)
    {
        self.checkImg.image = [UIImage imageNamed:@"check_p"];
        self.selectState = YES;
        
    }else{
        self.selectState = NO;
        self.checkImg.image = [UIImage imageNamed:@"check_n"];
    }
    self.timeLab.text  = shoppingModel.time;
    
    self.orderPriceLab.text = shoppingModel.orderPrice;
    self.backPriceLab.text =shoppingModel.backPrice;
    self.numberLab.text =shoppingModel.number;
    
}



- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
