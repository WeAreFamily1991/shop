//
//  CustomAlertView.m
//  Shop
//
//  Created by BWJ on 2019/4/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CustomAlertView.h"
#import "CGXPickerView.h"
@interface CustomAlertView ()<NumberCalculateDelegate>
@property (nonatomic,strong)NSMutableArray *selectNameArr,*selectCodeArr,*selectIDArr;

@end
@implementation CustomAlertView



-(void)setUI
{
    self.canshuBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
     self.canshuBtn.layer.borderWidth =1;
   self.danweiTF.layer.borderWidth =1;
    [self.danweiTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];//
    self.danweiTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    self.phoneTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    self.phoneTF.layer.borderWidth =1;
//    if (self.fiveBtn.tag==1) {
//        [self buttonBtnClick:self.fiveBtn];
//    }
//    [self.fiveBtn addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//     [self.fifthBtn addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//     [self.thirtyBtn addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//     [self.fiveBtn addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews
{
     [self setUI];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    self.numbeiTF.delegate =self;
    self.numbeiTF.baseNum=@"1";
    self.numbeiTF.minNum =1;
 
    _goodsModel =goodsModel;
   //basicunitid 5千支  6公斤  7吨
    if ([_goodsModel.basicunitid intValue]==5) {
        self.baseStr =@"千支";
    }
    if ([_goodsModel.basicunitid intValue]==6) {
        self.baseStr =@"公斤";
    }
    if ([_goodsModel.basicunitid intValue]==7) {
        self.baseStr =@"吨";
    }
    self.danweiLab.text =self.baseStr;
  
    self.selectNameArr =[NSMutableArray array];
    self.selectCodeArr=[NSMutableArray array];
     NSString *nameStr;
    if (self.goodsModel.unitconversion1.length!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodsModel.unitconversion1 doubleValue],_baseStr,goodsModel.unitname1];
        [self.selectNameArr addObject:self.goodsModel.unitname1];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion1];
        [self.selectIDArr addObject:self.goodsModel.unit1];
        if (!self.selectcode) {
            self.selectcode =[self.goodsModel.unitconversion1 doubleValue];
            self.selectName =self.goodsModel.unitname1;
            self.selectID =self.goodsModel.unit1;
            
        }
    }
    
    if (self.goodsModel.unitconversion2.length!=0) {
        
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion2 doubleValue],_baseStr,goodsModel.unitname2];
        [self.selectNameArr addObject:self.goodsModel.unitname2];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion2];
        [self.selectIDArr addObject:self.goodsModel.unit2];
        if (!self.selectcode) {
            
            self.selectcode =[self.goodsModel.unitconversion2 doubleValue];
            self.selectName =self.goodsModel.unitname2;
            self.selectID =self.goodsModel.unit2;
        }
        
    }
    if (self.goodsModel.unitconversion3.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion3 doubleValue],_baseStr,goodsModel.unitname3];
        [self.selectNameArr addObject:self.goodsModel.unitname3];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion3];
        [self.selectIDArr addObject:self.goodsModel.unit3];
        if (!self.selectcode) {
            
            self.selectcode =[self.goodsModel.unitconversion3 doubleValue];
            self.selectName =self.goodsModel.unitname3;
            self.selectID =self.goodsModel.unit3;
        }
        
    }
    if (self.goodsModel.unitconversion4.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion4 doubleValue],_baseStr,goodsModel.unitname4];
        [self.selectNameArr addObject:self.goodsModel.unitname4];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion4];
        [self.selectIDArr addObject:self.goodsModel.unit4];
        if (!self.selectcode) {
            
            self.selectcode =[self.goodsModel.unitconversion4 doubleValue];
            self.selectName =self.goodsModel.unitname4;
            self.selectID =self.goodsModel.unit4;
        }
        
        
    }
    if (self.goodsModel.unitconversion5.length!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion5 doubleValue],_baseStr,goodsModel.unitname5];
        [self.selectNameArr addObject:self.goodsModel.unitname5];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion5];
        [self.selectIDArr addObject:self.goodsModel.unit5];
        if (!self.selectcode) {
            
            self.selectcode =[self.goodsModel.unitconversion5 doubleValue];
            self.selectName =self.goodsModel.unitname5;
            self.selectID =self.goodsModel.unit5;
        }
    }
   
   
    
    self.bzcsLab.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
    [self.canshuBtn setTitle:self.selectName forState:UIControlStateNormal];
    self.countNumStr = self.numbeiTF.baseNum ;
    self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    self.sjchlLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.countNumStr intValue]*self.selectcode];
  
    
}





-(void)danweiBtnClick:(UIButton *)sender
{
   
}

- (void)resultNumber:(NSString *)number{
    //    self.numberCalculate =number;
    self.countNumStr =number;
    self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    self.sjchlLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.countNumStr intValue]*self.selectcode];
  
    self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.danweiTF.text doubleValue]/self.selectcode)];
    NSLog(@"%@>>>resultDelegate>>",number);
//    if ([self.danweiTF.text doubleValue]>=[self.goodsModel.qty doubleValue]) {
//        self.danweiTF.text =self.goodsModel.qty;
//        self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.goodsModel.qty intValue]/self.selectcode)];
//        self.countNumStr =self.numbeiTF.baseNum;
//    }
    
}
-(void)textChange:(UITextField *)textField
{
    if (textField.text.length>11) {
        self.danweiTF.text = [self.danweiTF.text substringToIndex:11];
    }
    
    self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([textField.text intValue]/self.selectcode)];
    if (ceil([textField.text intValue]/self.selectcode)<1&&textField.text.length!=0) {
        self.numbeiTF.baseNum =@"1";
    }
    
    NSLog(@"baseNum=%@quzheng%lf text==%d",self.numbeiTF.baseNum,ceil([textField.text intValue]/self.selectcode),[textField.text intValue]);
//    if ([textField.text doubleValue]>=[_goodsModel.qty doubleValue]) {
//        self.danweiTF.text =_goodsModel.qty;
//        self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([_goodsModel.qty intValue]/self.selectcode)];
//        self.countNumStr =self.numbeiTF.baseNum;
//    }
    self.sjchlLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[textField.text floatValue]];   
}
-(BOOL)judgeStr:(NSString *)str1 with:(NSString *)str2

{
    
    int a=[str1 intValue];
    
    double s1=[str2 doubleValue];
    
    int s2=[str2 intValue];
    
    
    
    if (s1/a-s2/a>0) {
        
        return NO;
        
    }
    
    return YES;
    
}

- (IBAction)timeBtnClick:(id )sender {
    UIButton *button =(UIButton *)sender ;
    self.currentSelectedBtn.selected = NO ;
    button.selected = YES ;
    self.currentSelectedBtn = button ;
    
    NSLog(@"点击 %ld",button.tag) ;
    self.selectBtnTag =button.tag;
}
- (IBAction)selectBtnClick:(id)sender {
    [CGXPickerView showStringPickerWithTitle:@"单位" DataSource:self.selectNameArr DefaultSelValue:@"袋" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        self.selectcode =[[self.selectCodeArr objectAtIndex:[selectRow intValue]] doubleValue];
        self.selectID =[self.selectIDArr objectAtIndex:[selectRow intValue]];
        [self.canshuBtn setTitle:selectValue forState:UIControlStateNormal];
        NSLog(@"%@",selectValue);
       
        if (self.countNumStr.length!=0&&self.danweiTF.text.length!=0) {
            self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
             self.sjchlLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.countNumStr intValue]*self.selectcode];
           
            self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.danweiTF.text doubleValue]/self.selectcode)];
             
//            if ([self.danweiTF.text doubleValue]>=[self.goodsModel.qty doubleValue]) {
//                self.danweiTF.text =self.goodsModel.qty;
//                self.numbeiTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.goodsModel.qty intValue]/self.selectcode)];
//                self.countNumStr =self.numbeiTF.baseNum;
//            }
        }
        
    }];
}

- (IBAction)closeBtnClick:(id)sender {
    !_closeclickBlock?:_closeclickBlock();
}
- (IBAction)sureBtn:(id)sender {
    !_sureclickBlock?:_sureclickBlock();
}

@end
