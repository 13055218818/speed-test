//
//  CSNewLoginUserInfoManager.m
//  ColorStar
//
//  Created by apple on 2020/12/7.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewLoginUserInfoManager.h"
#import "CsLoginEnglishViewController.h"
static CSNewLoginUserInfoManager * manager = nil;
@implementation CSNewLoginUserInfoManager
+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSNewLoginUserInfoManager alloc]init];
    });
    return manager;
}
- (void)goToLogin:(CSNewLoginUserInfoManagerBlock) block{
    if ([CSAPPConfigManager sharedConfig].languageType == CSAPPLanuageTypeCN) {
        CSNewLoginViewController *vc = [CSNewLoginViewController new];
        vc.loginBlock = ^(BOOL success) {
            if (!success) {
                [self outLogin];
            }
            block(success);
        };
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [[CSTotalTool getCurrentShowViewController] presentViewController:vc animated:YES completion:nil];
    }else{
        CsLoginEnglishViewController *vc = [CsLoginEnglishViewController new];
        vc.LoginEnglishBlock = ^(BOOL success) {
            if (!success) {
                [self outLogin];
            }
            block(success);
        };
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [[CSTotalTool getCurrentShowViewController] presentViewController:vc animated:YES completion:nil];
    }
   
}
- (void)cheackToken{
    if ([CSAPPConfigManager sharedConfig].sessionKey.length > 0) {
        [[CSNewLoginNetManager sharedManager] getUserInfoWithTokenComplete:^(CSNetResponseModel * _Nonnull response) {
            if (response.code == 200) {
                NSDictionary  *dict = response.data;
                CSNewLoginModel *model= [CSNewLoginModel yy_modelWithDictionary:dict];
                [CSNewLoginUserInfoManager sharedManager].userInfo = model;
            }else{
                [self outLogin];
            }
            
            
        } failureComplete:^(NSError * _Nonnull error) {
            [self outLogin];
        }];
    }
}

- (void)outLogin{
    self.userInfo = nil;
    [[CSAPPConfigManager sharedConfig] storeSessionKey:@""];
}

- (BOOL)isLogin{
    return self.userInfo != nil;
}
@end
