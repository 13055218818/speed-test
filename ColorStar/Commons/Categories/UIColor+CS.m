//
//  UIColor+CS.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "UIColor+CS.h"

@implementation UIColor (CS)

- (UIImage *)image {
    CGRect frame = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor *)colorWithHex:(NSInteger)hexValue {
    return [UIColor colorWithHex:hexValue alpha:1.0];
}


+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 3 || [cString length] > 8) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if (!([cString length] == 6 || [cString length] == 3)) {
        return [UIColor clearColor];
    }

    if ([cString length] == 6) {
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        //r
        NSString *rString = [cString substringWithRange:range];
        //g
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        //b
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];

        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    } else {
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 1;
        //r
        NSString *rString = [cString substringWithRange:range];
        rString = [NSString stringWithFormat:@"%@%@", rString, rString];
        //g
        range.location = 1;
        NSString *gString = [cString substringWithRange:range];
        gString = [NSString stringWithFormat:@"%@%@", gString, gString];
        //b
        range.location = 2;
        NSString *bString = [cString substringWithRange:range];
        bString = [NSString stringWithFormat:@"%@%@", bString, bString];

        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    }
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1.0f];
}

@end
