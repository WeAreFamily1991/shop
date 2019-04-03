//
//  DCContentItem.h
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DCContentItem : NSObject


@property (nonatomic , strong) NSString *code;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *child_id;

/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;

@end
