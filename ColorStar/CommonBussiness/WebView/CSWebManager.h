//
//  CSWebManager.h
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^CSWebManagerPaySuccess)(BOOL success);
@interface CSWebManager : NSObject

+ (instancetype)sharedManager;
- (void)enterLoginProtoclWebVCWithURL:(NSString*)url title:(NSString*)title withSupVC:(UIViewController*)vc;
- (void)enterWebVCWithURL:(NSString*)url title:(NSString*)title withSupVC:(UIViewController*)vc;
- (void)enterWebVCWithURL:(NSString*)url title:(NSString*)title withSupVC:(UIViewController*)vc successComplete:(CSWebManagerPaySuccess)successBlock;

@end


