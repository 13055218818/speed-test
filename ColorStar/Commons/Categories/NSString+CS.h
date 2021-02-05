//
//  NSString+CS.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CS)

/// 判断是否为空
+ (BOOL)isNilOrEmpty:(NSString *)str;

/**
 *  根据字体大小和高度获取宽度
 *
 *  @param heightValue 高度
 *  @param font        字体大小
 *
 *  @return 计算后文本的Size
 */
- (CGSize)textSizeWithHeight:(CGFloat)heightValue
                    withFont:(UIFont *)font;

- (CGSize)textSizeWithWidth:(CGFloat)widthValue
                    withFont:(UIFont *)font;

- (NSString*)getPrice;

- (NSString*)getCourse;

- (NSString*)getStudyTimes;

- (NSString*)getPlayCount;



/**
 *  校验邮箱格式
 *
 *  @param email 邮箱
 *
 *  @return 是否为邮箱格式
 */
+ (BOOL)cs_isEmail:(NSString *)email;

/**
 *  严格校验手机号码格式
 *
 *  @param mobileNum 手机号码
 *
 *  @return 是否为严格手机号码格式
 */
+ (BOOL)cs_isMobileNumber:(NSString *)mobileNum;

+ (NSString*)cs_getMonthEngish:(NSString*)month;

@end

NS_ASSUME_NONNULL_END
