//
//  ChangeOrderVC.m
//  Shop
//
//  Created by BWJ on 2019/2/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChangeOrderVC.h"
#import "SegmentViewController.h"
#import "OrderDetailVC.h"
#import "SYTypeButtonView.h"
#import "CGXPickerView.h"

@interface ChangeOrderVC ()<UITextFieldDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView2 *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView2 *titleView;

@property (nonatomic,strong)SYTypeButtonView *buttonView;
@property (nonatomic,strong)UITextField *orderTF;
@property (nonatomic,retain)NSMutableDictionary *mudic;
@property (nonatomic,strong)NSMutableArray *chileVCS;
@end

@implementation ChangeOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"交易订单";
    self.view.backgroundColor =[UIColor whiteColor];
    self.mudic=[NSMutableDictionary dictionary];
    self.chileVCS =[NSMutableArray array];
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
                    
                    [self.mudic  setValue:[SNTool currenTime] forKey:@"endTime"];
                    if ([selectRow intValue]!=0) {
                        
                        [self.buttonView setTitleButton:[SNTool currenTime] index:1];
                        
                        [self.buttonView setTypeButton:YES index:0];
                        [self.buttonView setTypeButton:YES index:1];
                    }
                    NSLog(@"%@",selectValue);
                    if ([selectRow intValue]==0) {
                        [self.mudic  setValue:@"" forKey:@"startTime"];
                        [self.mudic  setValue:@"" forKey:@"endTime"];
                        [self.buttonView setTitleButton:@"起始时间" index:0];
                        [self.buttonView setTitleButton:@"截止时间" index:1];
                    }
                    else if ([selectRow intValue]==1)
                    {
                        [self.mudic setValue:[SNTool ddpGetExpectTimestamp:0 month:-1 day:0]  forKey:@"startTime"];
                        [self.buttonView setTitleButton:[SNTool ddpGetExpectTimestamp:0 month:-1 day:0] index:0];
                    }
                    else if ([selectRow intValue]==2)
                    {
                        [self.mudic setValue:[SNTool ddpGetExpectTimestamp:0 month:-2 day:0] forKey:@"startTime"];
                        [self.buttonView setTitleButton:[SNTool ddpGetExpectTimestamp:0 month:-2 day:0] index:0];
                        
                    }
                    else if ([selectRow intValue]==3)
                    {
                        [self.mudic setValue:[SNTool ddpGetExpectTimestamp:-1 month:0 day:0] forKey:@"startTime"];
                        [self.buttonView setTitleButton:[SNTool ddpGetExpectTimestamp:-1 month:0 day:0] index:0];
                        
                        
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeOrder" object:nil userInfo:self.mudic ];
                }];
                
            }
                //                [buttonView setTitleButton:@"2019-02-27" index:2];
                break;
                
            default:
                break;
        }
    };
    self.buttonView.titleColorNormal = [UIColor blackColor];
    self.buttonView.titleColorSelected = [UIColor blackColor];
    self.buttonView.titles = @[@"起始时间", @"截止时间", @"全部订单"];
    self.buttonView.enableTitles =  @[@"起始时间", @"截止时间", @"全部订单"];
    NSDictionary *dict01 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_down"], keyImageSelected, nil];
    NSDictionary *dict02 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_down"], keyImageSelected, nil];
    NSDictionary *dict03 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_down"], keyImageSelected, nil];
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
    self.orderTF.placeholder =@"请输入订单编号进行查询";
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
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    [mudic setValue:self.orderTF.text forKey:@"dzNo"];
    [mudic setValue:@"3" forKey:@"index"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeOrder" object:nil userInfo:mudic];
}
-(void)selectDatePickViewWithIndex:(NSInteger)selectIndex
{
    DRWeakSelf;
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];

    [CGXPickerView showDatePickerWithTitle:selectIndex?@"截止时间":@"起始时间" DateType:UIDatePickerModeDate DefaultSelValue:nowStr MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
        if (selectIndex==0) {
            [self.mudic setValue:selectValue forKey:@"startTime"];
            
        }else
        {
            [self.mudic setValue:selectValue forKey:@"endTime"];
            
        }
        
        NSArray *allKeyArr =[self.mudic allKeys];
        if (allKeyArr.count==2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeOrder" object:nil userInfo:self.mudic ];
        }
        NSLog(@"%@",selectValue);
        [weakSelf.buttonView setTitleButton:selectValue index:selectIndex];
    }];
}
-(void)addsegentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;//,@"周三",@"周四",@"周五",@"周六",@"周日",
    NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"全部", @"已取消", @"待审核", @"待付款", @"待发货", @"待收货",@"已完成",@"退货中",@"已退货" ,nil];
    self.titleView = [[FSSegmentTitleView2 alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40) delegate:self indicatorType:0];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.button_Width = SCREEN_WIDTH/6;
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
    
    //    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<titleArray.count; i++)
    {
        OrderDetailVC *VC = [[OrderDetailVC alloc] init];
        VC.status = i;
        [self.chileVCS addObject:VC];
    }
    self.pageContentView = [[FSPageContentView2 alloc]initWithFrame:CGRectMake(0,120, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-120) childVCs:self.chileVCS parentVC:self delegate:self];
    self.pageContentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageContentView];
    
    self.titleView.selectIndex = _num;
    self.pageContentView.contentViewCurrentIndex = _num;
}
//********************************  分段选择  **************************************
- (void)FSSegmentTitleView:(FSSegmentTitleView2 *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    OrderDetailVC *VC = self.chileVCS[endIndex];
    VC.sendDataDictionary =self.mudic;
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
