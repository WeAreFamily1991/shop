//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "DetailOrdervc.h"
#import "ThirdCell.h"
#import "CollectionCell.h"
#import "DetailHeadView.h"
#import "CustomFooterView.h"
#import "HeadView.h"
@interface DetailOrdervc ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
{
    int pageCount;
}
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UITableView*  tableView;
@property (weak, nonatomic) IBOutlet UIButton *saleOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (nonatomic,retain)UIButton *footBtn;

@property(nonatomic,strong)NSDictionary* dataDict;
@property(nonatomic,strong)NSArray*  dataArr;
@property(nonatomic,strong)NSMutableArray*   isOpenArr;
@property(nonatomic,strong)NSArray* sectionNameArr;

@property (nonatomic, copy) NSString *titleStr;
@end

@implementation DetailOrdervc
- (IBAction)btnClick:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"订单详情";
    [self loadSource];
    self.view.backgroundColor =BACKGROUNDCOLOR;
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-50-DRTopHeight) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_tableView registerClass:[ThirdCell class] forCellReuseIdentifier:@"ThirdCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
-(void)loadSource
{
//    _sectionNameArr=@[@"客厅"];
    self.isOpenArr=[[NSMutableArray alloc] init];
    // self.dataDict=@{@"first":firstDataArr,@"second":secondArr,@"third":thirdArr};
    //    self.dataArr=@[firstDataArr];
    //for (int i=0; i<self.dataDict.allKeys.count; i++) {

    [self.isOpenArr addObject:@"close"];
    
    [self loadTableView];
    [self addHeadView];
    [self getMsgList];

}
-(void)addHeadView
{
    DetailHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeadView" owner:self options:nil] lastObject];
    self.tableView.tableHeaderView =headView;
   
   
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        _sendDataDictionary = [[NSMutableDictionary alloc] init];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
   
}
-(void)addCustomView
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, 36)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            NSString*  state=[self.isOpenArr objectAtIndex:section];
            if ([state isEqualToString:@"open"])
            {
                // NSString*  key=[self.dataDict.allKeys objectAtIndex:section];
                //   NSArray*  arr=[self.dataDict objectForKey:key];
//                NSArray*  arr=[self.dataArr objectAtIndex:section];
                return 4+3;
            }
            return 4;
        }
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 5;
            break;
            
        default:
            break;
    }
    return 0;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return HScale(35);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        switch (indexPath.row) {
            case 0:
            {
                CollectionCell7 *cell =[CollectionCell7 cellWithTableView:tableView];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case 1:
            case 2:
            {
                static NSString *index =@"cell";
                UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
                if (cell==nil) {
                    cell =[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
                     cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if (indexPath.row==1) {
                    cell.textLabel.text =@"开票方：三块神铁";
                }
                else if (indexPath.row==2)
                {
                    cell.textLabel.text =@"华东仓 现结  三铁配送";
                }
               
                
                cell.textLabel.textColor =[UIColor redColor];
                cell.textLabel.font =DR_FONT(12);
                return cell;
            }
                break;
                
            default:
            {
                ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCell"];
                cell.dataDict = @{};
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }
                break;
        }
    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"啦啦啦啦啦啦啦啦啦啦阿拉啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦阿拉啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦阿拉啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦阿拉啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦阿拉啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦阿拉啦啦啦啦啦啦啦啦啦啦";
    cell.textLabel.numberOfLines =0;
    cell.textLabel.font =DR_FONT(12);
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale(35));
    bgView.backgroundColor = BACKGROUNDCOLOR;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 0, SCREEN_WIDTH-16, bgView.frame.size.height);
    NSArray *titleArray=  @[@"",@"订单留言",@"收货信息",@"配送信息",@"支付信息"];
    label.text =titleArray[section];
    label.font =DR_BoldFONT(15);
    label.textColor = [UIColor blackColor];
    [bgView addSubview:label];
    
    
    return bgView;
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section==0) {
//        HeadView *headView = [HeadView headViewWithTableView:tableView];
//
////        headView.bgBtnBlock = ^(BOOL bgBtnSelectBlock) {
////            self.isSelected =bgBtnSelectBlock;
////            [self.tableView reloadData];
////        };
//
////        headView.titleGroup = self.answersArray[section];
//
//        return headView;
//    }
//    return nil;
//}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) {
        UIView*  sectionBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        sectionBackView.backgroundColor=[UIColor whiteColor];
        UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        button.tag=100+section;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"open"]) {
            [button setImage:[UIImage imageNamed:@"arrow_down_grey"] forState:UIControlStateNormal];
             [button setTitle:@"收起全部" forState:UIControlStateNormal];
        }
        else if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"close"]) {
            [button setImage:[UIImage imageNamed:@"arrow_right_grey"] forState:UIControlStateNormal];
              [button setTitle:@"查看全部" forState:UIControlStateNormal];
        }
         [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        [button addTarget:self action:@selector(ClickSection:) forControlEvents:UIControlEventTouchUpInside];
        [sectionBackView addSubview:button];
        return sectionBackView;
    }
    return nil;
}
-(void)ClickSection:(UIButton*)sender
{
    NSString*  state=[self.isOpenArr objectAtIndex:sender.tag-100];
    if ([state isEqualToString:@"open"]) {
        state=@"close";
    }else
    {
        state=@"open";
    }
    self.isOpenArr[sender.tag-100]=state;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag-100];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

@end
