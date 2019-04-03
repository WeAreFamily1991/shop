//
//  GoodsCell.h
//  Shop
//
//  Created by BWJ on 2019/4/2.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodsCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *cangkuLab;
@property (weak, nonatomic) IBOutlet UIButton *ziyingBtn;
@property (weak, nonatomic) IBOutlet UILabel *ziyingpeisongLab;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UILabel *kaipiaoLab;
@property (weak, nonatomic) IBOutlet UILabel *jiesuanLab;
@property (nonatomic, copy) dispatch_block_t selectlickBlock;
@property (nonatomic,retain)GoodsModel *goodsModel;
@end

NS_ASSUME_NONNULL_END
