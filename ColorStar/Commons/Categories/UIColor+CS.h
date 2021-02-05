//
//  UIColor+CS.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CS)


/// 颜色转图片
- (UIImage *)image;

/**
 *  根据十六进制获取颜色
 *
 *  @param hexValue   十六进制 0x111111
 *  @param alphaValue  透明度
 *
 *  @return color
 */
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

/**
 *  根据十六进制获取颜色
 *
 *  @param hexValue 十六进制
 *
 *  @return color
 */
+ (UIColor *)colorWithHex:(NSInteger)hexValue;


/**
 *  //从十六进制字符串获取颜色，
 //color:支持@“#123456”、 @“0X123456”、@“0x123456”、 @“123456”四种格式
 *
 *  @param color color description
 *
 *  @return return value description
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 *  //从十六进制字符串获取颜色，
 //color:支持@“#123456”、 @“0X123456”、@“0x123456”、 @“123456”四种格式
 *
 *  @param color color description
 *  @param alpha alpha description
 *
 *  @return return value description
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
