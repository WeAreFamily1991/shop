//
//  HQTopStopView.m
//  HQCollectionViewDemo
//
//  Created by Mr_Han on 2018/10/10.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
// 

#import "HQTopStopView.h"

@interface HQTopStopView ()<SYMoreButtonDelegate>
@end
@implementation HQTopStopView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
   
 
    
   
}

-(void)setSelectIndex:(NSInteger)selectIndex
{

    if (selectIndex!=7) {
        return;
    }
    NSArray *titles = @[@"全部",@"不锈钢",@"碳钢",@"其他"];
    
    CGFloat btnW = (ScreenW - 100) / titles.count;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = DR_FONT(15);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.frame = CGRectMake(20*(i+1)+btnW*i, 10, btnW, 25);
        button.tag =i+100;
        if (i==0) {
            [self buttonBtnClick:button];
        }
        [button addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:button];
    }
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview:lineView];
    self.bottomBtnView = [[SYMoreButtonView alloc] initWithFrame:CGRectMake(0.0, 45, ScreenW, 35)];
    [self addSubview:self.bottomBtnView];
    self.bottomBtnView.backgroundColor = [UIColor clearColor];
    self.bottomBtnView.titles = @[@"精选", @"直播", @"关注", @"视频购", @"社区", @"好东西", @"生活", @"数码", @"亲子", @"风尚", @"美食"];
    self.bottomBtnView.showline = YES;
    self.bottomBtnView.showlineAnimation = YES;
     self.bottomBtnView.font = 12;
    self.bottomBtnView.indexSelected = 0;
    self.bottomBtnView.colorSelected = [UIColor redColor];
    self.bottomBtnView.delegate = self;
    self.bottomBtnView.buttonClick = ^(NSInteger index) {
        NSLog(@"block click index = %@", @(index));
    };
    [self.bottomBtnView reloadData];
}
- (UIView *)topView {
    if (!_topView) {
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _topView.backgroundColor =[UIColor greenColor];
        [self addSubview:_topView];
    }
    return _topView;
}
-(void)buttonBtnClick:(UIButton *)sender
{
    self.buttonBtn.selected = NO ;
    sender.selected = YES ;
    self.buttonBtn = sender ;
    
    NSLog(@"点击 %ld",sender.tag) ;
}
@end
