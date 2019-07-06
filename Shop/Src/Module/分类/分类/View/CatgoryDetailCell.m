
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
-(NSMutableDictionary *)sourceDic
{
    if (!_sourceDic) {
        _sourceDic =[NSMutableDictionary dictionary];
    }
    return _sourceDic;
}
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
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    NSString *urlStr;
    if (self.shoucangBtn.selected) {
        urlStr =@"buyer/cancelItemFavorite";
        
        mudic =[NSMutableDictionary dictionaryWithObject:self.goodsModel.favariteId forKey:@"id"];
        [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                
                self.goodsModel.favariteId =@"";
                self.shoucangBtn.selected =NO;
                [MBProgressHUD showSuccess:result.data];
                if (_shoucangBlock) {
                    _shoucangBlock(sender.tag);
                }
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.description];
        }];
    }
    else
    {
        urlStr =@"buyer/favoriteItem";
        NSDictionary *dic =@{@"itemId":self.goodsModel.goods_id,@"sellerId":self.goodsModel.sellerid,@"storeId":self.goodsModel.storeId,@"branchId":self.goodsModel.branchId,@"areaId":self.goodsModel.areaId};
        mudic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"item"];
        [SNAPI postWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                self.goodsModel.favariteId=result.data;
                self.shoucangBtn.selected =YES;
                [MBProgressHUD showSuccess:@"收藏成功"];
                //
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
-(void)shopCarBtnClick:(UIButton *)sender
{
    DRWeakSelf;
    if (![_goodsModel.qty isEqualToString:@"0"]) {
        if ([_shoucangStr isEqualToString:@"1"])
        {
            NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.goodsModel.sellerid,self.goodsModel.goods_id,self.goodsModel.storeId] forKeys:@[@"sellerId",@"id",@"storeId"]];
            [SNAPI getWithURL:@"mainPage/getSingleItem" parameters:mudic success:^(SNResult *result) {
                _shoucangStr =@"";
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
        }else
        {
            NSDictionary *dic =@{@"sourceType":@"wechat",@"payType":[NSString stringWithFormat:@"%@",self.goodsModel.payType]?:@"", @"serviceType":self.goodsModel.serviceType?:@"",@"userprice":self.goodsModel.userprice?:@"",@"id":self.goodsModel.goods_id?:@"",@"buyNum":[GoodsShareModel sharedManager].countNumStr?:@"",@"itemUnit":[GoodsShareModel sharedManager].selectcode?:@"",@"sellerid":self.goodsModel.sellerid?:@"",@"storeId":self.goodsModel.storeId?:@"",@"branchId":self.goodsModel.branchId?:@"",@"areaId":self.goodsModel.areaId?:@""};
            
            [SNAPI postWithURL:@"buyer/addCart" parameters:dic.mutableCopy success:^(SNResult *result) {
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
            
        }
        
        if (_shopCarBlock) {
            _shopCarBlock(sender.tag);
        }
    }else
    {
        if (self.daohuoTongzhiStr.length==0) {
            
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
                    }
                } failure:^(NSError *error) {
                }];
                if (alertView) {
                    [alertView removeFromSuperview];
                }
            };
            [self.superview.superview addSubview:alertView];
        }else
        {
            if ([_goodsModel.qty intValue]==0) {
                UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"溫馨提示" message:@"您需要的货品还未到货呦！请耐心等待" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
                [al show];
            }
        }
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
    if (goodsModel.favariteId.length!=0) {
        self.shoucangBtn.selected =YES;
    }
    else
    {
       self.shoucangBtn.selected =NO;
    }
    if ([goodsModel.qty intValue]==0) {
        self.shopCarBtn.selected =YES;
    }
    else
    {
       self.shopCarBtn.selected =NO;
    }
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f/%@",[goodsModel.userprice doubleValue],goodsModel.basicunitname];
}
-(void)setDaohuoTongzhiStr:(NSString *)daohuoTongzhiStr
{
    _daohuoTongzhiStr =daohuoTongzhiStr;
    self.shopCarBtn.selected =NO;
    
    
}
//-(void)setSameModel:(DRSameModel *)sameModel
//{
//    _sameModel =sameModel;
//    
//   
//    _orderPriceLab.hidden =NO;
//    _lineView.hidden =NO;
//    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f/%@",sameModel.userprice,sameModel.basicunitname];
//    self.orderPriceLab.text =[NSString stringWithFormat:@"%.2f/%@",sameModel.bidPrice,sameModel.basicunitname];
//}
-(void)setShoucangStr:(NSString *)shoucangStr
{
    _shoucangStr =shoucangStr;
    
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr =titleStr;
    _orderPriceLab.hidden =NO;
    _lineView.hidden =NO;
    
}
@end

@interface  CatgoryDetailCell1 ()<ATChooseCountDelegate,UITextFieldDelegate>
@property(nonatomic,strong)ATChooseCountView *chooseCountView;     //输入框加减
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
    cell.sourceDic =[NSMutableDictionary dictionary];
    cell.danweiBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.danweiBtn.layer.borderWidth =1;
    cell.countTF.layer.borderWidth =1;
     [cell.countTF addTarget:cell action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];//
    cell.countTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.countTF.delegate =cell;
    cell.chooseCountView = [[ATChooseCountView alloc] initWithFrame:cell.numberview.bounds];
    cell.chooseCountView.delegate =cell;
    cell.chooseCountView.countColor = BLACKCOLOR;
    cell.chooseCountView.canEdit = YES;
    [cell.numberview addSubview:cell.chooseCountView];
    [cell.danweiBtn addTarget:cell action:@selector(danweiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cancelBtn addTarget:cell action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shoucangBtn addTarget:cell action:@selector(shoucangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopCarBtn addTarget:cell action:@selector(shopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    cell.selectCountTF.layer.borderColor =[UIColor lightGrayColor].CGColor;
//    cell.selectCountTF.layer.borderWidth =1;
    return cell;
}
#pragma buttonClick
-(void)cancelBtnClick:(UIButton *)sender
{
    if (_cancelBlock) {
        _cancelBlock(sender.tag);
    }
}
-(void)shoucangBtnClick:(UIButton *)sender
{
    //    if (_shopCarBlock) {
    //        _shoucangBlock(sender.tag);
    //    }
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    NSString *urlStr;
    if (self.shoucangBtn.selected) {
        urlStr =@"buyer/cancelItemFavorite";
        
        mudic =[NSMutableDictionary dictionaryWithObject:self.goodsModel.favariteId forKey:@"id"];
        [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                
                self.goodsModel.favariteId =@"";
                self.shoucangBtn.selected =NO;
                [MBProgressHUD showSuccess:result.data];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.description];
        }];
    }
    else
    {
        urlStr =@"buyer/favoriteItem";
        NSDictionary *dic =@{@"itemId":self.goodsModel.goods_id,@"sellerId":self.goodsModel.sellerid,@"storeId":self.goodsModel.storeId,@"branchId":self.goodsModel.branchId,@"areaId":self.goodsModel.areaId};
        mudic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"item"];
        [SNAPI postWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                self.goodsModel.favariteId=result.data;
                self.shoucangBtn.selected =YES;
                [MBProgressHUD showSuccess:@"收藏成功"];
                //
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
}
-(void)shopCarBtnClick:(UIButton *)sender
{
    
    DRWeakSelf;
    if (![_goodsModel.qty isEqualToString:@"0"]) {
        if ([_shoucangStr isEqualToString:@"1"])
        {
            NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.goodsModel.sellerid,self.goodsModel.goods_id,self.goodsModel.storeId] forKeys:@[@"sellerId",@"id",@"storeId"]];
            [SNAPI getWithURL:@"mainPage/getSingleItem" parameters:mudic success:^(SNResult *result) {
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
        }else
        {
            NSDictionary *dic =@{@"sourceType":@"wechat",@"payType":[NSString stringWithFormat:@"%@",self.goodsModel.payType]?:@"", @"serviceType":self.goodsModel.serviceType?:@"",@"userprice":self.goodsModel.userprice?:@"",@"id":self.goodsModel.goods_id?:@"",@"buyNum":self.countNumStr?:@"",@"itemUnit":self.selectDanWei?:@"",@"sellerid":self.goodsModel.sellerid?:@"",@"storeId":self.goodsModel.storeId?:@"",@"branchId":self.goodsModel.branchId?:@"",@"areaId":self.goodsModel.areaId?:@""};
            
            
            [SNAPI postWithURL:@"buyer/addCart" parameters:dic.mutableCopy success:^(SNResult *result) {
                if (result.state==200) {
//                    NSLog(@"result=%@",result.data);
                    [MBProgressHUD showSuccess:result.data[@"msg"]];
//                    if (_shopCarBlock) {
//                        _shopCarBlock(sender.tag);
//                    }
                }
            } failure:^(NSError *error) {
                
            }];
            
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
-(void)setSameModel:(DRSameModel *)sameModel
{
    _sameModel =sameModel;
    
    
    _orderPriceLab.hidden =NO;
    _lineView.hidden =NO;
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f/%@",sameModel.userprice,sameModel.basicunitname];
    self.orderPriceLab.text =[NSString stringWithFormat:@"%.2f/%@",sameModel.bidPrice,sameModel.basicunitname];
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
    
    NSMutableArray *unitconversionArr =[NSMutableArray array];
     NSMutableArray *unitNameArr =[NSMutableArray array];
     NSMutableArray *uniDanWeiArr =[NSMutableArray array];
    if (self.goodsModel.unitconversion1.length!=0) {
        [unitconversionArr addObject:self.goodsModel.unitconversion1];
        [unitNameArr addObject:self.goodsModel.unitname1];
        [uniDanWeiArr addObject:self.goodsModel.unit1];
    }
    if (self.goodsModel.unitconversion2.length!=0) {
        [unitconversionArr addObject:self.goodsModel.unitconversion2];
        [unitNameArr addObject:self.goodsModel.unitname2];
         [uniDanWeiArr addObject:self.goodsModel.unit2];

    }
    if (self.goodsModel.unitconversion3.length!=0) {
      [unitconversionArr addObject:self.goodsModel.unitconversion3];
      [unitNameArr addObject:self.goodsModel.unitname3];
         [uniDanWeiArr addObject:self.goodsModel.unit3];
    }
    if (self.goodsModel.unitconversion4.length!=0) {
 
        [unitconversionArr addObject:self.goodsModel.unitconversion4];
        [unitNameArr addObject:self.goodsModel.unitname4];
         [uniDanWeiArr addObject:self.goodsModel.unit4];

    }
    if (self.goodsModel.unitconversion5.length!=0) {
         [unitconversionArr addObject:self.goodsModel.unitconversion5];
         [unitNameArr addObject:self.goodsModel.unitname5];
         [uniDanWeiArr addObject:self.goodsModel.unit5];

    }
    self.selectNameArr =[NSMutableArray array];
    self.selectCodeArr=[NSMutableArray array];
    self.selectDanweiArr=[NSMutableArray array];
    if ([self.goodsModel.saleunitid intValue]==5||[self.goodsModel.saleunitid intValue]==6||[self.goodsModel.saleunitid intValue]==7)
    {
        [self.selectCodeArr addObject:self.goodsModel.saleunitconversion];
        [self.selectNameArr addObject:self.goodsModel.saleunitname];
        [self.selectDanweiArr addObject:self.goodsModel.saleunitid];
        if ([self.goodsModel.saleunitid intValue]==5||[self.goodsModel.saleunitid intValue]==7) {
            self.chooseCountView.multipleNum =0.001;
        }
    }
    NSInteger selectrow = 0;
    for (int i=0; i<unitNameArr.count; i++) {
        if ([self.goodsModel.saleunitname isEqualToString:unitNameArr[i]]) {
            selectrow =i;
        }
    }
    [self.selectCodeArr addObjectsFromArray:[unitconversionArr subarrayWithRange:NSMakeRange(selectrow, unitconversionArr.count-selectrow)]];
     [self.selectDanweiArr addObjectsFromArray:[uniDanWeiArr subarrayWithRange:NSMakeRange(selectrow, uniDanWeiArr.count-selectrow)]];
    [self.selectNameArr addObjectsFromArray:[unitNameArr subarrayWithRange:NSMakeRange(selectrow, unitconversionArr.count-selectrow)]];
    self.selectcode =[[self.selectCodeArr firstObject] doubleValue];
    self.selectDanWei =[self.selectDanweiArr firstObject];
     self.selectName =[self.selectNameArr firstObject];
    [self.danweiBtn setTitle:[self.selectNameArr firstObject] forState:UIControlStateNormal];
    [self.danweiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",[self.goodsModel.minquantity doubleValue]] doubleValue];
    self.chooseCountView.minCount =[[NSString stringWithFormat:@"%.3f",[self.goodsModel.minquantity doubleValue]] doubleValue];
    self.countNumStr = [NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
   //处理尾货逻辑
    if (self.selectcode>[self.goodsModel.qty doubleValue]) {
        self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.goodsModel.qty doubleValue]];
    }
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f/%@",[self.goodsModel.userprice doubleValue],self.goodsModel.basicunitname];
    self.chooseCountView.canEdit =NO;
    
}
-(void)danweiBtnClick:(UIButton *)sender
{
    DRWeakSelf;
//    showStringPickerWithTitle:@"全部订单" DataSource:@[ @"全部订单",@"近一个月订单", @"近两个月订单", @"一年内订单"] DefaultSelValue:@"全部订单" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow)
    
    [CGXPickerView showStringPickerWithTitle:[self.selectNameArr firstObject] DataSource:self.selectNameArr DefaultSelValue:[self.selectNameArr firstObject] IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        self.selectcode =[[self.selectCodeArr objectAtIndex:[selectRow intValue]] doubleValue];
        self.selectDanWei =[self.selectDanweiArr objectAtIndex:[selectRow intValue]];
        self.selectName =selectValue;
        [self.danweiBtn setTitle:selectValue forState:UIControlStateNormal];
        if ([ self.selectName isEqualToString:@"千支"]||[ self.selectName isEqualToString:@"吨"]){
            self.chooseCountView.multipleNum =0.001;
        }
        else{
             self.chooseCountView.multipleNum =1;
        }
        NSLog(@"%@",selectValue);
        if (self.countNumStr.length!=0&&self.countTF.text.length!=0) {
            self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
             self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.0f",ceil([self.countTF.text doubleValue]/self.selectcode)] doubleValue];
             if ([self.countTF.text doubleValue]>=[self.goodsModel.qty doubleValue]) {
                  self.countTF.text =[NSString stringWithFormat:@"%.3f",[weakSelf.goodsModel.qty doubleValue]];
                  self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",[weakSelf.goodsModel.qty doubleValue]/self.selectcode] doubleValue];
                 self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
             }
        }
        [self.danweiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    }];
    if (_danweiBtnBlock) {
        _danweiBtnBlock(sender.tag);
    }
}
#pragma ATChooseCountDelegate
- (void)resultNumber:(NSString *)number{
//    self.numberCalculate =number;
    self.countNumStr =number;
    if ([ self.selectName isEqualToString:@"千支"]||[ self.selectName isEqualToString:@"吨"]) {
    }
    else
    {        
         self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%d",[number intValue]] doubleValue];
    }
   
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr doubleValue]*self.selectcode];
    
    
    if ([[NSString stringWithFormat:@"%.3f",[number doubleValue]*self.selectcode] doubleValue]>=[self.goodsModel.qty doubleValue]) {
        self.countTF.text =[NSString stringWithFormat:@"%.3f",[_goodsModel.qty doubleValue]];
       
        self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",[_goodsModel.qty doubleValue]/self.selectcode] doubleValue];
        self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
    }
}
-(void)textChange:(UITextField *)textField
{

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.countTF)
    {
        if (string.length == 0) return YES;
        
        if ([textField.text doubleValue]>=[_goodsModel.qty doubleValue]) {
            textField.text =[NSString stringWithFormat:@"%.3f",[_goodsModel.qty doubleValue]];
            
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",[_goodsModel.qty doubleValue]/self.selectcode] doubleValue];
            self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
        }
        else
        {
            
            //
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.0f",ceil([textField.text doubleValue]/self.selectcode)] doubleValue];
            if (ceil([textField.text intValue]/self.selectcode)<1&&textField.text.length!=0) {
                self.chooseCountView.currentCount =1.f;
            }
            return YES;
        }
        return NO;
    }
    
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end


@interface  CatgoryDetailCell2 ()<ATChooseCountDelegate,UITextFieldDelegate>
@property(nonatomic,strong)ATChooseCountView *chooseCountView;     //输入框加减
@end
@implementation CatgoryDetailCell2

- (void)awakeFromNib {
    [super awakeFromNib];
}
+(instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    //    static NSString *identify = @"CatgoryDetailCell1";
    CatgoryDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CatgoryDetailCell" owner:nil options:nil] objectAtIndex:2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.sourceDic =[NSMutableDictionary dictionary];
    cell.danweiBtn.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.danweiBtn.layer.borderWidth =1;
    cell.countTF.layer.borderWidth =1;
    [cell.countTF addTarget:cell action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];//
    cell.countTF.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.countTF.delegate =cell;
    cell.chooseCountView = [[ATChooseCountView alloc] initWithFrame:cell.numberview.bounds];
    cell.chooseCountView.delegate =cell;
    cell.chooseCountView.countColor = BLACKCOLOR;
    cell.chooseCountView.canEdit = YES;
    [cell.numberview addSubview:cell.chooseCountView];
    [cell.danweiBtn addTarget:cell action:@selector(danweiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cancelBtn addTarget:cell action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shoucangBtn addTarget:cell action:@selector(shoucangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shopCarBtn addTarget:cell action:@selector(shopCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)setSameModel:(DRSameModel *)sameModel
{
    _sameModel =sameModel;
    NSString *baseStr;//basicunitid 5千支  6公斤  7吨
    if ([_sameModel.basicunitid intValue]==5) {
        baseStr =@"千支";
    }
    if ([_sameModel.basicunitid intValue]==6) {
        baseStr =@"公斤";
    }
    if ([_sameModel.basicunitid intValue]==7) {
        baseStr =@"吨";
    }
    _sameModel.basicunitname  =baseStr;
    self.danweiLab.text =baseStr;
    
    NSMutableArray *unitconversionArr =[NSMutableArray array];
    NSMutableArray *unitNameArr =[NSMutableArray array];
    NSMutableArray *uniDanWeiArr =[NSMutableArray array];
    if (_sameModel.unitconversion1!=0) {
        [uniDanWeiArr addObject:_sameModel.unit1];
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitconversion1 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitname1];
    }
    if (_sameModel.unitconversion2!=0) {
        [uniDanWeiArr addObject:_sameModel.unit2];
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitconversion2 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitname2];
        
    }
    if (_sameModel.unitconversion3!=0) {
         [uniDanWeiArr addObject:_sameModel.unit3];
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitconversion3 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitname3];
    }
    if (_sameModel.unitconversion4!=0) {
        
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitconversion4 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitname4];
         [uniDanWeiArr addObject:_sameModel.unit4];
  
    }
    if (_sameModel.unitconversion5.length!=0) {
        [unitconversionArr addObject:[NSString stringWithFormat:@"%.3f",[_sameModel.unitconversion5 doubleValue]]];
        [unitNameArr addObject:_sameModel.unitname5];
         [uniDanWeiArr addObject:_sameModel.unit4];
 
    }
    self.selectNameArr =[NSMutableArray array];
    self.selectCodeArr=[NSMutableArray array];
    self.selectDanweiArr=[NSMutableArray array];
    if ([_sameModel.saleunitid intValue]==5||[_sameModel.saleunitid intValue]==6||[_sameModel.saleunitid intValue]==7)
    {        
        [self.selectCodeArr addObject:[NSString stringWithFormat:@"%f",_sameModel.saleunitconversion]];
         [self.selectDanweiArr addObject:_sameModel.saleunitid];
        [self.selectNameArr addObject:_sameModel.saleunitname];
        if ([_sameModel.saleunitid intValue]==5||[_sameModel.saleunitid intValue]==7) {
            self.chooseCountView.multipleNum =0.001;
        }
    }
    NSInteger selectrow = 0;
    for (int i=0; i<unitNameArr.count; i++) {
        if ([_sameModel.saleunitname isEqualToString:unitNameArr[i]]) {
            selectrow =i;
        }
    }
    [self.selectCodeArr addObjectsFromArray:[unitconversionArr subarrayWithRange:NSMakeRange(selectrow, unitconversionArr.count-selectrow)]];
    [self.selectNameArr addObjectsFromArray:[unitNameArr subarrayWithRange:NSMakeRange(selectrow, unitconversionArr.count-selectrow)]];
     [self.selectDanweiArr addObjectsFromArray:[uniDanWeiArr subarrayWithRange:NSMakeRange(selectrow, uniDanWeiArr.count-selectrow)]];
    self.selectDanWei =[self.selectDanweiArr firstObject];
    self.selectcode =[[self.selectCodeArr firstObject] doubleValue];
    self.selectName =[self.selectNameArr firstObject];
    [self.danweiBtn setTitle:[self.selectNameArr firstObject] forState:UIControlStateNormal];
    [self.danweiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    self.chooseCountView.currentCount =self.sameModel.minquantity;
    self.chooseCountView.minCount =self.sameModel.minquantity;
    self.countNumStr = [NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
    //处理尾货逻辑
    if (self.selectcode>_sameModel.qty) {
        self.countTF.text  =[NSString stringWithFormat:@"%.3f",_sameModel.qty];
    }
    _orderPriceLab.hidden =NO;
    _lineView.hidden =NO;
    self.priceAccountLab.text =[NSString stringWithFormat:@"单价：%.2f/%@",sameModel.userprice,sameModel.basicunitname];
    self.orderPriceLab.text =[NSString stringWithFormat:@"%.2f/%@",sameModel.level_price,sameModel.basicunitname];
}
-(void)shoucangBtnClick:(UIButton *)sender
{
    //    if (_shopCarBlock) {
    //        _shoucangBlock(sender.tag);
    //    }
    NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
    NSString *urlStr;
    if (self.shoucangBtn.selected) {
        urlStr =@"buyer/cancelItemFavorite";
        
        mudic =[NSMutableDictionary dictionaryWithObject:self.sameModel.favariteId forKey:@"id"];
        [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                
                self.sameModel.favariteId =@"";
                self.shoucangBtn.selected =NO;
                [MBProgressHUD showSuccess:result.data];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.description];
        }];
    }
    else
    {
        urlStr =@"buyer/favoriteItem";
        NSDictionary *dic =@{@"itemId":self.sameModel.sameID,@"sellerId":self.sameModel.sellerid,@"storeId":self.sameModel.storeId,@"branchId":self.sameModel.branchId,@"areaId":self.sameModel.areaId};
        mudic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"item"];
        [SNAPI postWithURL:urlStr parameters:mudic success:^(SNResult *result) {
            if (result.state==200) {
                NSLog(@"result=%@",result.data);
                self.sameModel.favariteId=result.data;
                self.shoucangBtn.selected =YES;
                [MBProgressHUD showSuccess:@"收藏成功"];
                //
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
}
-(void)shopCarBtnClick:(UIButton *)sender
{
    
    DRWeakSelf;
    if (_sameModel.qty!=0) {
        if ([_shoucangStr isEqualToString:@"1"])
        {
            NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.sameModel.sellerid,self.sameModel.sameID,self.sameModel.storeId] forKeys:@[@"sellerId",@"id",@"storeId"]];
            [SNAPI getWithURL:@"mainPage/getSingleItem" parameters:mudic success:^(SNResult *result) {
                DRAddShopModel *addShopmodel =[DRAddShopModel mj_objectWithKeyValues:result.data];
                DRAddShopView *AddshopView = [[[NSBundle mainBundle]loadNibNamed:@"DRAddShopView" owner:self options:nil] lastObject];
                AddshopView.goodsModel =(GoodsModel*)self.sameModel;
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
        }else
        {
            NSDictionary *dic =@{@"sourceType":@"wechat",@"payType":[NSString stringWithFormat:@"%@",self.sameModel.payType]?:@"", @"serviceType":self.sameModel.serviceType?:@"",@"userprice":[NSString stringWithFormat:@"%f",self.sameModel.userprice]?:@"",@"id":self.sameModel.sameID?:@"",@"buyNum":self.countNumStr?:@"",@"itemUnit":self.selectDanWei?:@"",@"sellerid":self.sameModel.sellerid?:@"",@"storeId":self.sameModel.storeId?:@"",@"branchId":self.sameModel.branchId?:@"",@"areaId":self.sameModel.areaId?:@""};
            
            
            [SNAPI postWithURL:@"buyer/addCart" parameters:dic.mutableCopy success:^(SNResult *result) {
                if (result.state==200) {
                    //                    NSLog(@"result=%@",result.data);
                    [MBProgressHUD showSuccess:result.data[@"msg"]];
                    //                    if (_shopCarBlock) {
                    //                        _shopCarBlock(sender.tag);
                    //                    }
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
        
    }else
    {
        
        
        CustomAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil] lastObject];
        //                CustomAlertView *alertView =[[CustomAlertView alloc]initWithFrame:self.view.bounds];
        alertView.goodsModel =(GoodsModel*)self.sameModel;
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
            NSDictionary *dic =@{@"noticeMobile":alertView.phoneTF.text?:@"",@"hopeDay":hopeDayArr[alertView.selectBtnTag-1], @"qty":[alertView.sjchlLab.text substringWithRange:NSMakeRange(10, alertView.sjchlLab.text.length-10)],@"itemId":self.sameModel.sameID,@"sellerId":self.sameModel.sellerid,@"storeId":self.sameModel.storeId,@"branchId":self.sameModel.branchId,@"areaId":self.sameModel.areaId};
            
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

-(void)danweiBtnClick:(UIButton *)sender
{
    DRWeakSelf;
    //    showStringPickerWithTitle:@"全部订单" DataSource:@[ @"全部订单",@"近一个月订单", @"近两个月订单", @"一年内订单"] DefaultSelValue:@"全部订单" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow)
    
    [CGXPickerView showStringPickerWithTitle:[self.selectNameArr firstObject] DataSource:self.selectNameArr DefaultSelValue:[self.selectNameArr firstObject] IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
        self.selectDanWei =self.selectDanweiArr[[selectRow intValue]];
        self.selectcode =[[self.selectCodeArr objectAtIndex:[selectRow intValue]] doubleValue];
        self.selectName =selectValue;
        [self.danweiBtn setTitle:selectValue forState:UIControlStateNormal];
        if ([ self.selectName isEqualToString:@"千支"]||[ self.selectName isEqualToString:@"吨"]) {
            self.chooseCountView.multipleNum =0.001;
        }
        else
        {
            self.chooseCountView.multipleNum =1;
        }
        NSLog(@"%@",selectValue);
        if (self.countNumStr.length!=0&&self.countTF.text.length!=0) {
            //            self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr intValue]*self.selectcode];
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.0f",ceil([self.countTF.text doubleValue]/self.selectcode)] doubleValue];
            if ([self.countTF.text doubleValue]>=self.sameModel.qty) {
                self.countTF.text =[NSString stringWithFormat:@"%.3f",weakSelf.sameModel.qty];
                self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",weakSelf.sameModel.qty/self.selectcode] doubleValue];
                self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
            }
        }
        [self.danweiBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    }];
    if (_danweiBtnBlock) {
        _danweiBtnBlock(sender.tag);
    }
}
#pragma ATChooseCountDelegate
- (void)resultNumber:(NSString *)number{
    
    //    self.numberCalculate =number;
    self.countNumStr =number;
    
    if ([ self.selectName isEqualToString:@"千支"]||[ self.selectName isEqualToString:@"吨"]) {
        
    }
    else
    {
        
        self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%d",[number intValue]] doubleValue];
    }
    
    self.countTF.text  =[NSString stringWithFormat:@"%.3f",[self.countNumStr doubleValue]*self.selectcode];
    
    
    if ([[NSString stringWithFormat:@"%.3f",[number doubleValue]*self.selectcode] doubleValue]>=self.sameModel.qty) {
        self.countTF.text =[NSString stringWithFormat:@"%.3f",_sameModel.qty];
        
        self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",_sameModel.qty/self.selectcode] doubleValue];
        self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
    }

}
-(void)textChange:(UITextField *)textField
{
   
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.countTF)
    {
        if (string.length == 0) return YES;
        
        if ([textField.text doubleValue]>=_sameModel.qty) {
            textField.text =[NSString stringWithFormat:@"%.3f",_sameModel.qty];
            
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.3f",_sameModel.qty/self.selectcode] doubleValue];
            self.countNumStr =[NSString stringWithFormat:@"%.3f",self.chooseCountView.currentCount];
        }
        else
        {
            
            //
            self.chooseCountView.currentCount =[[NSString stringWithFormat:@"%.0f",ceil([textField.text doubleValue]/self.selectcode)] doubleValue];
            if (ceil([textField.text intValue]/self.selectcode)<1&&textField.text.length!=0) {
                self.chooseCountView.currentCount =1.f;
            }
            return YES;
        }
        return NO;
    }
    
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
