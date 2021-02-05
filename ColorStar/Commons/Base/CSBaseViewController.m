//
//  CSBaseViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseViewController.h"

@interface CSBaseViewController ()

@property (nonatomic, strong)UIView  * netEmptyView;

@end

@implementation CSBaseViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    
    UIImage * backImage = [UIImage imageNamed:@"cs_nav_back"];
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(cs_doBack) forControlEvents:UIControlEventTouchUpInside];
    backBtn.bounds = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)showProgressHUD
{
    [[CSTotalTool sharedInstance] showHudInView:self.view hint:@""];
}

- (void)hideProgressHUD{
    [[CSTotalTool sharedInstance] hidHudInView:self.view];
}

- (void)showEmptyView{
    [self.view addSubview:self.netEmptyView];
    [self.view bringSubviewToFront:self.netEmptyView];
}

- (void)hiddenEmptyView{
    [self.netEmptyView removeFromSuperview];
    
}

- (void)cs_doBack {
    if ([[self.navigationController viewControllers] count] == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

#pragma mark -  Properties Method

- (UIView*)netEmptyView{
    if (!_netEmptyView) {
        _netEmptyView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    }
    return _netEmptyView;
}

@end
