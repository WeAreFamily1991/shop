//
//  AppDelegate.m
//  Shop
//
//  Created by BWJ on 2018/12/28.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "AppDelegate.h"

#import "DCTabBarController.h"
#import "DCAppVersionTool.h"
#import "STRootNavigationController.h"

#import "HomeViewController.h"                  // 首页
//#import "CategoryPurchaseViewController.h"      // 分类购买
#import "ShoppingCartViewController.h"          // 购物车
#import "MineViewController.h"                  // 个人中心
#import "ChangeOrderVC.h"
#import "DCNewFeatureViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    BOOL serverFlag = ![version hasSuffix:@"_T"];
   
    [SNAPI initWithIsFormalServer:serverFlag];
    
    [self setUpRootVC]; //跟控制器判断
    
    [self.window makeKeyAndVisible];
    
    //    [self CDDMallVersionInformationFromPGY]; //蒲公英自动更新
    

    [self checkIsLogin];
    [self setUpFixiOS11]; //适配IOS 11
    
    return YES;
}
#pragma mark - 根控制器
- (void)setUpRootVC
{
    if ([BUNDLE_VERSION isEqualToString:[DCAppVersionTool dc_GetLastOneAppVersion]]) {//判断是否当前版本号等于上一次储存版本号
        self.window.rootViewController = [[DCTabBarController alloc] init];
        
    }else{
        
        [DCAppVersionTool dc_SaveNewAppVersion:BUNDLE_VERSION]; //储存当前版本号
        
        // 设置窗口的根控制器
        DCNewFeatureViewController *dcFVc = [[DCNewFeatureViewController alloc] init];
        [dcFVc setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
            
            *imageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
            *showPageCount = YES;
            *showSkip = YES;
        }];
        self.window.rootViewController = dcFVc;
    }
}

#pragma mark - 适配
- (void)setUpFixiOS11
{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private
/**
 设置根 view controller
 */
//- (void)setRootVC {
//    _window = [[UIWindow alloc] initWithFrame:ScreenBounds];
//
//    // TODO: 这里的图片现在都还没有
//
//    // 首页
//    STRootNavigationController *homeRootVC = [[STRootNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
//    UITabBarItem *homeTabBarItem = [self createTabBarWithTitle:@"首页" imageName:@"tabbar_jingxuan_normal" selectedImageName:@"tabbar_jingxuan_selected" tag:0];
//    homeRootVC.tabBarItem = homeTabBarItem;
//
//    // 分类购买
//    STRootNavigationController *categoryRootVC = [[STRootNavigationController alloc] initWithRootViewController:[[CategoryPurchaseViewController alloc] init]];
//    UITabBarItem *categoryTabBarItem = [self createTabBarWithTitle:@"分类购买" imageName:@"tabbar_fenlei_normal" selectedImageName:@"tabbar_fenlei_selected" tag:1];
//    categoryRootVC.tabBarItem = categoryTabBarItem;
//
//    // 购物车
//    STRootNavigationController *cartRootVC = [[STRootNavigationController alloc] initWithRootViewController:[[ShoppingCartViewController alloc] init]];
//    UITabBarItem *cartTabBarItem = [self createTabBarWithTitle:@"购物车" imageName:@"tabbar_fenlei_normal" selectedImageName:@"tabbar_fenlei_selected" tag:2];
//    cartRootVC.tabBarItem = cartTabBarItem;
//
//    // 个人中心
//    STRootNavigationController *mineRootVC = [[STRootNavigationController alloc] initWithRootViewController:[[MineViewController alloc] init]];
//    UITabBarItem *mineTabBarItem = [self createTabBarWithTitle:@"个人中心" imageName:@"tabbar_mine_normal" selectedImageName:@"tabbar_mine_selected" tag:3];
//    mineRootVC.tabBarItem = mineTabBarItem;
//
//
//    STRootTabBarController *tabBarVC = [[STRootTabBarController alloc] init];
//    tabBarVC.tabBar.translucent = NO;
//    tabBarVC.viewControllers = @[homeRootVC, categoryRootVC, cartRootVC, mineRootVC];
//
//
//    _window.rootViewController = tabBarVC;
//    [_window makeKeyAndVisible];
//}
//
//// 创建 tabBarItem
//- (UITabBarItem *)createTabBarWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName tag:(NSInteger)tag {
//
//    UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
//    NSDictionary *normalTextAttr = @{NSFontAttributeName : DR_FONT(WidthScale(28)), NSForegroundColorAttributeName : ColorWithHexString(@"333333")};
//    NSDictionary *selectedTextAttr = @{NSFontAttributeName : DR_FONT(WidthScale(28)), NSForegroundColorAttributeName : ColorWithHexString(@"ff0036")};
//    [tabBarItem setTitleTextAttributes:normalTextAttr forState:UIControlStateNormal];
//    [tabBarItem setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
//    tabBarItem.tag = tag;
//
//    return tabBarItem;
//}


//// 检查是否登录，如果已经登录，加载用户信息；如果没有登录，生成一个 UUID 并保存本地，以这个 UUID 直接登录得到 token
- (void)checkIsLogin {
    [SNAPI getToken];
//    if ([User currentUser].isLogin) {
//        // 获取用户信息
//
//    } else {
//        // 以游客模式登录
//
//        [Utility loginWithGuestMode];
//    }
}

@end
