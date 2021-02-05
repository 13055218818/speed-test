//
//  CSNewLoginUserInfoManager.h
//  ColorStar
//
//  Created by apple on 2020/12/7.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNewLoginModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewLoginUserInfoManagerBlock)(BOOL success);
@interface CSNewLoginUserInfoManager : NSObject
@property (nonatomic, strong)CSNewLoginModel * userInfo;
@property (nonatomic, strong)CSNewLoginVersionModel * currentAppVersionInfo;
//@property (nonatomic, copy)CSNewLoginUserInfoManagerBlock LoginUserInfoManagerBlock;
+ (instancetype)sharedManager;

- (void)goToLogin:(CSNewLoginUserInfoManagerBlock) block;

- (BOOL)isLogin;

- (void)outLogin;

- (void)cheackToken;
@end

NS_ASSUME_NONNULL_END
