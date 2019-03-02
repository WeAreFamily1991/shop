//
//  ChangeOrderVC.m
//  Shop
//
//  Created by BWJ on 2019/2/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "BillApplicationVC.h"
#import "SegmentViewController.h"
#import "BillApplicationDetailVC.h"
#import "SYTypeButtonView.h"
#import "CGXPickerView.h"

@interface BillApplicationVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView2 *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView2 *titleView;

@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)UITextField *orderTF;
@end

@implementation BillApplicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"开票申请";
    
    [self addsegentView];
    [self setUI];
    //
    // Do any additional setup after loading the view from its nib.
}
-(void)setUI
{
    DRWeakSelf;
    self.buttonView = [[SYTypeButtonView alloc] initWithFrame:CGRectMake(0.0, 40, CGRectGetWidth(self.view.bounds), 40) view:self.view];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    
    self.buttonView.buttonClick = ^(NSInteger index, BOOL isDescending){
        NSLog(@"click index %ld, isDescending %d", index, isDescending);
        switch (index) {
            case 0:
            {
                
                [weakSelf selectDatePickViewWithIndex:0];
                
            }
                break;
            case 1:
                
                [weakSelf selectDatePickViewWithIndex:1];
                break;
            case 2:
            {
                [CGXPickerView showStringPickerWithTitle:@"全部订单" DataSource:@[ @"全部订单",@"近一个月订单", @"近两个月订单", @"一年内订单"] DefaultSelValue:@"全部订单" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                    NSLog(@"%@",selectValue);
                    [weakSelf.buttonView setTitleButton:selectValue index:2];
                }];
            }
                //                [buttonView setTitleButton:@"2019-02-27" index:2];
                break;
                
            default:
                break;
        }
    };
    self.buttonView.titleColorNormal = [UIColor blackColor];
    self.buttonView.titleColorSelected = [UIColor redColor];
    self.buttonView.titles = @[@"起始时间", @"截止时间", @"全部订单"];
    self.buttonView.enableTitles =  @[@"起始时间", @"截止时间", @"全部订单"];
    NSDictionary *dict01 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_downSelected"], keyImageSelected, nil];
    NSDictionary *dict02 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_downSelected"], keyImageSelected, nil];
    NSDictionary *dict03 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_downSelected"], keyImageSelected, nil];
    self.buttonView.imageTypeArray = @[dict01, dict02, dict03];
    self.buttonView.selectedIndex = -1;
    
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH,40)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIImageView *backIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_bg.png"]];
    backIMG.frame =CGRectMake(15, 4, 3*SCREEN_WIDTH/5, 30);
    backIMG.userInteractionEnabled =YES;
    [backView addSubview:backIMG];
    self.orderTF =[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 3*SCREEN_WIDTH/5-20, 30)];
    self.orderTF.placeholder =@"单据编号/店铺名称";
    self.orderTF.font =DR_FONT(14);
    self.orderTF.delegate =self;
    [backIMG addSubview:self.orderTF];
    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.layer.cornerRadius =15;
    searchBtn.layer.masksToBounds =15;
    searchBtn.backgroundColor =[UIColor redColor];
    searchBtn.titleLabel.font =DR_FONT(14);
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    searchBtn.frame =CGRectMake(3*SCREEN_WIDTH/5+30, 4, SCREEN_WIDTH-3*SCREEN_WIDTH/5-45, 30);
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:searchBtn];
}
-(void)searchBtnClick:(UIButton *)sender
{
    NSLog(@"textField==%@",self.orderTF.text);
}
-(void)selectDatePickViewWithIndex:(NSInteger)selectIndex
{
    DRWeakSelf;
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowStr = [fmt stringFromDate:now];
    //    NSString *titleStr ;
    
    [CGXPickerView showDatePickerWithTitle:selectIndex?@"截止时间":@"起始时间" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
        NSLog(@"%@",selectValue);
        [weakSelf.buttonView setTitleButton:selectValue index:selectIndex];
    }];
}
-(void)addsegentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"可开票单据", @"审核中单据", @"已开票单据", @"已过期单据" ,nil];
    self.titleView = [[FSSegmentTitleView2 alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40) delegate:self indicatorType:0];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.button_Width = SCREEN_WIDTH/4.5;
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
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        BillApplicationDetailVC *VC = [[BillApplicationDetailVC alloc] init];
        VC.status = i;
        [childVCs addObject:VC];
    }
    self.pageContentView = [[FSPageContentView2 alloc]initWithFrame:CGRectMake(0,120, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-120) childVCs:childVCs parentVC:self delegate:self];
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
