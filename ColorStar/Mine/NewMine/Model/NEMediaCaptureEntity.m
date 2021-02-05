//
//  NEMediaCaptureEntity.m
//  ColorStar
//
//  Created by apple on 2021/1/11.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "NEMediaCaptureEntity.h"

@implementation NEMediaCaptureEntity

+ (instancetype)sharedInstance {
    static NEMediaCaptureEntity *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
@end
