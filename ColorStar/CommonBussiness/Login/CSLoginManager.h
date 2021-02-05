//
//  CSLoginManager.h
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSBlockList.h"
#import "CSUserModel.h"

@interface CSLoginManager : NSObject

@property (nonatomic, strong)CSUserModel * userInfo;

+ (instancetype)sharedManager;

- (void)tryLoginOrRegisterComplete:(CSLoginComplete)complete;

- (void)autoLogin;

- (BOOL)isLogin;

@end


