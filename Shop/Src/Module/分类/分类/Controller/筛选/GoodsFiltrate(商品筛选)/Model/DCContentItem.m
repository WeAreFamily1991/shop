//
//  DCContentItem.m
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCContentItem.h"

@implementation DCContentItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"child_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
