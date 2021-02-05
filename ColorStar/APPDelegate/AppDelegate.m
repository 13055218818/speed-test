//
//  AppDelegate.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "AppDelegate.h"
#import "CSBaseTabBarController.h"
#import "CSBaseNavigationController.h"
#import "CSCourseViewController.h"
#import "CSMallViewController.h"
#import "CSMineViewController.h"
#import "CSGuideViewController.h"
#import "CSStorgeManager.h"
#import <IQKeyboardManager.h>
#import "CSNetworkManager.h"
#import "CSAPPConfigManager.h"
#import "CSLoginManager.h"
#import "CSIMManager.h"
#import <AFNetworking.h>
#import "CSAPPUpdateView.h"
#import "NSString+CS.h"
#import <FBSDKCoreKit/FBSDKApplicationDelegate.h>
#import <FBSDKCoreKit/FBSDKSettings.h>
#import <GoogleSignIn/GIDSignIn.h>
#import <GoogleSignIn/GIDSignInButton.h>

static NSString *kFacebookAppID = @"2720252414877942";
@interface AppDelegate ()<WXApiDelegate,GIDSignInDelegate>
@property (nonatomic, strong)CSBaseTabBarController  * rootTabBarVC;
@property (nonatomic, strong)GIDSignInButton         *gooleSignButton;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[CSAPPConfigManager sharedConfig] getBaseConfig];    
    [GIDSignIn sharedInstance].clientID = @"319571751817-f65ad4ldputb666u3jqpmbd7lrdluf2k.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].delegate = self;
    [[IQKeyboardManager sharedManager] setEnable:YES];
    //微信注册
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //w2a.w2am.icolorstar.com  applinks:m.icolorstar.cn/
    [WXApi registerApp:@"wx535b41071df3bf64" universalLink:@"https://m.icolorstar.cn"];
    [[CSAPPConfigManager sharedConfig] configNetWork:CSAPPNetWorkEnvironmentRelease];
    [[CSNewLoginUserInfoManager sharedManager] cheackToken];
    [self checkAPPVersion];
    [[CSStorgeManager sharedManager] quarySearchHotWords];
    
    //test.icolorstar.com applinks:color.ehxkc.com/
//    [WXApi registerApp:@"wxd3eee679076f7379" universalLink:@"https://color.ehxkc.com"];
//    [[CSAPPConfigManager sharedConfig] configNetWork:CSAPPNetWorkEnvironmentTest];
//    [[CSNewLoginUserInfoManager sharedManager] cheackToken];
//    [self checkAPPVersion];
//    [[CSStorgeManager sharedManager] quarySearchHotWords];
    
    return YES;
}


//facebook
- (BOOL)application:(nonnull UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *, id> *)options {
    if ([url.host isEqualToString:@"oauth"]){//微信登录
        return [WXApi handleOpenURL:url delegate:self];
    }
    else if([url.absoluteString containsString:kFacebookAppID]){
        return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
        
        // return [[GIDSignIn sharedInstance] handleURL:url];
        
    }else{
        return [[GIDSignIn sharedInstance] handleURL:url];
    }
    return YES;
}


//  ios(4.2, 9.0)
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    if ([url.absoluteString containsString:kFacebookAppID]) {
        return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }else if([url.host isEqualToString:@"oauth"]){
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        return [[GIDSignIn sharedInstance] handleURL:url];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler
{
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}



- (void)onResp:(BaseResp *)resp{
    
    // =============== 获得的微信登录授权回调 ============
    if ([resp isMemberOfClass:[SendAuthResp class]])  {
        NSLog(@"******************获得的微信登录授权******************");
        
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode != 0 ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // [self showError:@"微信授权失败"];
            });
            return;
        }
        //授权成功获取 OpenId
        NSString *code = aresp.code;
        NSLog(@"+++++++%@",code);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"weiChatOK" object:code];
    }
    
}


- (void)setupTabbar:(BOOL)ios_hid{
    CSNewHomeViewController * csHomeVC = [[CSNewHomeViewController alloc]init];
    CSBaseNavigationController * csHomeNVC = [[CSBaseNavigationController alloc]initWithRootViewController:csHomeVC];
    csHomeNVC.tabBarItem.image = [UIImage imageNamed:@"CS_tab_NewHome_unSelect"];
    csHomeNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"CS_tab_NewHome_select"];
    csHomeNVC.tabBarItem.title = NSLocalizedString(@"彩色世界", nil);
    
    CSNewCourseViewController * csCourseVC = [[CSNewCourseViewController alloc]init];
    CSBaseNavigationController * csCourseNVC = [[CSBaseNavigationController alloc]initWithRootViewController:csCourseVC];
    csCourseNVC.tabBarItem.image = [UIImage imageNamed:@"CS_tab_NewCourse_unSelect"];
    csCourseNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"CS_tab_NewCourse_select"];
    csCourseNVC.tabBarItem.title = NSLocalizedString(@"课程", nil);
    
    CSNewShopViewController * csShopVC = [[CSNewShopViewController alloc]init];
    CSBaseNavigationController * csShopNVC = [[CSBaseNavigationController alloc]initWithRootViewController:csShopVC];
    csShopNVC.tabBarItem.image = [UIImage imageNamed:@"CS_tab_NewShop_unSelect"];
    csShopNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"CS_tab_NewShop_select"];
    csShopNVC.tabBarItem.title = NSLocalizedString(@"商城", nil);
    
    CSNewMineViewController * mineVC = [[CSNewMineViewController alloc]init];
    CSBaseNavigationController * mineNVC = [[CSBaseNavigationController alloc]initWithRootViewController:mineVC];
    mineNVC.tabBarItem.image = [UIImage imageNamed:@"CS_tab_NewMine_unSelect"];
    mineNVC.tabBarItem.selectedImage = [UIImage imageNamed:@"CS_tab_NewMine_select"];
    mineNVC.tabBarItem.title = NSLocalizedString(@"我的", nil);
    
    self.rootTabBarVC = [[CSBaseTabBarController alloc]init];
    if (ios_hid) {
        self.rootTabBarVC.viewControllers = @[csHomeNVC,csCourseNVC,mineNVC];
    }else{
        self.rootTabBarVC.viewControllers = @[csHomeNVC,csCourseNVC,csShopNVC,mineNVC];
    }
    
    if ([[CSStorgeManager sharedManager] needGuide]) {
        CSGuideViewController * guideVC = [[CSGuideViewController alloc]init];
        guideVC.complete = ^(BOOL complete) {
            if (complete) {
                [[CSStorgeManager sharedManager] hasGuide];
                self.window.rootViewController = self.rootTabBarVC;
            }
        };
        self.window.rootViewController = guideVC;
        [self.window makeKeyAndVisible];
        
    }else{
        self.window.rootViewController = self.rootTabBarVC;
        [self.window makeKeyAndVisible];
    }
    
}


- (void)checkAPPVersion{
    [[CSNewLoginNetManager sharedManager] getNewVersionInfoComplete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            NSDictionary  *dict = response.data;
            CSNewLoginVersionModel  *model = [CSNewLoginVersionModel yy_modelWithDictionary:dict];
            NSString *currentVerdionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            if ([[CSTotalTool sharedInstance] versionCompareFirst:model.version_ios_code andVersionSecond:currentVerdionStr]) {
                model.is_needUpdate = YES;
            }else{
                model.is_needUpdate = NO;
            }
            [CSNewLoginUserInfoManager sharedManager].currentAppVersionInfo = model;
            [self setupTabbar:model.ios_hide];
        }else{
            [self setupTabbar:YES];
        }
    } failureComplete:^(NSError * _Nonnull error) {
        [self setupTabbar:YES];
    }];
    
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    // 可以这么写
    if (self.allowOrentitaionRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
}

@end
