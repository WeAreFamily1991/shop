//
//  CategoryDetailVC.h
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryDetailVC : UIViewController
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (strong,nonatomic)  NSString *classListStr,*czID;
@end

NS_ASSUME_NONNULL_END
