
//
//  StoreVC.m
//  Shop
//
//  Created by BWJ on 2019/3/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "StoreVC.h"
#import "ShopHeaderView.h"
@interface StoreVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)ShopHeaderView *customheadView;

@end

@implementation StoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self settableViewHeaderView];
//    if (@available(iOS 11.0, *)) {
//
//        _tableView.estimatedRowHeight = 0;
//
//        _tableView.estimatedSectionHeaderHeight = 0;
//
//        _tableView.estimatedSectionFooterHeight = 0;
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
  
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
-(void)settableViewHeaderView
{
     self.customheadView = [[[NSBundle mainBundle] loadNibNamed:@"ShopHeaderView" owner:self options:nil] lastObject];
    self.customheadView.height =HScale(60);
    self.tableView.tableHeaderView =self.customheadView;
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 30;
            break;
        case 1:
            return 30;
            break;
        case 2:
            return UITableViewAutomaticDimension;
            break;
            
        case 3:
            return 40;
            break;
            
            
        default:
            break;
    }
    return UITableViewAutomaticDimension;
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
    return 10;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    CGFloat sectionHeaderHeight = 60;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    }else
//        if(scrollView.contentOffset.y >= sectionHeaderHeight){
//
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
//    cell.textLabel.text = [_titleStr stringByAppendingString:[NSString stringWithFormat:@"-%d",(int)indexPath.row]];
    return cell;
    
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
