//
//  DRLocationCell.h
//  Shop
//
//  Created by BWJ on 2019/4/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRLocationModel;
NS_ASSUME_NONNULL_BEGIN

@interface DRLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIMG;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *modelLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (nonatomic,retain)DRLocationModel *locationModel;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@end

NS_ASSUME_NONNULL_END
