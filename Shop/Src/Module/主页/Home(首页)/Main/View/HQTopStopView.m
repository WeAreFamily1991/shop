//
//  HQTopStopView.m
//  HQCollectionViewDemo
//
//  Created by Mr_Han on 2018/10/10.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
// 

#import "HQTopStopView.h"
#import "DRCollectionViewCell.h"
#import "DRCollectionModel.h"
#import "GSFilterView.h"
#import "GSMacros.h"
#import "UIButton+BackgroundColor.h"
#define NeedWidth   self.frame.size.width  // 需求总宽度
#define NeedHeight  self.frame.size.height // 需求总高度
#define NeedStartMargin 15   // 首列起始间距
#define NeedFont 14   // 需求文字大小
#define NeedBtnHeight 33   // 按钮高度
#define NeediPhoneXMargin    (NeedHeight == 812.0 ? 88 : 64) //首行起始距离

@interface HQTopStopView ()<SYMoreButtonDelegate,UICollectionViewDelegate, UICollectionViewDataSource,DKFilterViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray *dataSource;
@property(nonatomic,strong) NSMutableArray *selectArr;
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic,strong) GSFilterView *filterView;
@property (nonatomic,strong) DKFilterModel *clickModel;
@property (nonatomic , strong) UIButton * currentSelectedBtn ;
@end
@implementation HQTopStopView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self setUpUI];
    }
    return self;
}
-(void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex =selectIndex;
}
-(void)setUpUI
{

   
    self.dataSource = @[@"AS",@".NET",@"Swif",@"OC",@"JS",@"HTML",@"HTML",@"C",@"CSS",@"Python"];

//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 30)];
//    label.text = @"请选择";
//    [self.view addSubview:label];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SELECTELL"];
    self.selectArr = [NSMutableArray array];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float w = (self.frame.size.width - 35)/4;
    float h = (self.frame.size.width - 35)/10;
    return (CGSize){w,h};
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _bigCartporyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SELECTELL" forIndexPath:indexPath];
    DRCollectionModel *collectionModel =[DRCollectionModel mj_objectWithKeyValues:self.bigCartporyArr[indexPath.row]];
    cell.collectionModel = collectionModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DRCollectionViewCell *cell = (DRCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.content.textColor =[UIColor whiteColor];
    cell.selImageIc.hidden = NO;
   
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    DRCollectionViewCell *cell = (DRCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.content.textColor =[UIColor blackColor];
    cell.selImageIc.hidden = YES;
    
}

-(void)setBigCartporyArr:(NSArray *)bigCartporyArr
{
    _bigCartporyArr =bigCartporyArr;
    //初始行_列的X、Y值设置
    float butX = NeedStartMargin;
    float butY =10;
    for(int i = 0; i < self.bigCartporyArr.count; i++){
        //宽度自适应计算宽度
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:NeedFont]};
        CGRect frame_W = [self.bigCartporyArr[i][@"name"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        //宽度计算得知当前行不够放置时换行计算累加Y值
        if (butX+frame_W.size.width+NeedStartMargin*2>SCREEN_WIDTH-NeedStartMargin) {
            butX = NeedStartMargin;
            butY += (NeedBtnHeight+12);//Y值累加，具体值请结合项目自身需求设置 （值 = 按钮高度+按钮间隙）
        }
        //设置计算好的位置数值
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+NeedStartMargin*2, NeedBtnHeight)];
        //设置内容
        [btn setTitle:self.bigCartporyArr[i][@"name"] forState:UIControlStateNormal];
        //设置文字状态颜色
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //设置背景状态颜色，这里用到了一个工具类UIButton+BackgroundColor
        [btn setBackgroundColor:BACKGROUNDCOLOR forState:UIControlStateNormal] ;
        [btn setBackgroundColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
        //文字大小
        btn.titleLabel.font = [UIFont systemFontOfSize:NeedFont];
        //裁圆角
        btn.layer.cornerRadius = 3;
        btn.clipsToBounds = YES ;
//        //设置边框
//        btn.layer.borderWidth = 1 ;
//        btn.layer.borderColor = [UIColor grayColor].CGColor ;
        //设置角标
        btn.tag = i;
        //添加事件
        [btn addTarget:self action:@selector(SelBtn:) forControlEvents:UIControlEventTouchUpInside];
        //添加按钮
        [self addSubview:btn];
        //一个按钮添加之后累加X值后续计算使用
        NSLog(@"%f",CGRectGetMaxX(btn.frame));
        butX = CGRectGetMaxX(btn.frame)+15;
        if (i==_selectIndex) {//默认选中第一个
            btn.selected =YES;
//            [self SelBtn:btn];
        }
    }
//    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, self.dc_height-2, SCREEN_WIDTH, 2)];
//    lineView.backgroundColor =BACKGROUNDCOLOR;
//    [self addSubview:lineView];
}
#pragma mark--点击事件
-(void)SelBtn:(UIButton *)sender{
    self.currentSelectedBtn.selected = NO ;
    sender.selected = YES ;
    self.currentSelectedBtn = sender ;
    NSLog(@"点击 %ld--%@",sender.tag,self.bigCartporyArr[sender.tag][@"name"]);
//    NSDictionary *dic=@{@"tag":[NSString stringWithFormat:@"%d",sender.tag]};
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"HQTopStopView" object:nil userInfo:dic];
    if (_SelectbuttonClickBlock) {
        _SelectbuttonClickBlock(sender.tag);
    }
}

//-(void)setSelectIndex:(NSInteger)selectIndex
//{
//
//    if (selectIndex!=8) {
//        return;
//    }
//    if (self.bottomBtnView) {
//        return;
//    }
//    if (selectIndex==8) {
//
//        /*
//         详细布局代码注释请参考“九宫格按钮”内部布局注释
//         */
//      ;
//        CGFloat btnX = 0;
//        CGFloat btnY = 0;
//        CGFloat btnW = (NeedWidth- (NeedNumberOfColumns + 1) * NeedMargin) / NeedNumberOfColumns;
//        CGFloat btnH =btnW/2.5;
//        for (int i=0; i<self.bigCartporyArr.count; i++) {
//            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btnX = NeedMargin + (i % NeedNumberOfColumns) * (NeedMargin + btnW);
//            btnY = NeedMargin + (i / NeedNumberOfColumns) * (NeedMargin + btnH);
//            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            [btn setTitle:self.bigCartporyArr[i][@"bigCategoryName"] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            btn.layer.cornerRadius =3;
//            btn.layer.masksToBounds =3;
//            btn.titleLabel.textAlignment = 1 ;
//            btn.tag = i+1 ;
//            btn.titleLabel.font =DR_FONT(12);
//            btn.frame = CGRectMake(btnX+NeedStartMargin, btnY, btnW, btnH);
//            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//            if (i==0) {
//                [self clickBtn:btn];
//            }
//            [self addSubview:btn];
//        }
//    }
//}
//-(void)setSelectbullIndex:(NSInteger)selectbullIndex
//{
//    if (selectbullIndex!=4) {
//        return;
//    }
//    if (self.bottomBtnView) {
//        return;
//    }
//    if (selectbullIndex==4) {
//
//        /*
//         详细布局代码注释请参考“九宫格按钮”内部布局注释
//         */
//        ;
//        CGFloat btnX = 0;
//        CGFloat btnY = 0;
//        CGFloat btnW = (NeedWidth- (NeedNumberOfColumns + 1) * NeedMargin) / NeedNumberOfColumns;
//        CGFloat btnH =btnW/2.2;
//        for (int i=0; i<self.bigCartporyArr.count; i++) {
//            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btnX = NeedMargin + (i % NeedNumberOfColumns) * (NeedMargin + btnW);
//            btnY = NeedMargin + (i / NeedNumberOfColumns) * (NeedMargin + btnH);
//            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            [btn setTitle:self.bigCartporyArr[i] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            btn.layer.cornerRadius =3;
//            btn.layer.masksToBounds =3;
//            btn.titleLabel.textAlignment = 1 ;
//            btn.tag = i+1 ;
//            btn.titleLabel.font =DR_FONT(12);
//            btn.frame = CGRectMake(btnX+NeedStartMargin, btnY, btnW, btnH);
//            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//            if (i==0) {
//                [self clickBtn:btn];
//            }
//            [self addSubview:btn];
//        }
//    }
//}
//#pragma mark--点击事件
//-(void)clickBtn:(UIButton *)sender{
//    /*
//     使用单选还是多选请单独注销使用
//     */
//    //单选
//    if(self.btn== sender) {
//        //上次点击过的按钮，不做处理
//    } else{
//        //本次点击的按钮设为红色
//        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [sender setBackgroundColor:REDCOLOR];
//
//        //将上次点击过的按钮设为默认
//        [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.btn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
//        if (_buttonClickBlock) {
//            _buttonClickBlock(sender.tag);
//        }
//    }
//    self.btn = sender;
//    NSLog(@"点击了第 %ld 个按钮", (long)sender.tag );
//
//    //多选
//    //      if (!sender.selected) {//没有选中过的先改变状态，再添加到保存按钮的数组中
//    //           [sender setBackgroundColor:[UIColor brownColor]];
//    //           [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //           [self.array addObject:[NSNumber numberWithInteger:sender.tag]];
//    //        }else{
//    //           [sender setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
//    //            if ([self.array containsObject:[NSNumber numberWithInteger:sender.tag]]) {
//    //                [self.array removeObject:[NSNumber numberWithInteger:sender.tag]];
//    //               }
//    //        }
//    //           sender.selected = !sender.selected;
//    //        NSLog(@"多选项：%@", _array.description);
//}


- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray arrayWithCapacity:0];
    }
    return _array;
}
//- (UIView *)topView {
//    if (!_topView) {
//        _topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
//        _topView.backgroundColor =[UIColor whiteColor];
//        [self addSubview:_topView];
//    }
//    return _topView;
//}
-(void)buttonBtnClick:(UIButton *)sender
{
    self.buttonBtn.selected = NO ;
    sender.selected = YES ;
    self.buttonBtn = sender ;
    
    NSLog(@"点击 %ld",sender.tag) ;
}


@end
