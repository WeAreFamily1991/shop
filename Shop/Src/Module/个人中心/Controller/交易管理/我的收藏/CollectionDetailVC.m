//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "CollectionDetailVC.h"
#import "CollectionCell.h"
#import "FirstTableViewCell.h"
#import "GoodsModel.h"
#import "CatgoryDetailCell.h"
@interface CollectionDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)FavoriteModel *favoriModel;

@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@end

@implementation CollectionDetailVC
-(NSMutableArray *)MsgListArr
{
    if (!_MsgListArr) {
        _MsgListArr =[NSMutableArray array];
    }
    return _MsgListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
  
    [self.view addSubview:self.bgTipButton];
//    self.tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height);
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
    [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"FirstTableViewCell"];
     __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.MsgListArr.count) {
            [weakSelf.MsgListArr removeAllObjects];
        }
        pageCount=1;
        [weakSelf getMsgList];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageCount = pageCount +1;
        [weakSelf getMsgList];
    }];
    [self.tableView.mj_footer endRefreshing];
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
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
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr ;
    
    
    if (self.status==0) {
        urlStr =@"buyer/getItem";
        if (page) {
            [dic setObject:page forKey:@"pageindex"];
        }
         [dic setObject:@"Wechat" forKey:@"sourceType"];
         [dic setObject:@"favorite" forKey:@"queryType"];
         [dic setObject:@"" forKey:@"keyword"];
    }
    else
    {
         urlStr =@"buyer/favoriteSellerList";
        if (page) {
            [dic setObject:page forKey:@"pageNum"];
            [dic setObject:@"10" forKey:@"pageSize"];
        }
        [dic setObject:@"" forKey:@"name"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
    DRWeakSelf;
    [MBProgressHUD showMessage:@""];
    [SNIOTTool getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        if (self.status==0) {
            NSLog(@"data=%@",result.data[@"itemdata"]);
            NSMutableArray*addArr=result.data[@"itemdata"];
            NSMutableArray *modelArray =[GoodsModel mj_objectArrayWithKeyValuesArray:result.data[@"itemdata"]];
            [weakSelf.MsgListArr addObjectsFromArray:modelArray];
            [self.tableView reloadData];
            if (addArr.count<10){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                [self.tableView.mj_footer endRefreshing];
            }
        }else
        {
            NSLog(@"data=%@",result.data[@"list"]);
            NSMutableArray*addArr=result.data[@"list"];
            NSMutableArray *modelArray =[FavoriteModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
            [weakSelf.MsgListArr addObjectsFromArray:modelArray];
            [self.tableView reloadData];
            if (addArr.count<10){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                [self.tableView.mj_footer endRefreshing];
            }
        }
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
    }];
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
- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"MG_Empty_dizhi"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无数据" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-DRTopHeight, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}



#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return self.MsgListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.status==1) {
        return SCREEN_HEIGHT/7;
    }
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.status==1) {
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.MsgListArr.count!=0) {
        
        if (self.status==1) {
            self.favoriModel=self.MsgListArr[indexPath.section];
            CollectionCell *cell =[CollectionCell cellWithTableView:tableView];
            cell.favoriModel =self.favoriModel;
            cell.collectionSelectBlock = ^(NSInteger collectionSelectag) {
                NSDictionary *dic =@{@"id":self.favoriModel.favorite_id};
                
                [SNIOTTool deleteWithURL:@"buyer/cancelSellerFavorite" parameters:[dic mutableCopy] success:^(SNResult *result) {
                    [self.tableView.mj_header beginRefreshing];
                    
                } failure:^(NSError *error) {
                    
                }];
            };
            return cell;
        }
        self.goodsModel=self.MsgListArr[indexPath.section];
        switch (indexPath.row) {
            case 0:
                
            {
                CollectionCell5 *cell =[CollectionCell5 cellWithTableView:tableView];
                cell.goodsModel =self.goodsModel;
                return cell;
            }
                break;
            case 1:
                
            {
                static NSString *SimpleTableIdentifier = @"cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                         SimpleTableIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier: SimpleTableIdentifier];
                }
                cell.textLabel.text =[NSString stringWithFormat:@"开票方：%@",_goodsModel.kpName];
                cell.textLabel.textColor =[UIColor redColor];
                cell.textLabel.font =DR_FONT(13);
                
                return cell;
                
            }
                break;
            case 2:
                
            {
                FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstTableViewCell"];
                cell.goodsModel =self.goodsModel;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }
                break;
            case 3:
                
            {
                CatgoryDetailCell *cell =[CatgoryDetailCell cellWithTableView:tableView];
                cell.goodsModel =self.goodsModel;
                if (self.goodsModel.favariteId.length==0)
                {
                    cell.shoucangBtn.selected =NO;
                }
                else
                {
                    cell.shoucangBtn.selected =YES;
                }
                cell.shoucangBlock = ^(NSInteger shoucangtag) {
                    NSDictionary *dic =@{@"id":self.goodsModel.favariteId};
                    //111   @"favariteId" : @"2338F0C13F834B14831F9E17E4A605F5"
                   // [105]    (null)    @"favariteId" : @"7AEF5F58A01448428BE5B066C065BD6F"
                    //[105]    (null)    @"favariteId" : @"A87394C2156F4987A5C6A90940986850"    
                    [SNIOTTool deleteWithURL:@"buyer/cancelItemFavorite" parameters:[dic mutableCopy] success:^(SNResult *result) {
                        [MBProgressHUD showSuccess:result.data];
                        [self.tableView.mj_header beginRefreshing];
                        
                    } failure:^(NSError *error) {
                        
                    }];
                    
                };
                cell.shopCarBlock = ^(NSInteger shopCartag) {
                    //                    [SNAPI postWithURL:urlStr parameters:mudic success:^(SNResult *result) {
                    //                        if (result.state==200) {
                    //                            NSLog(@"result=%@",result.data);
                    //
                    //
                    //                            //                                [self.tableView reloadData];
                    //                        }
                    //                    } failure:^(NSError *error) {
                    //
                    //                    }];
                };
                return cell;
            }
                break;
                
                
            default:
                break;
        }
    }
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    cell.textLabel.text = [_titleStr stringByAppendingString:[NSString stringWithFormat:@"-%d",(int)indexPath.row]];
    return cell;
    
}
@end
