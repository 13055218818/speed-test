//
//  CSLoginManager.m
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLoginManager.h"
#import "CSLoginRegisterViewController.h"
#import "CSRouterManger.h"
#import "CSBaseNavigationController.h"
#import "CSNetworkManager.h"
#import "CSAPPConfigManager.h"
#import <YYModel.h>
#import "CSColorStar.h"

static CSLoginManager * manager = nil;
@implementation CSLoginManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSLoginManager alloc]init];
    });
    return manager;
}

- (void)tryLoginOrRegisterComplete:(CSLoginComplete)complete{
    
    CSLoginRegisterViewController * loginRegistVC = [[CSLoginRegisterViewController alloc]init];
    loginRegistVC.loginComplete = complete;
    CSBaseNavigationController * baseNVC = [[CSBaseNavigationController alloc]initWithRootViewController:loginRegistVC];
    baseNVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [[CSRouterManger sharedManger].currentVC presentViewController:baseNVC animated:YES completion:nil];
    
}

- (void)autoLogin{
    
    CS_Weakify(self, weakSelf);
    [[CSNetworkManager sharedManager] autoLoginSuccessComplete:^(CSNetResponseModel *response) {
        NSDictionary * data = (NSDictionary*)response.data;
        CSUserModel * user = [CSUserModel yy_modelWithDictionary:data];
        weakSelf.userInfo = user;
        
    } failureComplete:^(NSError *error) {
        
    }];
}

- (BOOL)isLogin{
    return self.userInfo != nil;
}

@end
