//
//  CSAPPConfigManager.h
//  ColorStar
//
//  Created by gavin on 2020/8/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, CSAPPLanuageType) {
    CSAPPLanuageTypeCN = 0,//中文
    CSAPPLanuageTypeOther,//大图
};

typedef NS_ENUM(NSUInteger, CSAPPNetWorkEnvironment) {
    CSAPPNetWorkEnvironmentTest = 0,//测试
    CSAPPNetWorkEnvironmentRelease,//发布
};


@interface CSAPPConfigManager : NSObject

@property (nonatomic, strong, readonly)NSString * baseURL;

@property (nonatomic, assign, readonly)CSAPPNetWorkEnvironment  currentNetWork;

@property (nonatomic, assign)CSAPPLanuageType  languageType;

@property (nonatomic, strong)NSString          * userProtocal;

@property (nonatomic, strong)NSString          * aboutUS;

@property (nonatomic, strong)NSString * sessionKey;

+ (instancetype)sharedConfig;

- (void)getBaseConfig;

- (void)storeSessionKey:(NSString*)sessionKey;

- (void)configNetWork:(CSAPPNetWorkEnvironment)environment;

@end


