//
//  UIViewController+CS.m
//  ColorStar
//
//  Created by gavin on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "UIViewController+CS.h"

@implementation UIViewController (CS)
+ (UIViewController *)currentViewController{
    UIViewController *resultVC;
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    if ([window subviews].count == 0) {
        return nil;
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        resultVC = nextResponder;
    } else {
        resultVC = window.rootViewController;
    }
    
    BOOL isContinue = YES;
    
    while (isContinue) {
        if ([resultVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navController = (UINavigationController *)resultVC;
            resultVC = navController.visibleViewController;
        } else if ([resultVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabBarController = (UITabBarController *)resultVC;
            resultVC = tabBarController.selectedViewController;
        } else if (resultVC.presentedViewController) {
            resultVC = resultVC.presentedViewController;
        } else {
            isContinue = NO;
        }
    }
    
    return resultVC;
}
@end
