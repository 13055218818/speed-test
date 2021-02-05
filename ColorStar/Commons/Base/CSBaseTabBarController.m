//
//  CSBaseTabBarController.m
//  ColorStar
//
//  Created by gavin on 2020/8/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTabBarController.h"
#import "CSBaseNavigationController.h"
#import "CSMineViewController.h"
#import "CSLoginManager.h"
#import "CSNewLoginViewController.h"
@interface CSBaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation CSBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#121827"]];
    [UITabBar appearance].translucent = NO;
    self.delegate = self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    if ([viewController isKindOfClass:[CSBaseNavigationController class]]) {
//        CSBaseNavigationController * nvc = (CSBaseNavigationController*)viewController;
//        if ([nvc.visibleViewController isKindOfClass:[CSNewMineViewController class]]) {
////            CSNewLoginViewController *vc =[CSNewLoginViewController new];
////            vc.modalPresentationStyle=UIModalPresentationFullScreen;
////            [self presentViewController:vc animated:YES completion:nil];
//            [[CSNewLoginUserInfoManager sharedManager] goToLogin];
//        }
//    }
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

@end
