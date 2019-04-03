//
//  DRUserInfoModel.h
//  Shop
//
//  Created by BWJ on 2019/03/01.
//  Copyright © 2019 SanTie. All rights reserved.

#import <Foundation/Foundation.h>
@class DROpenUserListModel;
@class DRBuyerModel;
@interface DRUserInfoModel : NSObject
#pragma mark - 单例
+(instancetype)sharedManager;

@property (nonatomic , copy) NSString               * account;//账号
@property (nonatomic , copy) NSString              * password;//密码，null(前台不可见)
@property (nonatomic , copy) NSString              * user_id;//买家账号id
@property (nonatomic , copy) NSString              * buyerid;//买家公司id
@property (nonatomic , assign)NSInteger              timeout;//后台预留字段
@property (nonatomic , strong)DRBuyerModel       * buyer;//买家公司信息
@property (nonatomic , assign)NSInteger             loginLogTime;//
@property (nonatomic , copy) NSString              * loginLogIp;//
@property (nonatomic , copy) NSString              * host;//主机名，null（前台不可见）
@property (nonatomic , copy) NSString              * mobilePhone;//手机号
@property (nonatomic , assign) BOOL              sessionStatus;//会话状态
@property (nonatomic , assign) NSInteger              lastLoginTime;//最近登陆时间
@property (nonatomic , assign) NSInteger              status;//后台预留字段
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

@interface DRBuyerModel : NSObject
#pragma mark - 单例
+(instancetype)sharedManager;

@property (nonatomic , copy) NSString              * remainCredit;
@property (nonatomic , copy) NSString              * location;//区域
@property (nonatomic , copy) NSString              * cTel;
@property (nonatomic , copy) NSString              * ticketType;
@property (nonatomic , copy) NSString              * creditControl;
@property (nonatomic , copy) NSString              * code;//公司编码
@property (nonatomic , copy) NSString              * cPhone;
@property (nonatomic , assign) BOOL                is_exp;
@property (nonatomic , copy) NSString              * exp_station;
@property (nonatomic , copy) NSString              * mobilephone;
@property (nonatomic , copy) NSString              * businessLic;
@property (nonatomic , copy) NSString              * companyAddress;
@property (nonatomic , copy) NSString              * hastaxpricdate;
@property (nonatomic , copy) NSString              * name;//公司名称
//@property (nonatomic , copy) NSArray<DROpenUserListModel *>  * openUserList;
@property (nonatomic , copy) NSString              * commpany_id;//账号id
@property (nonatomic , copy) NSString              * erptypeid;
@property (nonatomic , assign) NSInteger              level;
@property (nonatomic , copy) NSString              * ticketWay;
@property (nonatomic , assign) NSInteger              registionTime;
@property (nonatomic , copy) NSString              * credit;
@property (nonatomic , copy) NSString              * logo;//头像
@property (nonatomic , copy) NSString              * registionIp;
@property (nonatomic , copy) NSString              * cName;
@property (nonatomic , copy) NSString              * overdueControl;
@property (nonatomic , copy) NSString              * locationcode;
//@property(nonatomic,copy)NSString *status;
//@property(nonatomic,copy)NSString *address;
//@property(nonatomic,copy)NSString *ctime;
//@property(nonatomic,copy)NSString *square;
//@property(nonatomic,copy)NSString *price;
//@property(nonatomic,copy)NSString *gps_point;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
