//
//  CatgoryDetailCell.h
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberCalculate.h"
#import "GoodsModel.h"
//@class CarDetailModel;

NS_ASSUME_NONNULL_BEGIN


@interface CatgoryDetailCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceAccountLab;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (copy,nonatomic) void (^shoucangBlock) (NSInteger shoucangtag);
@property (copy,nonatomic) void (^shopCarBlock) (NSInteger shopCartag);
@end

@protocol CatgoryDetailCellSelectDelegate <NSObject>
/** 增减数量按钮点击事件 */
- (void)changeShopCount:(UIButton *)sender;
/** 手动输入数量 */
- (void)tableViewScroll:(UITextField *)textField;

@end
@interface CatgoryDetailCell1 : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath;
//@property (nonatomic, strong) CarDetailModel *goodsModel;
//@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIButton *danweiBtn;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;
//@property (weak, nonatomic) IBOutlet UIButton *addCountBtn;
//@property (weak, nonatomic) IBOutlet UITextField *selectCountTF;
//@property (weak, nonatomic) IBOutlet UIButton *cutCountBtn;
@property (weak, nonatomic) IBOutlet NumberCalculate *numberCalculate;
@property (copy,nonatomic) void (^danweiBtnBlock) (NSInteger danweiBtntag);
@property (nonatomic, weak) id<CatgoryDetailCellSelectDelegate>delegate;
@property (nonatomic,retain)GoodsModel *goodsModel;
@end

NS_ASSUME_NONNULL_END
