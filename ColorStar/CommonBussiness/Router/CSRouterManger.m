//
//  CSRouterManger.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSRouterManger.h"
#import "CSWebManager.h"
#import "AppDelegate.h"
#import "CSBaseTabBarController.h"
#import "CSCourseViewController.h"
#import "CSBaseNavigationController.h"

CSRouterManger * manger = nil;
@implementation CSRouterManger

+ (instancetype)sharedManger{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[CSRouterManger alloc]init];
    });
    return manger;
}

- (void)enterWebVCWithURL:(NSString*)url title:(NSString*)title{
    [[CSWebManager sharedManager] enterWebVCWithURL:url title:title withSupVC:[self currentVC]];
}

- (void)selecteCartegoryId:(NSString*)categoryId{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CSBaseTabBarController * tabBar = (CSBaseTabBarController*)delegate.window.rootViewController;
    tabBar.selectedIndex = 1;
    CSCourseViewController * courseVC =(CSCourseViewController*) ((CSBaseNavigationController*)[tabBar.viewControllers objectAtIndex:1]).topViewController;
    [courseVC selecteCategoryId:categoryId];
    
}

- (void)pushToVC:(UIViewController*)VC{
    [self.currentVC.navigationController pushViewController:VC animated:YES];
}

- (UIViewController*)currentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}
@end
