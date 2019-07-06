//
//  DRAddShopView.m
//  Shop
//
//  Created by BWJ on 2019/4/11.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRAddShopView.h"
#import "CGXPickerView.h"
@implementation DRAddShopView
+ (DRAddShopView *)getDRAddShopView
{
    DRAddShopView *AddshopView = [[[NSBundle mainBundle]loadNibNamed:@"DRAddShopView" owner:self options:nil] firstObject];
    AddshopView.frame =CGRectMake(0, 0, ScreenW, ScreenH);
    
    return AddshopView;
}

-(void)setUI
{
    self.itemListArr =[NSArray array];
    self.itemListArr =[ItemsModel mj_objectArrayWithKeyValuesArray:self.addshopModel.items];
    self.selectBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    self.selectBtn.layer.borderWidth =1;
    self.danweiTF.layer.borderWidth =1;
    [self.danweiTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];//
    self.danweiTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    self.numberTF.baseNum =@"1";
    self.numberTF.minNum =1;
    _upScrollView = [[UIScrollView alloc]initWithFrame:self.bACKvIEW.bounds];
    _upScrollView.showsHorizontalScrollIndicator = NO;
    _upScrollView.contentSize = CGSizeMake(1.3*ScreenW, _upScrollView.frame.size.height);
    if (self.itemListArr.count<3) {
        
        _upScrollView.showsVerticalScrollIndicator = NO;
        _upScrollView.contentSize = CGSizeMake(ScreenW, _upScrollView.frame.size.height);
    }
    [self.bACKvIEW addSubview:_upScrollView];
   
    
    CGFloat btnW = (ScreenW - 60) / 2.5;
    
    for (NSInteger i = 0; i < self.itemListArr.count; i++) {
        ItemsModel *itemModel =self.itemListArr[i];
        UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(15*(i+1)+btnW*i, 50-btnW/4, btnW, btnW/2)];
        [self.upScrollView addSubview:titleView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        button.titleLabel.font = DR_FONT(12);
        button.titleLabel.numberOfLines = 0;
        NSString *titleStr;
       
        if ([itemModel.serviceType isEqualToString:@"st"]) {
            titleStr =@"(三铁配送)";
        }
        else if ([itemModel.serviceType isEqualToString:@"wl"]) {
            titleStr =@"(物流配送)";
        }
        else if ([itemModel.serviceType isEqualToString:@"zf"]) {
            titleStr =@"(卖家直发)";
        }
       
        NSString *nameStr =[NSString stringWithFormat:@"%@%@",[itemModel.payType boolValue]?@"月结":@"现金",titleStr];
        
        NSString *bottomStr= [NSString stringWithFormat:@"￥%.3f/%@",itemModel.price,self.baseStr];
    
        [button setTitle:[NSString stringWithFormat:@"%@\n%@",nameStr,bottomStr] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"normel_BACK"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"select_back"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.frame = titleView.bounds;
        button.tag =i+100;
        if (i==0) {
            [self buttonBtnClick:button];
        }
        [button addTarget:self action:@selector(buttonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    
}
-(void)buttonBtnClick:(UIButton *)sender
{
    self.currentSelectedBtn.selected = NO ;
    sender.selected = YES ;
    self.currentSelectedBtn = sender ;
    self.selectBtnTag =sender.tag;
    NSLog(@"点击 %ld",sender.tag) ;
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
    [super layoutSubviews];
    [self setUI];
}
-(void)setAddshopModel:(DRAddShopModel *)addshopModel
{
    _addshopModel =addshopModel;
    
    self.santieMoneyLab.text =[NSString stringWithFormat:@"三铁配送起订金额(元)：%.3f",addshopModel.stMoq];
    self.otherMoneyLab.text =[NSString stringWithFormat:@"卖家直发起订金额(元)：%.3f",addshopModel.zfMoq];
    
    
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    self.numberTF.delegate =self;
    self.numberTF.baseNum=@"1";
    self.numberTF.minNum =1;
    if ([goodsModel.deliveryDay intValue]==0) {        
        self.timeLab.text =@"预计发货时间：当天发货";
    }else if ([goodsModel.deliveryDay intValue]==1)
    {
        self.timeLab.text =@"预计发货时间：明天发货";
    }
    else if ([goodsModel.deliveryDay intValue]==2)
    {
        self.timeLab.text =@"预计发货时间：后天发货";
    }
    else
    {
        self.timeLab.text =[NSString stringWithFormat:@"预计发货时间(天)：%@",goodsModel.deliveryDay];
    }
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
    self.qtyLab.text =[NSString stringWithFormat:@"当前库存数(%@)：%@",self.baseStr,goodsModel.qty];
    self.selectNameArr =[NSMutableArray array];
    self.selectCodeArr=[NSMutableArray array];
    self.selectIDArr=[NSMutableArray array];
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
    self.BZCSlAB.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];    
    [self.selectBtn setTitle:self.selectName forState:UIControlStateNormal];
    self.countNumStr = self.numberTF.baseNum ;
    self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.danweiTF.text doubleValue]];
}
-(void)danweiBtnClick:(UIButton *)sender
{
    
}
- (void)resultNumber:(NSString *)number{
    //    self.numberCalculate =number;
    self.countNumStr =number;
    self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.danweiTF.text doubleValue]];
    
    self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.danweiTF.text doubleValue]/self.selectcode)];
    NSLog(@"%@>>>resultDelegate>>",number);
    if ([self.danweiTF.text doubleValue]>=[self.goodsModel.qty doubleValue]) {
        self.danweiTF.text =self.goodsModel.qty;
        self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.danweiTF.text doubleValue]];
        self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.goodsModel.qty intValue]/self.selectcode)];
        self.countNumStr =self.numberTF.baseNum;
    }
    
}
-(void)textChange:(UITextField *)textField
{
    if (textField.text.length>11) {
        self.danweiTF.text = [self.danweiTF.text substringToIndex:11];
    }
    
    self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([textField.text intValue]/self.selectcode)];
    if (ceil([textField.text intValue]/self.selectcode)<1&&textField.text.length!=0) {
        self.numberTF.baseNum =@"1";
    }
    self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[textField.text floatValue]];
    NSLog(@"baseNum=%@quzheng%lf text==%d",self.numberTF.baseNum,ceil([textField.text intValue]/self.selectcode),[textField.text intValue]);
        if ([textField.text doubleValue]>=[_goodsModel.qty doubleValue]) {
            self.danweiTF.text =_goodsModel.qty;
            self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[_goodsModel.qty doubleValue]];
            self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([_goodsModel.qty intValue]/self.selectcode)];
            self.countNumStr =self.numberTF.baseNum;
        }
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
- (IBAction)selectBtnClick:(id)sender {
    [CGXPickerView showStringPickerWithTitle:@"单位" DataSource:self.selectNameArr DefaultSelValue:@"袋" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        self.selectcode =[[self.selectCodeArr objectAtIndex:[selectRow intValue]] doubleValue];
         self.selectID =[self.selectIDArr objectAtIndex:[selectRow intValue]];
        [self.selectBtn setTitle:selectValue forState:UIControlStateNormal];
        NSLog(@"%@",selectValue);        
        if (self.countNumStr.length!=0&&self.danweiTF.text.length!=0) {
            self.danweiTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
            self.sjchsLab.text =[NSString stringWithFormat:@"实际出货数（%@）：%.3f",self.baseStr,[self.countNumStr intValue]*self.selectcode];
            
            self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.danweiTF.text doubleValue]/self.selectcode)];
            
            if ([self.danweiTF.text doubleValue]>=[self.goodsModel.qty doubleValue]) {
                self.danweiTF.text =self.goodsModel.qty;
                self.numberTF.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.goodsModel.qty intValue]/self.selectcode)];
                self.countNumStr =self.numberTF.baseNum;
            }
        }
        
    }];
}

- (IBAction)closeBtnClick:(id)sender {
    !_closeclickBlock?:_closeclickBlock();
}
- (IBAction)sureBtn:(id)sender {
 ItemsModel *itemModel =self.itemListArr[self.selectBtnTag-100];
    NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObjects:@[@"Wechat",itemModel.payType?:@"",itemModel.serviceType?:@"",[NSString stringWithFormat:@"%f",itemModel.price]?:@"",self.goodsModel.goods_id,self.countNumStr?:@"",self.selectID?:@"",self.goodsModel.sellerid,self.goodsModel.storeId,self.goodsModel.branchId,self.goodsModel.areaId] forKeys:@[@"sourceType",@"payType",@"serviceType",@"userprice",@"id",@"buyNum",@"itemUnit",@"sellerid",@"storeId",@"branchId",@"areaId"]];
    [SNAPI postWithURL:@"buyer/addCart" parameters:muDic success:^(SNResult *result) {
        if (result.state==200) {
            NSLog(@"result=%@",result.data);
            [MBProgressHUD showSuccess:result.data[@"msg"]];
              !_sureclickBlock?:_sureclickBlock();
            //                            [MBProgressHUD showSuccess:result]
            
            //                                [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
  
}
@end
