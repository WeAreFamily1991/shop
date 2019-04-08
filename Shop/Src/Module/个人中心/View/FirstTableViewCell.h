//
//  FirstTableViewCell.h
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FirstTableViewCell : UITableViewCell
{
    float Height;
}
@property(nonatomic,strong)UIImageView *productImg;  ///<产品图片
@property(nonatomic,strong)UILabel *productName;     ///<产品名称
@property(nonatomic,strong)UIView *standardView;     ///<规格
@property(nonatomic,strong)UILabel *parameterLabel;  ///<产品参数
@property(nonatomic,strong)UILabel *cellLabel;       ///<销售单位
@property(nonatomic,strong)UILabel *countLabel;      ///<库存

@property (nonatomic,retain)GoodsModel *goodsModel;
@end

NS_ASSUME_NONNULL_END
