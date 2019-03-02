//
//  HomeViewController.m
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "HomeViewController.h"

#import "ViewController.h"
#import "NetworkManager.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"首页";
    
    // 添加一些监听
    [self addSomeObservers];
    
}

#pragma mark - Private
// 添加一些 observer
- (void)addSomeObservers {
    // 游客登录通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:kGuestLoginStatusChange object:nil];
}

- (void)notificationHandler:(NSNotification *)notification {
    if ([notification.name isEqualToString:kGuestLoginStatusChange]) {
        // 游客登录通知
        [self loadData];
    }
}

- (void)loadData {
    // 加载新品推荐内容
    [[NetworkManager manager] homeGetNewRecommendSuccess:^(id response) {
        STLog(@"response = %@", response);
    } fail:^(NSError *error) {
        STLog(@"error = %@", error);
    }];
}


@end
