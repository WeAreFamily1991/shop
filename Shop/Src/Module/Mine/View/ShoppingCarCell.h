//
//  ShoppingCarCell.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingModel.h"

#import "AddNumberView.h"
#import "LineLabel.h"

@protocol ShoppingCarCellDelegate;
@interface ShoppingCarCell : UITableViewCell<AddNumberViewDelegate>


@property (nonatomic,strong) UIImageView *checkImg;

//@property (nonatomic,strong) UIImageView *shopImageView;

@property (nonatomic,strong) UILabel *orderLab;//单据编码

@property (nonatomic,strong) UILabel *timeLab;//单据时间

@property (nonatomic,strong) UILabel *orderPriceLab;//单据金额

@property (nonatomic,strong) UILabel *backPriceLab;//退货金额

@property (nonatomic,strong) UILabel *numberLab;//可开票金额


@property (nonatomic,strong) UILabel *typeRightLab;//可开票

@property (nonatomic,strong) UIButton *detailBtn;//查看详情

@property (nonatomic,strong) ShoppingModel *shoppingModel;


@property (assign,nonatomic) BOOL selectState;//选中状态

@property (nonatomic,assign) id<ShoppingCarCellDelegate>delegate;

//@property (nonatomic,strong) AddNumberView *addNumberView;

@end

@protocol ShoppingCarCellDelegate

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;

@end
