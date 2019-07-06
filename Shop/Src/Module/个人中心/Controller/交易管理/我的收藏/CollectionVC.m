//
//  ChangeOrderVC.m
//  Shop
//
//  Created by BWJ on 2019/2/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CollectionVC.h"
#import "SegmentViewController.h"
#import "CollectionDetailVC.h"
#import "SYTypeButtonView.h"
#import "CGXPickerView.h"
static CGFloat const ButtonHeight = 40;
@interface CollectionVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView2 *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView2 *titleView;
@property (nonatomic,strong)CollectionDetailVC *detailVC;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)UITextField *orderTF;
@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"我的收藏";
    
    [self addsegentView];
//    [self setUI];
    //
    // Do any additional setup after loading the view from its nib.
}



-(void)addsegentView
{
    DRWeakSelf;
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"商品收藏", @"店铺收藏",nil];
    self.titleView = [[FSSegmentTitleView2 alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40) delegate:self indicatorType:0];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.button_Width = WScale(45);
    self.titleView.titlesArr = titleArray;
    _titleView.titleNormalColor = [UIColor darkGrayColor];
    _titleView.titleSelectColor = REDCOLOR;
    self.titleView.titleFont = DR_FONT(14);
    self.titleView.indicatorView.image = [UIImage ImageWithColor:REDCOLOR frame:self.titleView.bounds];
    [self.view addSubview:_titleView];
    
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40-1,SCREEN_WIDTH,0.8)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        CollectionDetailVC  *VC = [[CollectionDetailVC alloc] init];
        VC.status = i;
        [childVCs addObject:VC];
    }
    self.pageContentView = [[FSPageContentView2 alloc]initWithFrame:CGRectMake(0,40, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-40) childVCs:childVCs parentVC:self delegate:self];
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
