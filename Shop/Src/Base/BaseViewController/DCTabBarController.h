//
//  DCTabBarController.h
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger ,DCTabBarControllerType){
   
    DCTabBarControllerHome = 0, //首页
    DCTabBarControllerMediaList = 1,  //分类购买
    DCTabBarControllerBeautyStore = 2, //购物车
    DCTabBarControllerPerson = 3, //个人中心
};

@interface DCTabBarController : UITabBarController

/* 控制器type */
@property (assign , nonatomic)DCTabBarControllerType tabVcType;

@end