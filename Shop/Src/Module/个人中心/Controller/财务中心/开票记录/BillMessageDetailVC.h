//
//  BillMessageDetailVC.h
//  Shop
//
//  Created by BWJ on 2019/2/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillMessageDetailVC : UIViewController
@property(nonatomic,assign)NSInteger status;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@end

NS_ASSUME_NONNULL_END
