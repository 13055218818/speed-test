//
//  CSRouterManger.h
//  ColorStar
//
//  Created by 陶涛 on 2020/8/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CSRouterManger : NSObject

+ (instancetype)sharedManger;

- (void)enterWebVCWithURL:(NSString*)url title:(NSString*)title;

- (void)selecteCartegoryId:(NSString*)categoryId;

- (void)pushToVC:(UIViewController*)VC;


- (UIViewController*)currentVC;
@end


