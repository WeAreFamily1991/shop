//
//  ShoppingModel.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"application_id" : @"id"
             };
}


-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
//    self.order = dict[@"order"];
//    self.time = dict[@"time"];
//    self.orderPrice = dict[@"orderPrice"];
//    self.backPrice = dict[@"backPrice"];
//    self.number = dict[@"number"];
//    self.typeRight =dict[@"typeRight"];
//    self.selectState = [dict[@"selectState"]boolValue];
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



@end
