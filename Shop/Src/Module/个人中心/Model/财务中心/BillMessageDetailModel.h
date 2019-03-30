//
//  BillMessageDetailModel.h
//  Shop
//
//  Created by BWJ on 2019/3/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailListModel;
NS_ASSUME_NONNULL_BEGIN

@interface BillMessageDetailModel : NSObject
@property (nonatomic , copy) NSString              * checkUserId;
@property (nonatomic , copy) NSString              * invoiceType;
@property (nonatomic , copy) NSString              * fpParty;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * checkTime;
@property (nonatomic , copy) NSString              * checkUser;
@property (nonatomic , copy) NSString              * applyeTime;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * invoiceAddress;
@property (nonatomic , copy) NSString              * receiverAddress;
@property (nonatomic , copy) NSString              * invoiceNo;
@property (nonatomic , copy) NSString              * detail_id;
@property (nonatomic , copy) NSString              * applyNo;
@property (nonatomic , assign) CGFloat              invoiceAmt;
@property (nonatomic , copy) NSString              * invoiceTel;
@property (nonatomic , copy) NSString              * receiverPhone;
@property (nonatomic , copy) NSString              * receiverName;
@property (nonatomic , copy) NSString              * expressNo;
@property (nonatomic , copy) NSString              * rejectReason;
@property (nonatomic , copy) NSString              * taxNo;
@property (nonatomic , copy) NSString              * buyerId;
@property (nonatomic , copy) NSString              * fpSellerId;
@property (nonatomic , copy) NSString              * bankName;
@property (nonatomic , copy) NSString              * bankAccount;
@property (nonatomic , copy) NSString              * expressComp;
@property (nonatomic , copy) NSString              * fpPartyName;
@property (nonatomic , copy) NSMutableArray<DetailListModel *>   * list;
@end


@interface DetailListModel : NSObject
@property (nonatomic , copy) NSString              * list_id;
@property (nonatomic , assign) CGFloat              totalAmt;
@property (nonatomic , copy) NSString              * storeTitle;
@property (nonatomic , assign) CGFloat              returnedAmt;
@property (nonatomic , assign) CGFloat              totalQty;
@property (nonatomic , assign) NSInteger              billDate;
@property (nonatomic , copy) NSString              * billType;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * compId;
@property (nonatomic , assign) CGFloat              realAmt;
@property (nonatomic , copy) NSString              * applyId;
@property (nonatomic , copy) NSString              * compName;
@property (nonatomic , assign) CGFloat              canReturnAmt;

@end
NS_ASSUME_NONNULL_END
