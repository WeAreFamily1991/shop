//
//  ChangeOrderVC.m
//  Shop
//
//  Created by BWJ on 2019/2/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SalesOrderVC.h"
#import "SegmentViewController.h"
#import "SalesOrderDetailVC.h"
#import "SYTypeButtonView.h"
#import "CHDatePickerMenu.h"
static CGFloat const ButtonHeight = 38;
@interface SalesOrderVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView2 *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView2 *titleView;
@property (nonatomic,strong)SalesOrderDetailVC *detailVC;
@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)UITextField *orderTF;
@property (nonatomic,strong)SalesOrderDetailVC  *VC;
@property (nonatomic,strong)NSMutableArray *childVCs;
@end

@implementation SalesOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"销售对账";
    
    [self addsegentView];
    [self setUI];
    //
    // Do any additional setup after loading the view from its nib.
}
-(void)setUI
{
    DRWeakSelf;
    self.buttonView = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(0.0, 40, SCREEN_WIDTH/4, heightTypeButtonView) view:self.view];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    
    self.buttonView.buttonClick = ^(NSInteger index, BOOL isDescending){
        NSLog(@"click index %ld, isDescending %d", index, isDescending);
        
                [weakSelf selectDatePickViewWithIndex:0];
    };
    self.buttonView.titleColorNormal = [UIColor blackColor];
    self.buttonView.titleColorSelected = [UIColor redColor];
    self.buttonView.titles = @[@"对账时间"];
    self.buttonView.enableTitles =  @[@"对账时间"];
    NSDictionary *dict01 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_downSelected"], keyImageSelected, nil];

    self.buttonView.imageTypeArray = @[dict01];
    self.buttonView.selectedIndex = -1;

    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 40, SCREEN_WIDTH-SCREEN_WIDTH/4, 40)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIImageView *backIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_bg.png"]];
    backIMG.frame =CGRectMake(5, 4, SCREEN_WIDTH/2, 30);
    backIMG.userInteractionEnabled =YES;
    [backView addSubview:backIMG];
    self.orderTF =[[UITextField alloc]initWithFrame:CGRectMake(10, 0,SCREEN_WIDTH/2-20, 30)];
    self.orderTF.placeholder =@"请输入对账单查询";
    self.orderTF.delegate =self;
    self.orderTF.font =DR_FONT(14);
    [backIMG addSubview:self.orderTF];
    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.layer.cornerRadius =15;
    searchBtn.layer.masksToBounds =15;
    searchBtn.backgroundColor =[UIColor redColor];
    searchBtn.titleLabel.font =DR_FONT(14);
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    searchBtn.frame =CGRectMake(SCREEN_WIDTH/2+15, 4,SCREEN_WIDTH/4-25, 30);
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:searchBtn];
}
-(void)searchBtnClick:(UIButton *)sender
{
    NSLog(@"textField==%@",self.orderTF.text);
    
//    [self.VC.sourceDic setValue:self.orderTF.text forKey:@"dzNo"];
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    [mudic setValue:self.orderTF.text forKey:@"dzNo"];
    [mudic setValue:@"2" forKey:@"index"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sale" object:nil userInfo:mudic];
//    [self.VC setSourceWithDic:mudic withIndex:2];
}
-(void)selectDatePickViewWithIndex:(NSInteger)selectIndex
{
    DRWeakSelf;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    __auto_type datePicker = [CHDatePickerMenu menuWithMode:CHDatePickerModeDateYM onSelectDate:^(NSDate * _Nonnull date) {
//        self.selectedDateLabel.text = [formatter stringFromDate:date];
        [weakSelf.buttonView setTitleButton:[formatter stringFromDate:date] index:selectIndex];

        NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
        [mudic setValue:[formatter stringFromDate:date] forKey:@"time"];
        [mudic setValue:@"1" forKey:@"index"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sale" object:nil userInfo:mudic];
//        [self.VC setSourceWithDic:mudic withIndex:1];
//        [weakSelf.VC.sourceDic setValue:[formatter stringFromDate:date] forKey:@"time"];
    }];
    datePicker.datePickerView.maximumDate = NSDate.date;
    
    [datePicker show];
}
-(void)addsegentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"订单对账", @"费用对账",nil];
    self.titleView = [[FSSegmentTitleView2 alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40) delegate:self indicatorType:0];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.button_Width = WScale(50);
    self.titleView.titlesArr = titleArray;
    _titleView.titleNormalColor = [UIColor darkGrayColor];
    _titleView.titleSelectColor = [UIColor redColor];
    self.titleView.titleFont = DR_FONT(14);
    self.titleView.indicatorView.image = [UIImage imageWithColor:[UIColor redColor]];
    [self.view addSubview:_titleView];
    ///线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40-1,SCREEN_WIDTH,0.8)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self.titleView addSubview:lineLabel];
    self.childVCs = [[NSMutableArray alloc]init];
    for (int i = 0; i<titleArray.count; i++)
    {
        self.VC= [[SalesOrderDetailVC alloc] init];
        self.VC.status = i;
        [self.childVCs addObject:self.VC];
    }
    self.pageContentView = [[FSPageContentView2 alloc]initWithFrame:CGRectMake(0,80, SCREEN_WIDTH,SCREEN_HEIGHT-80-DRTopHeight) childVCs:self.childVCs parentVC:self delegate:self];
    self.pageContentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageContentView];
    self.titleView.selectIndex = _num;
    self.pageContentView.contentViewCurrentIndex = _num;
}
//********************************  分段选择  **************************************
- (void)FSSegmentTitleView:(FSSegmentTitleView2 *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    SalesOrderDetailVC *detailVC= self.childVCs[endIndex];
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
