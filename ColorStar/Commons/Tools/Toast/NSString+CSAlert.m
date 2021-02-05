//
//  NSString+CSAlert.m
//  ColorStar
//
//  Created by gavin on 2020/8/15.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "NSString+CSAlert.h"
#import <WHToast.h>

@implementation NSString (CSAlert)

- (void)showAlert{
    
    [WHToast showMessage:self duration:1.5 finishHandler:nil];
}

@end
