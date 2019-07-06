//
//  DCRecommendItem.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCRecommendItem : DRBaseModel

/** 图片URL */
@property (nonatomic, copy ,readonly) NSString *image_url;
/** 商品标题 */
@property (nonatomic, copy ,readonly) NSString *main_title;
/** 商品小标题 */
@property (nonatomic, copy ,readonly) NSString *goods_title;
/** 商品价格 */
@property (nonatomic, copy ,readonly) NSString *price;
/** 剩余 */
@property (nonatomic, copy ,readonly) NSString *stock;
/** 属性 */
@property (nonatomic, copy ,readonly) NSString *nature;

/* 头部轮播 */
@property (copy , nonatomic , readonly)NSArray *images;

@property (nonatomic , assign) NSInteger              sortId;
@property (nonatomic , assign) NSInteger              isShow;
@property (nonatomic , copy) NSString              * shopNewID;
@property (nonatomic , copy) NSString              * recommend;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * qCondition;


@property (nonatomic , assign) CGFloat              qtyPercent;
@property (nonatomic , copy) NSString              * materialname;
@property (nonatomic , assign) CGFloat              bidprice;
@property (nonatomic , assign) CGFloat              zfprice;
@property (nonatomic , copy) NSString              * itemparamid;
@property (nonatomic , copy) NSString              * sortID;
@property (nonatomic , copy) NSString              * standardname;
@property (nonatomic , copy) NSString              * basicunitid;
@property (nonatomic , copy) NSString              * itemcode;
@property (nonatomic , copy) NSString              * complog;
@property (nonatomic , assign) CGFloat              totalAmt;
@property (nonatomic , copy) NSString              * lengthname;
@property (nonatomic , copy) NSString              * bursttype;
@property (nonatomic , copy) NSString              * createtime;
@property (nonatomic , copy) NSString              * itemid;
@property (nonatomic , copy) NSString              * toothdistanceid;
@property (nonatomic , assign) NSInteger              islogistics;
@property (nonatomic , copy) NSString              * diametername;
@property (nonatomic , copy) NSString              * sellername;
@property (nonatomic , copy) NSString              * levelid;
@property (nonatomic , copy) NSString              * brandname;
@property (nonatomic , copy) NSString              * basicunitname;
@property (nonatomic , copy) NSString              * bhtid;
@property (nonatomic , assign) CGFloat              stprice;
@property (nonatomic , copy) NSString              * updatename;
@property (nonatomic , copy) NSString              * standardid;
@property (nonatomic , copy) NSString              * levelname;
@property (nonatomic , copy) NSString              * diameterid;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * areaname;
@property (nonatomic , copy) NSString              * itemname;
@property (nonatomic , copy) NSString              * ibssId;
@property (nonatomic , copy) NSString              * toothdistancename;
@property (nonatomic , copy) NSString              * surfaceid;
@property (nonatomic , assign) NSInteger              iszf;
@property (nonatomic , copy) NSString              * createname;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , assign) CGFloat              userprice;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * lengthid;
@property (nonatomic , copy) NSString              * sellerid;
@property (nonatomic , copy) NSString              * sortnum;
@property (nonatomic , copy) NSString              * updatetime;
@property (nonatomic , copy) NSString              * surfacename;
@property (nonatomic , copy) NSString              * brandid;
@property (nonatomic , copy) NSString              * materialid;
@property (nonatomic , copy) NSString              * imgm;
@property (nonatomic , copy) NSString              * areaid;
@property (nonatomic , copy) NSString              *factoryArea;

@end
