//
//  UIButton+screenFont.m
//  BabyStore
//
//  Created by mac01 on 2018/3/29.
//  Copyright © 2018年 那道. All rights reserved.
//

#import "UIButton+screenFont.h"
#import <objc/runtime.h>

@implementation UIButton (screenFont)
+ (void)load{
    Method originalMethod = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(adpterInitWithCoder:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (instancetype)adpterInitWithCoder:(NSCoder *)aDecoder{
    [self adpterInitWithCoder:aDecoder];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:WScale(self.titleLabel.font.pointSize)];
    }
    return self;
}
@end
