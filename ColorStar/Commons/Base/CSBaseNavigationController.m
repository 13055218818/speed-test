//
//  CSBaseNavigationController.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseNavigationController.h"
#import "UIColor+CS.h"


@interface CSBaseNavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic,weak) UIViewController* currentShowViewController;


@end

@implementation CSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#121212"];
    self.navigationBar.translucent = NO;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = YES;
    if ([viewController isKindOfClass:[CSNewHomeViewController class]] || [viewController isKindOfClass:[CSNewCourseViewController class]] || [viewController isKindOfClass:[CSNewShopViewController class]] || [viewController isKindOfClass:[CSNewMineViewController class]]) {
        viewController.hidesBottomBarWhenPushed = NO;
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.viewControllers.count == 1)
        self.currentShowViewController=Nil;
    else
        self.currentShowViewController = viewController;
}
 
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowViewController == self.topViewController); //the most important
    }
    return YES;
}

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

@end
