//
//  ChildVC.m
//  Shop
//
//  Created by BWJ on 2019/3/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChildVC.h"
#import "ChildCell.h"
#import "ChildAddVC.h"
@interface ChildVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)UIButton *addBtn;
@end

@implementation ChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"子账号";
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
    [self addTableViewfooterView];
//     [_tableView registerClass:[ChildCell class] forCellReuseIdentifier:@"ChildCell"];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark 添加表尾
-(void)addTableViewfooterView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-HScale(60)-DRTopHeight, SCREEN_WIDTH, HScale(60))];
    headView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:headView];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(20, 10,SCREEN_WIDTH-40, HScale(40));
    [self.addBtn setTitle:@"新增" forState:UIControlStateNormal];
    
    
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addBtn.layer.cornerRadius =HScale(20);
    self.addBtn.layer.masksToBounds =HScale(20);
    self.addBtn.titleLabel.font = DR_FONT(15);
    self.addBtn.backgroundColor =[UIColor redColor];
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.addBtn];
    
    
}
-(void)addBtnClick
{
    ChildAddVC *addVC =[[ChildAddVC alloc]init];    
    addVC.selectType =NO;
    [self.navigationController pushViewController:addVC animated:YES];
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale(110);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 60;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildCell *cell = [ChildCell cellWithTableView:tableView];
//    cell.dataDict = @{};
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.editBtn.tag =indexPath.row;
    [cell.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.startBtn.tag =indexPath.row;
    [cell.startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.cancelBtn.tag =indexPath.row;
    [cell.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
#pragma 点击事件
-(void)editBtnClick:(UIButton *)sender
{
    NSLog(@"edit");

    ChildAddVC *addVC =[[ChildAddVC alloc]init];

    addVC.selectType =YES;
    [self.navigationController pushViewController:addVC animated:YES];
}

-(void)startBtnClick:(UIButton *)sender
{
     NSLog(@"start");
    sender.selected =!sender.selected;
}

-(void)cancelBtnClick:(UIButton *)sender
{
     NSLog(@"cancel");
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
