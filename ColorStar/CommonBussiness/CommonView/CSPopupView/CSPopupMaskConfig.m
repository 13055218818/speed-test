//
//  CSPopupMaskConfig.m
//  ColorStar
//
//  Created by gavin on 2020/12/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSPopupMaskConfig.h"

@implementation CSPopupMaskConfig

-(instancetype)init {
    self = [super init];
    if (self) {
        self.maskColor = [UIColor clearColor];
        self.superView = [UIApplication sharedApplication].keyWindow;
        self.offsetInsets = UIEdgeInsetsZero;
        self.tapToDismiss = NO;
        self.animationDuration = .2f;
        self.completion = nil;
        self.dismiss = nil;
    }
    return self;
}

@end
