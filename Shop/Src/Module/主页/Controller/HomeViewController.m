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
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
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
      [self setUpScrollToTopView];
}
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 110, 40, 40);
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
//    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > DRTopHeight) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
//    [self.view scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
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
