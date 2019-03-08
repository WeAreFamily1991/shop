//
//  CatgoryDetailCell.h
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface CatgoryDetailCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceAccountLab;

@property (copy,nonatomic) void (^shoucangBlock) (NSInteger shoucangtag);
@property (copy,nonatomic) void (^shopCarBlock) (NSInteger shopCartag);
@end


@interface CatgoryDetailCell1 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIButton *danweiBtn;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;
@property (copy,nonatomic) void (^danweiBtnBlock) (NSInteger danweiBtntag);

@end


NS_ASSUME_NONNULL_END
