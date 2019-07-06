
//
//  SellAfterFooterView.m
//  Shop
//
//  Created by BWJ on 2019/5/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SellAfterFooterView.h"

@implementation SellAfterFooterView
- (IBAction)subMitBtnClick:(id)sender {
     !_submitBtnBlock ? :_submitBtnBlock();
}
- (IBAction)cancelBtnCick:(id)sender {
     !_cancelBtnBlock ? :_cancelBtnBlock();
}
-(void)layoutSubviews
{
    
    self.submitBtn.layer.cornerRadius =self.submitBtn.dc_height/2;
    self.submitBtn.layer.masksToBounds =self.submitBtn.dc_height/2;
    self.cancelBtn.layer.cornerRadius =self.cancelBtn.dc_height/2;
    self.cancelBtn.layer.masksToBounds =self.cancelBtn.dc_height/2;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
