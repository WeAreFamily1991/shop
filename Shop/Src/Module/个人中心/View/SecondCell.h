//
//  SecondCell.h
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondCell : UITableViewCell
{
    float Height;
}
@property(nonatomic,strong)UIImageView *productImg;  ///<产品图片
@property(nonatomic,strong)UIButton *moreBtn;  ///<展示更多
@property(nonatomic,strong)UILabel *productName;     ///<产品名称
@property(nonatomic,strong)UIView *standardView;     ///<规格
@property(nonatomic,strong)UILabel *parameterLabel;  ///<产品参数
@property(nonatomic,strong)UILabel *cellLabel;       ///<销售单位
@property(nonatomic,strong)UILabel *countLabel;      ///<库存
@property(nonatomic,strong)NSDictionary *dataDict;
@end

NS_ASSUME_NONNULL_END
