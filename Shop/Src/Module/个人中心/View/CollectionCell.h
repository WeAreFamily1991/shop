//
//  CollectionCell.h
//  Shop
//
//  Created by BWJ on 2019/2/25.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "OrderModel.h"
#import "AskSellOutModel.h"
@class VoucherModel;
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
@property (nonatomic,retain)FavoriteModel *favoriModel;
@property (copy,nonatomic) void (^collectionSelectBlock) (NSInteger collectionSelectag);
@end



@interface CollectionCell1 : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,retain)VoucherModel *vouchModel;
@property (weak, nonatomic) IBOutlet UIImageView *iconBackIMG;
@property (weak, nonatomic) IBOutlet UILabel *moneyCountLab;
@property (weak, nonatomic) IBOutlet UILabel *manjianLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *hidenBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (nonatomic, copy) dispatch_block_t selectlickBlock;

@end


@interface CollectionCell2 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *orderLAb;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLAb;
@property (weak, nonatomic) IBOutlet UIButton *santieBtn;
@property (weak, nonatomic) IBOutlet UILabel *cangkeLab;
@property (weak, nonatomic) IBOutlet UIButton *tellBtn;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *peisongLab;
@property (nonatomic,retain)OrderModel *orderModel;

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
@property (weak, nonatomic) IBOutlet UILabel *allPriceCountLab;
@property (copy,nonatomic) void (^BtnBlock) (NSInteger btnag);
@property(nonatomic,assign)NSInteger status;
@property (nonatomic,retain)OrderModel *orderModel;
@end

@interface CollectionCell5 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *dianpubTN;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
@property (weak, nonatomic) IBOutlet UIButton *tellBtn;
@property (nonatomic, copy) dispatch_block_t selectlickBlock;
@property (nonatomic,retain)GoodsModel *goodsModel;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface CollectionCell6 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface CollectionCell7 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *santieBtn;
@property (weak, nonatomic) IBOutlet UILabel *cangkeLab;
@property (weak, nonatomic) IBOutlet UIButton *tellBtn;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *peisongLab;
@property (nonatomic,retain)OrderModel *orderModel;
@end

@interface CollectionCell8 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *santieBtn;
@property (weak, nonatomic) IBOutlet UILabel *cangkeLab;
@property (weak, nonatomic) IBOutlet UIButton *tellBtn;
@property (nonatomic,retain)AskSellOutModel *sellOutModel;
@end
NS_ASSUME_NONNULL_END
