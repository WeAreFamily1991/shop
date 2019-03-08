//
//  ChildCell.m
//  Shop
//
//  Created by BWJ on 2019/3/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChildCell.h"

@implementation ChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"ChildCell";
    
    ChildCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"ChildCell" owner:nil options:nil] firstObject];
    }
    cell.editBtn.layer.borderWidth =1;
    cell.editBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    cell.editBtn.layer.cornerRadius=5;
    cell.editBtn.layer.masksToBounds =5;
    cell.startBtn.layer.borderWidth =1;
    cell.startBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    cell.startBtn.layer.cornerRadius=5;
    cell.startBtn.layer.masksToBounds =5;
    cell.cancelBtn.layer.borderWidth =1;
    cell.cancelBtn.layer.borderColor =[UIColor lightGrayColor].CGColor;
    cell.cancelBtn.layer.cornerRadius=5;
    cell.cancelBtn.layer.masksToBounds =5;
    
    return cell;
}

@end
