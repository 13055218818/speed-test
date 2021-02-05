//
//  CSMineConfigModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

typedef NS_ENUM(NSUInteger, CSMineConfigType) {
    CSMineConfigTypeNone = 0,///未知
    CSMineConfigTypeCourse = 0,///我的资料
    CSMineConfigTypeRecord,///查看记录
    CSMineConfigTypeFavorite,///我的收藏
    CSMineConfigTypeSign,///打卡记录
    CSMineConfigTypeMember,///会员中心
    CSMineConfigTypeSpread,///推广中心
    CSMineConfigTypePink,///拼团订单
    CSMineConfigTypeApply,///我的报名
    CSMineConfigTypePresent,///我的赠送
    CSMineConfigTypeRecharge,///充值金币
    CSMineConfigTypeAbout,///关于我们
    CSMineConfigTypeService,///咨询客服
};

@interface CSMineConfigModel : CSBaseModel

@property (nonatomic, strong)NSString  * name;

@property (nonatomic, strong)NSString  * subName;

@property (nonatomic, strong)NSString  * image;

@property (nonatomic, assign)NSInteger   type;

@property (nonatomic, assign)CSMineConfigType  configType;
@end


