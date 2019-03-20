//
//  CollectionCell.h
//  Shop
//
//  Created by BWJ on 2019/2/25.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UIButton *tagLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *collectSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (copy,nonatomic) void (^phoneBlock) (NSInteger phonetag);
@property (copy,nonatomic) void (^collectionSelectBlock) (NSInteger collectionSelectag);
@end



@interface CollectionCell1 : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;
@end


@interface CollectionCell2 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end


@interface CollectionCell3 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end


@interface CollectionCell4 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *saleOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBuyBtn;
@property (weak, nonatomic) IBOutlet UIButton *detailOrderBtn;
@property (copy,nonatomic) void (^BtnBlock) (NSInteger btnag);
@property(nonatomic,assign)NSInteger status;
@end

@interface CollectionCell5 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface CollectionCell6 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface CollectionCell7 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
NS_ASSUME_NONNULL_END
