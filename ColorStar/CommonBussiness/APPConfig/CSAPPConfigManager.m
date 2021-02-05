//
//  CSAPPConfigManager.m
//  ColorStar
//
//  Created by gavin on 2020/8/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSAPPConfigManager.h"
#import "CSNetworkManager.h"
#import "CSColorStar.h"

#define baseTestUrl  @"https://color.ehxkc.com"
#define baseReleaseUrl @"https://m.icolorstar.cn"
#define baseENReleaseUrl @"http://m.color-world.pro"

@interface CSAPPConfigManager ()

@property (nonatomic, strong)NSString  * currentLanauage;

@property (nonatomic, strong)NSString  * currentRegion;

@property (nonatomic, strong)NSString  * baseURL;

@property (nonatomic, assign)CSAPPNetWorkEnvironment  currentNetWork;


@end

static CSAPPConfigManager * config = nil;
@implementation CSAPPConfigManager

+ (instancetype)sharedConfig{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[CSAPPConfigManager alloc]init];
        
    });
    return config;
}

- (instancetype)init{
    if (self = [super init]) {
        self.baseURL = baseReleaseUrl;
    }
    return self;
}

- (void)getBaseConfig{
    [self getCurrentDeviceInfo];
    [self getUserProtocal];
    [self getAboutUSInfo];
}

- (void)getCurrentDeviceInfo{
    
    // iOS 获取设备当前语言的代码
    self.currentLanauage = [[[NSBundle mainBundle] preferredLocalizations] firstObject];
    
     // iOS 获取设备当前地区的代码
    self.currentRegion = [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier];

}

- (void)getUserProtocal{
    
    CS_Weakify(self, weakSelf);
    [[CSNetworkManager sharedManager] quaryUserProtocalInfoSuccessComplete:^(CSNetResponseModel *response) {
        weakSelf.userProtocal = response.msg;
        
    } failureComplete:^(NSError *error) {
        
    }];
    
}

- (void)getAboutUSInfo{
    
    CS_Weakify(self, weakSelf);
    [[CSNetworkManager sharedManager] quaryAboutUSInfoSuccessComplete:^(CSNetResponseModel *response) {
        weakSelf.aboutUS = response.msg;
        
    } failureComplete:^(NSError *error) {
        
    }];
}

- (void)configNetWork:(CSAPPNetWorkEnvironment)environment{
    self.currentNetWork = environment;
    if (self.currentNetWork == CSAPPNetWorkEnvironmentTest) {
        self.baseURL = baseTestUrl;
    }else if (self.currentNetWork == CSAPPNetWorkEnvironmentRelease){
        if (self.languageType == CSAPPLanuageTypeCN) {
            self.baseURL = baseReleaseUrl;
        }else{
            self.baseURL = baseENReleaseUrl;
        }
    }
    
}

- (void)storeSessionKey:(NSString*)sessionKey{
    
    [[NSUserDefaults standardUserDefaults] setObject:sessionKey forKey:@"CS_AutoLogin_SessionKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)sessionKey{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CS_AutoLogin_SessionKey"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"CS_AutoLogin_SessionKey"];
    }else{
        return @"";
    }
    
}

- (CSAPPLanuageType)languageType{
//    return CSAPPLanuageTypeCN;
    return [self.currentLanauage isEqualToString:@"zh-Hans"] ? CSAPPLanuageTypeCN : CSAPPLanuageTypeOther;
}

@end
