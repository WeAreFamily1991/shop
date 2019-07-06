//
//  DRTigetsVC.m
//  Shop
//
//  Created by BWJ on 2019/4/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRTigetsVC.h"
#import "SegmentViewController.h"
#import "DRTigetDetailVC.h"
#import "SYTypeButtonView.h"
#import <SDCycleScrollView.h>
#import "NewsModel.h"
@interface DRTigetsVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate,SDCycleScrollViewDelegate>
/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) FSPageContentView2 *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView2 *titleView;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)DRTigetDetailVC *detailVC;
@property (nonatomic,strong)UITextField *orderTF;
@property (nonatomic,assign)NSInteger selectdex;
@property (nonatomic,retain) UILabel *titlLab;
@property (nonatomic,retain) UIButton *myBtn;
@property (nonatomic,retain)NSMutableArray *bannerArr;
@end

@implementation DRTigetsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    self.title =@"领券中心";
    _titlLab = [[UILabel alloc] initWithFrame:CGRectMake(0, DCMargin, ScreenW, HScale(20))];
    _titlLab.font = DR_FONT(12);
    _titlLab.textAlignment = 1;
    _titlLab.textColor =REDCOLOR;
    _titlLab.text =@"————  购物先领券，优惠享不断  ————";
    [ self.view addSubview:_titlLab];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, _titlLab.dc_bottom+DCMargin, ScreenW, HScale(80)) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.currentPageDotColor =WHITECOLOR;
    _cycleScrollView.pageDotColor =[UIColor grayColor];
     [self.view addSubview:_cycleScrollView];
    UIView *myView =[[UIView alloc]initWithFrame:CGRectMake(DCMargin,_cycleScrollView.dc_bottom, ScreenW-2*DCMargin, HScale(40))];
    myView.backgroundColor =WHITECOLOR;
    myView.layer.masksToBounds =5;
    myView.layer.cornerRadius =5;
    myView.backgroundColor =WHITECOLOR;
    [self.view addSubview:myView];
    _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _myBtn.frame =CGRectMake(DCMargin, 0, WScale(100), myView.dc_height);
    _myBtn.backgroundColor =[UIColor whiteColor];
    _myBtn.titleLabel.font = DR_FONT(14);
    [_myBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
    [_myBtn setImage:[UIImage imageNamed:@"news_ico"] forState:UIControlStateNormal];
    [_myBtn setTitle:@"我的抵用券" forState:UIControlStateNormal];
    [_myBtn addTarget:self action:@selector(myBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:_myBtn];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(ScreenW-myView.dc_height-DCMargin, 0, myView.dc_height, myView.dc_height);
    
    [rightBtn setImage:[UIImage imageNamed:@"news_ico"] forState:UIControlStateNormal];
   
    [rightBtn addTarget:self action:@selector(myBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:rightBtn];
    [self addsegentViewWithView:myView];
    [self addScrollViewSource];
  
    // Do any additional setup after loading the view from its nib.
}
-(void)addScrollViewSource
{
 
    DRWeakSelf;
    NSDictionary *dic =@{@"advType":@"lqzx",@"pageNum":@"1",@"pageSize":@"10"};
    [SNAPI getWithURL:@"mainPage/getAdvList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.bannerArr=[NSMutableArray array];
            //             NSArray *sourceArr =result.data;
            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            for (NewsModel *model in sourceArr) {
                [self.bannerArr addObject:model.img];
            }
            if (self.bannerArr.count!=0) {
                weakSelf.cycleScrollView.imageURLStringsGroup =self.bannerArr.copy;               
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)addsegentViewWithView:(UIView *)myView
{
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"全部精选", @"平台精选", @"店铺抵用券",nil];
    self.titleView = [[FSSegmentTitleView2 alloc]initWithFrame:CGRectMake(0,myView.dc_bottom+DCMargin,SCREEN_WIDTH,40) delegate:self indicatorType:0];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.button_Width = WScale(50);
    self.titleView.titlesArr = titleArray;
    _titleView.titleNormalColor = [UIColor darkGrayColor];
    _titleView.titleSelectColor = REDCOLOR;
    self.titleView.titleFont = DR_FONT(15);
    self.titleView.indicatorView.image = [UIImage ImageWithColor:REDCOLOR frame:self.titleView.bounds];
    [self.view addSubview:_titleView];    
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleView.dc_bottom-1,SCREEN_WIDTH,0.8)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        DRTigetDetailVC  *VC = [[DRTigetDetailVC alloc] init];
        VC.status = i;
        [childVCs addObject:VC];
    }
    self.pageContentView = [[FSPageContentView2 alloc]initWithFrame:CGRectMake(0,self.titleView.dc_bottom, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-40) childVCs:childVCs parentVC:self delegate:self];
    self.pageContentView.backgroundColor = BACKGROUNDCOLOR;
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
-(void)myBtnClick
{
    
}
#pragma mark - 点击广告跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd广告图",index);
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
