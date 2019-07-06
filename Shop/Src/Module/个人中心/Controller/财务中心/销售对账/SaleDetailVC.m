//
//  BillingInformationVC.m
//  Shop
//
//  Created by BWJ on 2019/2/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SaleDetailVC.h"
#import "SaleDetailChildVC.h"
@interface SaleDetailVC ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView2 *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView2 *titleView;

@end

@implementation SaleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.fatherStatus==1) {
        self.title =@"费用对账详情";
    }
    else
    {
        self.title =@"订单对账详情";
    }
    [self addsegentView];
}
-(void)addsegentView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray =[NSMutableArray array];
    titleArray = [[NSMutableArray alloc] initWithObjects:@"所有订单", @"在线支付",@"额度支付",nil];
    self.titleView = [[FSSegmentTitleView2 alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,WScale(40)) delegate:self indicatorType:0];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.button_Width = WScale(50);
    self.titleView.titlesArr = titleArray;
    _titleView.titleNormalColor = [UIColor darkGrayColor];
    _titleView.titleSelectColor = REDCOLOR;
    self.titleView.titleFont = DR_FONT(14);
    self.titleView.indicatorView.image = [UIImage ImageWithColor:REDCOLOR frame:self.titleView.bounds];
    [self.view addSubview:_titleView];
    
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WScale(40)-1,SCREEN_WIDTH,0.8)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        SaleDetailChildVC *VC = [[SaleDetailChildVC alloc] init];
        VC.fatherStatus =self.fatherStatus;
        VC.saleModel =self.saleModel;
        VC.status = i;
        [childVCs addObject:VC];
    }
    self.pageContentView = [[FSPageContentView2 alloc]initWithFrame:CGRectMake(0,40, SCREEN_WIDTH,SCREEN_HEIGHT-40-DRTopHeight) childVCs:childVCs parentVC:self delegate:self];
    self.pageContentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageContentView];
    
    self.titleView.selectIndex = _num;
    self.pageContentView.contentViewCurrentIndex = _num;
}
//********************************  分段选择  **************************************
- (void)FSSegmentTitleView:(FSSegmentTitleView2 *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
}
- (void)FSContenViewDidEndDecelerating:(FSPageContentView2 *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
