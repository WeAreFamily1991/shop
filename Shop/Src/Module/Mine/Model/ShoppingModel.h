//
//  ShoppingModel.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject







@property (nonatomic,strong) ShoppingModel *shoppingModel;

@property (nonatomic,strong) NSString *order;//单据编码

@property (nonatomic,strong) NSString *time;//单据时间

@property (nonatomic,strong) NSString *orderPrice;//单据金额

@property (nonatomic,strong) NSString *backPrice;//退货金额

@property (nonatomic,strong) NSString *number;//可开票金额


@property (nonatomic,strong) NSString *typeRight;//可开票

@property(assign,nonatomic) BOOL selectState;//是否选中状态







-(instancetype)initWithShopDict:(NSDictionary *)dict;




@end
