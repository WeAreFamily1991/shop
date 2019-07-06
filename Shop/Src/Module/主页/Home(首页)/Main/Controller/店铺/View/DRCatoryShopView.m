//
//  CRContentView.m
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "DRCatoryShopView.h"
#import "CRHeaderView.h"
#import "CatoryTabCell.h"
#import "CRDetailModel.h"
#import "DRShopHeadModel.h"
#import "DRNullGoodModel.h"
#import "CRConst.h"
#import "CRMacro.h"
#import "UIScrollView+CRExtention.h"
#import "UIView+CRExtention.h"

@interface DRCatoryShopView ()<
UITableViewDelegate,
UITableViewDataSource>

// 这里不能叫delegate,与UIScrollView自带的冲突
@property (nonatomic, weak) id<DRCatoryShopViewDelegate> CatoryShopDelegate;
@property (nonatomic, strong) CRDetailModel *detailModel;
@property (nonatomic, strong) DRShopHeadModel *shopHeadModel;
@property (nonatomic, strong) DRNullGoodModel *nullGoodModel;
@property (nonatomic,strong)NSString *sellerid;
@end

@implementation DRCatoryShopView {
    UIImageView *_backgroundImageView;
    CRHeaderView *_headerView;
    
    NSObject *_observer;
    BOOL _isScrollable; // 外层滚动图是否可以滚动
    BOOL _isSegmentToTop; // 是否 segment 已滚动到顶部
    BOOL _isSegmentToTopPre; // 前一次的状态,防止通知过于频繁
}

- (instancetype)initWithFrame:(CGRect)frame
              contentDelegate:(id<DRCatoryShopViewDelegate>)CatoryShopDelegate
                  detailModel:(CRDetailModel *)detailModel ShopHeadModel:(DRShopHeadModel *)shopHeadModel nullGoodModel:(DRNullGoodModel*)nullGoodModel withSellID:(NSString *)sellerid {
    if (self = [super initWithFrame:frame]) {
        _CatoryShopDelegate = CatoryShopDelegate;
        _detailModel = detailModel;
        _detailModel = detailModel;
        _shopHeadModel =shopHeadModel;
        _nullGoodModel =nullGoodModel;
        _sellerid =sellerid;
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_observer];
}

// 手势事件会一直往下传递，不论当前层次是否对该事件进行响应。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)setup {
    self.delegate = self;
    self.dataSource = self;
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (isIphoneX) {
        self.rowHeight = kScreenHeight - kNavigationBarHeight88 - kBottomBarHeight - kSafeAreaLayoutGuideBottomHeight;
    } else {
        self.rowHeight = kScreenHeight - kNavigationBarHeight64 - kBottomBarHeight;
    }
    
    // 头部
    CGRect headerFrame = CGRectMake(0, 0, kScreenWidth, [CRConst kHeaderViewHeight]);
    _headerView = [[CRHeaderView alloc] initWithFrame:headerFrame detailModel:_detailModel];
    
    _backgroundImageView = [UIImageView new];
    _backgroundImageView.frame = _headerView.frame;
    _backgroundImageView.layer.masksToBounds = YES;
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.backgroundColor = kPlaceholderColor;
    [_backgroundImageView sd_setImageWithURL:_detailModel.backgroundURL];
    
    UIView *alphaView = [UIView new];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.2;
    alphaView.frame = _headerView.bounds;
    [_backgroundImageView addSubview:alphaView];
    
    [self setZoomImageView:_backgroundImageView headerView:_headerView];
    
    @weakify(self);
    _observer = [[NSNotificationCenter defaultCenter] addObserverForName:kLeaveTopNotification
                                                                  object:nil
                                                                   queue:nil
                                                              usingBlock:^(NSNotification * _Nonnull note) {
                                                                  @strongify(self);
                                                                  self->_isScrollable = [note.object boolValue];
                                                              }];
    
    // 当被依赖的gestureRecognizer.state = failed时，另一个gestureRecognizer才能对手势进行响应。
    UIView *v = _detailModel.currentController.navigationController.view;
    UIScreenEdgePanGestureRecognizer *screenGesture = [v cr_screenEdgePanGestureRecognizer];
    if (screenGesture) {
        [self.panGestureRecognizer requireGestureRecognizerToFail:screenGesture];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CatoryTabCell *cell = [CatoryTabCell cellWithTableView:tableView];
    cell.sellerid =self.sellerid;
    cell.nullGoodModel =self.nullGoodModel;
    cell.model = _detailModel;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat top = isIphoneX ? kNavigationBarHeight88 : kNavigationBarHeight64;
    CGFloat segmentOffsetY = [self rectForSection:0].origin.y - top;
    CGFloat offsetY = scrollView.contentOffset.y;
    [self.CatoryShopDelegate contentView:self offsetY:offsetY];
    
    _isSegmentToTopPre = _isSegmentToTop;
    if (offsetY >= segmentOffsetY) { // segment 到顶端
        scrollView.contentOffset = CGPointMake(0, segmentOffsetY);
        _isSegmentToTop = YES;
    } else {
        _isSegmentToTop = NO;
    }
    
    if (_isSegmentToTop != _isSegmentToTopPre) {
        if (!_isSegmentToTopPre && _isSegmentToTop) { // 到顶端
            [[NSNotificationCenter defaultCenter] postNotificationName:kToTopNotification
                                                                object:@(YES)];
            _isScrollable = NO;
        }
        if (_isSegmentToTopPre && !_isSegmentToTop) { // 离开顶端
            if (!_isScrollable && offsetY != -[CRConst kHeaderViewHeight]) {
                scrollView.contentOffset = CGPointMake(0, segmentOffsetY);
            }
        }
    }
}

@end
