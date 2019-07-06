//
//  DRSameModel.h
//  Shop
//
//  Created by BWJ on 2019/5/10.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Items;
@interface DRSameModel : DRBaseModel
@property (nonatomic , copy) NSString              * unit1;
@property (nonatomic , copy) NSString              * sellerTypeCode;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , assign) NSInteger              payMothed;
@property (nonatomic , assign) NSInteger              isLogistics;
@property (nonatomic , assign) CGFloat              level2_price;
@property (nonatomic , copy) NSString              * compLog;
@property (nonatomic , assign) NSInteger              isSendVoucher;
@property (nonatomic , copy) NSString              * toothdistancecode;
@property (nonatomic , copy) NSString              * discountId;
@property (nonatomic , copy) NSString              * standardid;
@property (nonatomic , copy) NSString              * materialcode;
@property (nonatomic , assign) NSInteger              buyNum;
@property (nonatomic , copy) NSString              * arrivalTime;
@property (nonatomic , copy) NSString              * levelname;
@property (nonatomic , copy) NSString              * kfPhone;
@property (nonatomic , copy) NSString              *unitconversion4;
@property (nonatomic , copy) NSString              * ptypeid;
@property (nonatomic , copy) NSString              * buyerId;
@property (nonatomic , copy) NSString              * countPiece;
@property (nonatomic , copy) NSString              * unitPiece;
@property (nonatomic , copy) NSString              * lengthcode;
@property (nonatomic , copy) NSString              * unit2;
@property (nonatomic , copy) NSString              * itemUnit;
@property (nonatomic , copy) NSString              * diametername;
@property (nonatomic , copy) NSString              * erpcode;
@property (nonatomic , copy) NSString              * unitname1;
@property (nonatomic , copy) NSString              * brandname;
@property (nonatomic , copy) NSString              * ktypeid;
@property (nonatomic , copy) NSString              * limitType;
@property (nonatomic , copy) NSString              * unitname2;
@property (nonatomic , copy) NSString              * days;
@property (nonatomic , copy) NSString              * serviceType;
@property (nonatomic , copy) NSString              * itemcode;
@property (nonatomic , copy) NSString              * storeName;
@property (nonatomic , copy) NSString              * areaId;
@property (nonatomic , copy) NSString              * stock;
@property (nonatomic , assign) NSInteger              discounttype;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * unitname3;
@property (nonatomic , copy) NSString              * itemname;
@property (nonatomic , assign) NSInteger              authstatus;
@property (nonatomic , copy) NSString              * compName;
@property (nonatomic , copy) NSString              * unit3;
@property (nonatomic , copy) NSString              * lengthname;
@property (nonatomic , copy) NSString              * branchId;
@property (nonatomic , copy) NSString              * unitname4;
@property (nonatomic , copy) NSString              * allSaleCount;
@property (nonatomic , copy) NSString              * toothformcode;
@property (nonatomic , copy) NSString              * isstock;
@property (nonatomic , copy) NSString              * unitname5;
@property (nonatomic , assign) CGFloat              level_price;
@property (nonatomic , copy) NSString              * toothdistancename;
@property (nonatomic , copy) NSString              * surfacecode;
@property (nonatomic , copy) NSString              * materialid;
@property (nonatomic , copy) NSString              * unit4;
@property (nonatomic , assign) CGFloat              qty;
@property (nonatomic ,  copy) NSString              *unitconversion1;
@property (nonatomic , copy) NSString              * surfaceid;
@property (nonatomic , copy) NSString              * basicunitname;
@property (nonatomic , copy) NSString              * condition1;
@property (nonatomic , assign) NSInteger              deliveryDay;
@property (nonatomic , copy) NSString              * storeId;
@property (nonatomic , copy) NSString              * levelid;
@property (nonatomic , copy) NSString              * pmid;
@property (nonatomic , copy) NSString              * sellerType;
@property (nonatomic , copy) NSString              * diameterid;
@property (nonatomic , copy) NSString              * unit5;
@property (nonatomic , copy) NSString              * standardname;
@property (nonatomic ,  copy) NSString              *unitconversion3;
@property (nonatomic , copy) NSString              * condition2;
@property (nonatomic , assign) CGFloat              stMoq;
@property (nonatomic , assign) NSInteger              sellerPayMethod;
@property (nonatomic , copy) NSString              * toothformid;
@property (nonatomic , copy) NSString              * drawing;
@property (nonatomic , copy) NSString              * materialname;
@property (nonatomic , assign) CGFloat              userprice;
@property (nonatomic , copy) NSString              * diametercode;
@property (nonatomic , copy) NSString              * condition3;
@property (nonatomic , copy) NSString              * userprice_o;
@property (nonatomic , copy) NSString              * unitconversion5;
@property (nonatomic , assign) NSInteger              priceType;
@property (nonatomic , assign) NSInteger              burstCount;
@property (nonatomic , copy) NSString              * levelcode;
@property (nonatomic , copy) NSString              * burstType;
@property (nonatomic , copy) NSString              * kpName;
@property (nonatomic , copy) NSString              * ibpid;
@property (nonatomic , copy) NSString              * saledCount;
@property (nonatomic , assign) CGFloat              zfMoq;
@property (nonatomic , copy) NSString              * toothformname;
@property (nonatomic , copy) NSString              * payType;
@property (nonatomic , copy) NSString              * itemUnitConversion;
@property (nonatomic , copy) NSString              * isHy;
@property (nonatomic , copy) NSString              * basicunitid;
@property (nonatomic , copy) NSString              * discount1;
@property (nonatomic , assign) CGFloat              minquantity;
@property (nonatomic , assign) NSInteger              isZf;
@property (nonatomic , copy) NSString              * discount2;
@property (nonatomic , copy) NSString              * brandcode;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) CGFloat              allowbuycount;
@property (nonatomic , copy) NSString              * saleunitid;
@property (nonatomic , copy) NSString              * storeCode;
@property (nonatomic , copy) NSString              * discount3;
@property (nonatomic , copy) NSString              * saleunitname;
@property (nonatomic , copy) NSString              * weight1000;
@property (nonatomic , copy) NSString              * brandid;
@property (nonatomic , copy) NSString              * leftCount;
@property (nonatomic , copy) NSString              * lengthid;
@property (nonatomic , copy) NSString              * imgurl;
@property (nonatomic , copy) NSString              * imgUrlM;
@property (nonatomic , copy) NSString              * favariteId;
@property (nonatomic , copy) NSString              * sellerTypeKeyCode;
@property (nonatomic , assign) CGFloat              discountvalue;
@property (nonatomic , copy) NSString              * bid;
@property (nonatomic , copy) NSString              * toothdistanceid;
@property (nonatomic , assign) CGFloat              bidPrice;
@property (nonatomic , copy) NSString              * btypeid;
@property (nonatomic , assign) CGFloat              saleunitconversion;
@property (nonatomic , copy) NSString              * sameID;
@property (nonatomic , copy) NSString              *unitconversion2;
@property (nonatomic , copy) NSString              * pid;
@property (nonatomic , copy) NSString              * sellerid;
@property (nonatomic , copy) NSString              * standardcode;
@property (nonatomic , copy) NSString              * surfacename;
@end

NS_ASSUME_NONNULL_END
