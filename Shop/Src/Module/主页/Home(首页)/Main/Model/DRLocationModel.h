//
//  DRLocationModel.h
//  Shop
//
//  Created by BWJ on 2019/5/14.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRLocationModel : DRBaseModel
@property (nonatomic , copy) NSString              * compId;
@property (nonatomic , copy) NSString              * storeTitle;
@property (nonatomic , copy) NSString              * compName;
@property (nonatomic , copy) NSString              * favoriteId;
@property (nonatomic , copy) NSString              * compLog;
@property (nonatomic , copy) NSString              * isSendVoucher;
@property (nonatomic , copy) NSString              * storeImg;
@property (nonatomic , copy) NSString              * compAddr;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * storePrdt;

@end

NS_ASSUME_NONNULL_END
