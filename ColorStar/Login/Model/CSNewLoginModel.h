//
//  CSNewLoginModel.h
//  ColorStar
//
//  Created by apple on 2020/12/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSNewLoginModel : NSObject
@property (nonatomic, strong)NSString           *uid;
@property (nonatomic, strong)NSString           *account;
@property (nonatomic, strong)NSString           *nickname;
@property (nonatomic, strong)NSString           *avatar;
@property (nonatomic, strong)NSString           *phone;
@property (nonatomic, strong)NSString           *now_money;
@property (nonatomic, strong)NSString           *overdue_time;
@property (nonatomic, strong)NSString           *wx_name;
@property (nonatomic, strong)NSString           *is_vip;
@property (nonatomic, strong)NSString           *gold_name;
@property (nonatomic, strong)NSString           *collectionNumber;
@property (nonatomic, strong)NSString           *rechargeMoney;
@property (nonatomic, strong)NSString           *spread_code;
@property (nonatomic, strong)NSString           *spread_uid;
@property (nonatomic, strong)NSString           *is_live;
@end

@interface CSNewLoginVersionModel : NSObject
@property (nonatomic, strong)NSString           *version_code;
@property (nonatomic, strong)NSString           *version_name;
@property (nonatomic, strong)NSString           *version_content;
@property (nonatomic, strong)NSString           *version_ios_code;
@property (nonatomic, assign)BOOL               is_update;//强制更新
@property (nonatomic, assign)BOOL               is_needUpdate;//
@property (nonatomic, assign)BOOL               ios_hide;
@end

NS_ASSUME_NONNULL_END
