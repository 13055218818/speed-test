//
//  CSUserModel.h
//  ColorStar
//
//  Created by 陶涛 on 2020/8/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface CSUserModel : CSBaseModel

@property (nonatomic, strong)NSString * add_ip;

@property (nonatomic, strong)NSString * avatar;

@property (nonatomic, strong)NSString * grade_id;

@property (nonatomic, strong)NSString * userId;

@property (nonatomic, assign)NSInteger is_promoter;

@property (nonatomic, strong)NSString * last_ip;

@property (nonatomic, strong)NSString * last_time;

@property (nonatomic, assign)NSInteger  level;

@property (nonatomic, strong)NSString * money;

@property (nonatomic, strong)NSString * nickname;

@property (nonatomic, strong)NSString * phone;

@property (nonatomic, strong)NSString * pwd;

@property (nonatomic, strong)NSString * spread_id;

@property (nonatomic, assign)NSInteger  status;

@property (nonatomic, assign)NSInteger  uid;

@property (nonatomic, assign)BOOL isMember;//是否是会员

@property (nonatomic, strong)NSString * gold_num;

@end

NS_ASSUME_NONNULL_END
