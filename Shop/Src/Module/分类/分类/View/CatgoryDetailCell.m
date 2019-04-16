
//
//  CatgoryDetailCell.m
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CatgoryDetailCell.h"
#import "ShopCarDetailModel.h"
#import "GoodsModel.h"
#import "CGXPickerView.h"
#import "CustomAlertView.h"
#import "DRAddShopModel.h"
#import "DRAddShopView.h"
@implementation CatgoryDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CatgoryDetailCell";
    CatgoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
      [cell.cancelBtn addTarget:cell action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shoucangBtn addTarget:cell action:@selector(shoucangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopCarBtn addTarget:cell action:@selector(shopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)cancelBtnClick:(UIButton *)sender
{
    if (_cancelBlock) {
        _cancelBlock(sender.tag);
    }
}
-(void)shoucangBtnClick:(UIButton *)sender
{
    if (_shopCarBlock) {
        _shoucangBlock(sender.tag);
    }
}
-(void)shopCarBtnClick:(UIButton *)sender
{
    
    DRWeakSelf;
    if ([_goodsModel.qty intValue]!=0) {
        
        NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.goodsModel.sellerid,self.goodsModel.goods_id,self.goodsModel.storeId] forKeys:@[@"sellerId",@"id",@"storeId"]];
        [SNIOTTool getWithURL:@"mainPage/getSingleItem" parameters:mudic success:^(SNResult *result) {
           DRAddShopModel *addShopmodel =[DRAddShopModel mj_objectWithKeyValues:result.data];
            DRAddShopView *AddshopView = [[[NSBundle mainBundle]loadNibNamed:@"DRAddShopView" owner:self options:nil] lastObject];
            AddshopView.goodsModel =self.goodsModel;
            AddshopView.addshopModel =addShopmodel;
            AddshopView.frame =self.superview.superview.bounds;
            AddshopView.closeclickBlock = ^{
                if (AddshopView) {
                    [AddshopView removeFromSuperview];
                }
            };
            AddshopView.sureclickBlock = ^{
                if (AddshopView) {
                    [AddshopView removeFromSuperview];
                }
            };        
            [self.superview.superview addSubview:AddshopView];
            AddshopView.itemListArr =weakSelf.itemListArr;
            
            
            
        } failure:^(NSError *error) {
            
        }];
        if (_shopCarBlock) {
            _shopCarBlock(sender.tag);
        }
    }else
    {
        CustomAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil] lastObject];
        //                CustomAlertView *alertView =[[CustomAlertView alloc]initWithFrame:self.view.bounds];
        alertView.goodsModel =self.goodsModel;
        alertView.frame=self.superview.superview.bounds;
        alertView.closeclickBlock = ^{
            if (alertView) {
                [alertView removeFromSuperview];
            }
        };
        alertView.sureclickBlock = ^{
            //                    if (alertView.selectBtnTag==0) {
            //                        [MBProgressHUD showError:@"请选择期望时间"];
            //                        return ;
            //                    }
            NSArray *hopeDayArr =@[@"5",@"15",@"30",@"60",];
            NSDictionary *dic =@{@"noticeMobile":alertView.phoneTF.text?:@"",@"hopeDay":hopeDayArr[alertView.selectBtnTag-1], @"qty":[alertView.sjchlLab.text substringWithRange:NSMakeRange(10, alertView.sjchlLab.text.length-10)],@"itemId":self.goodsModel.goods_id,@"sellerId":self.goodsModel.sellerid,@"storeId":self.goodsModel.storeId,@"branchId":self.goodsModel.branchId,@"areaId":self.goodsModel.areaId};
            
            NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"notice"];
            [SNAPI postWithURL:@"buyer/addArrivalNotice" parameters:muDic success:^(SNResult *result) {
                if (result.state==200) {
                    NSLog(@"result=%@",result.data);
                    [MBProgressHUD showSuccess:result.data];
                    if (weakSelf.noticeBlock) {
                        weakSelf.noticeBlock(sender.tag);
                    }
                    //                            [MBProgressHUD showSuccess:result]
                    
                    //                                [self.tableView reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
            
            if (alertView) {
                [alertView removeFromSuperview];
            }
        };
        [self.superview.superview addSubview:alertView];
       
        
            
       
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    NSLog(@"id =%@",goodsModel.favariteId);
//    if (goodsModel.favariteId.length!=0) {
//        self.shoucangBtn.selected =YES;
//    }
//    else
//    {
//       self.shoucangBtn.selected =NO;
//    }
    if ([goodsModel.qty intValue]==0) {
        self.shopCarBtn.selected =YES;
    }
    else
    {
       self.shopCarBtn.selected =NO;
    }
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f",[goodsModel.userprice doubleValue]];
}
@end

@interface  CatgoryDetailCell1 ()<NumberCalculateDelegate>

@end
@implementation CatgoryDetailCell1
- (void)awakeFromNib {
    [super awakeFromNib];
}
+(instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
//    static NSString *identify = @"CatgoryDetailCell1";
    CatgoryDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] objectAtIndex:1];        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.danweiBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.danweiBtn.layer.borderWidth =1;
    cell.countTF.layer.borderWidth =1;
     [cell.countTF addTarget:cell action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];//
    cell.countTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.numberCalculate.delegate =cell;
    cell.numberCalculate.baseNum=@"1";
    [cell.danweiBtn addTarget:cell action:@selector(danweiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    cell.selectCountTF.layer.borderColor =[UIColor lightGrayColor].CGColor;
//    cell.selectCountTF.layer.borderWidth =1;
    return cell;
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    NSString *baseStr;//basicunitid 5千支  6公斤  7吨
    if ([_goodsModel.basicunitid intValue]==5) {
        baseStr =@"千支";
    }
    if ([_goodsModel.basicunitid intValue]==6) {
        baseStr =@"公斤";
    }
    if ([_goodsModel.basicunitid intValue]==7) {
        baseStr =@"吨";
    }
    _goodsModel.baseName  =baseStr;
    self.danweiLab.text =baseStr;
    self.selectNameArr =[NSMutableArray array];
    self.selectCodeArr=[NSMutableArray array];
    if (self.goodsModel.unitconversion1.length!=0) {
        [self.selectNameArr addObject:self.goodsModel.unitname1];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion1];
        if (!self.selectcode) {
            self.selectcode =[self.goodsModel.unitconversion1 doubleValue];
            self.selectName =self.goodsModel.unitname1;
            
        }
    }
    if (self.goodsModel.unitconversion2.length!=0) {
        [self.selectNameArr addObject:self.goodsModel.unitname2];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion2];
        if (!self.selectcode) {
            
            self.selectcode =[self.goodsModel.unitconversion2 doubleValue];
            self.selectName =self.goodsModel.unitname2;
        }
        
    }
    if (self.goodsModel.unitconversion3.length!=0) {
        [self.selectNameArr addObject:self.goodsModel.unitname3];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion3];
        if (!self.selectcode) {
            
            self.selectcode =[self.goodsModel.unitconversion3 doubleValue];
            self.selectName =self.goodsModel.unitname3;
        }
        
    }
    if (self.goodsModel.unitconversion4.length!=0) {
        [self.selectNameArr addObject:self.goodsModel.unitname4];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion4];
        if (!self.selectcode) {
            
            self.selectcode =[self.goodsModel.unitconversion4 doubleValue];
            self.selectName =self.goodsModel.unitname4;
        }
        
        
    }
    if (self.goodsModel.unitconversion5.length!=0) {
        [self.selectNameArr addObject:self.goodsModel.unitname5];
        [self.selectCodeArr addObject:self.goodsModel.unitconversion5];
        if (!self.selectcode) {
            
            self.selectcode =[self.goodsModel.unitconversion5 doubleValue];
            self.selectName =self.goodsModel.unitname5;
        }
    }
 
    [self.danweiBtn setTitle:self.selectName forState:UIControlStateNormal];
    self.countNumStr = self.numberCalculate.baseNum ;
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    
}



    

-(void)danweiBtnClick:(UIButton *)sender
{
//    DRWeakSelf;
    [CGXPickerView showStringPickerWithTitle:@"单位" DataSource:self.selectNameArr DefaultSelValue:@"袋" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        self.selectcode =[[self.selectCodeArr objectAtIndex:[selectRow intValue]] doubleValue];
        [self.danweiBtn setTitle:selectValue forState:UIControlStateNormal];
        NSLog(@"%@",selectValue);
        if (self.countNumStr.length!=0&&self.countTF.text.length!=0) {
            self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
             self.numberCalculate.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.countTF.text doubleValue]/self.selectcode)];
             if ([self.countTF.text doubleValue]>=[self.goodsModel.qty doubleValue]) {
                  self.countTF.text =self.goodsModel.qty;
                  self.numberCalculate.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.goodsModel.qty intValue]/self.selectcode)];
                 self.countNumStr =self.numberCalculate.baseNum;
             }
        }
        
    }];
    if (_danweiBtnBlock) {
        _danweiBtnBlock(sender.tag);
    }
}

- (void)resultNumber:(NSString *)number{
   
//    self.numberCalculate =number;
    self.countNumStr =number;
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    self.numberCalculate.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.countTF.text doubleValue]/self.selectcode)];
    NSLog(@"%@>>>resultDelegate>>",number);
    if ([self.countTF.text doubleValue]>=[self.goodsModel.qty doubleValue]) {
        self.countTF.text =self.goodsModel.qty;
        self.numberCalculate.baseNum =[NSString stringWithFormat:@"%.0f",ceil([self.goodsModel.qty intValue]/self.selectcode)];
        self.countNumStr =self.numberCalculate.baseNum;        
    }
}
-(void)textChange:(UITextField *)textField
{
    self.numberCalculate.baseNum =[NSString stringWithFormat:@"%.0f",ceil([textField.text intValue]/self.selectcode)];
    if (ceil([textField.text intValue]/self.selectcode)<1&&textField.text.length!=0) {
        self.numberCalculate.baseNum =@"1";
    }
    NSLog(@"baseNum=%@quzheng%lf text==%d",self.numberCalculate.baseNum,ceil([textField.text intValue]/self.selectcode),[textField.text intValue]);
    if ([textField.text doubleValue]>=[_goodsModel.qty doubleValue]) {
        self.countTF.text =_goodsModel.qty;
        self.numberCalculate.baseNum =[NSString stringWithFormat:@"%.0f",ceil([_goodsModel.qty intValue]/self.selectcode)];
        self.countNumStr =self.numberCalculate.baseNum;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
