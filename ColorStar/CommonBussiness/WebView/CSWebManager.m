//
//  CSWebManager.m
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSWebManager.h"
#import "CSWebViewController.h"


CSWebManager * manager = nil;
@implementation CSWebManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSWebManager alloc]init];
    });
    return manager;
}
- (void)enterLoginProtoclWebVCWithURL:(NSString*)url title:(NSString*)title withSupVC:(UIViewController*)vc{
    CSWebViewController * webVC = [[CSWebViewController alloc]init];
    webVC.titleStr = title;
    webVC.url = url;
    webVC.isPresent = YES;
    webVC.modalPresentationStyle=UIModalPresentationFullScreen;
    [vc presentViewController:webVC animated:YES completion:nil];
}
- (void)enterWebVCWithURL:(NSString*)url title:(NSString*)title withSupVC:(UIViewController*)vc{
    CSWebViewController * webVC = [[CSWebViewController alloc]init];
    webVC.titleStr = title;
    webVC.url = url;
    [vc.navigationController pushViewController:webVC animated:YES];
}
- (void)enterWebVCWithURL:(NSString*)url title:(NSString*)title withSupVC:(UIViewController*)vc successComplete:(CSWebManagerPaySuccess)successBlock{
    
    CSWebViewController * webVC = [[CSWebViewController alloc]init];
    webVC.payBlock = ^(BOOL success) {
        successBlock(success);
    };
    webVC.titleStr = title;
    webVC.url = url;
    [vc.navigationController pushViewController:webVC animated:YES];
    
}



@end
