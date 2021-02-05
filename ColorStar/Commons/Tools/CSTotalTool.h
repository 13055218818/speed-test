//
//  CSTotalTool.h
//  ColorStar
//
//  Created by apple on 2020/11/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CSTotalTool : NSObject
+ (CSTotalTool *)sharedInstance;
//获取字符串宽度
-(CGFloat)getButtonWidth:(NSString *)str WithFont:(CGFloat)font WithLefAndeRightMargin:(CGFloat)margin;
//获取从做至右双色渐变
- (CAGradientLayer *)makeCAGradientLayerFrame:(CGRect)frame  withStartColor:(UIColor *)starColor withEndColor:(UIColor *)endColor;
/**
 切部分圆角
 
 UIRectCorner有五种
 UIRectCornerTopLeft //上左
 UIRectCornerTopRight //上右
 UIRectCornerBottomLeft // 下左
 UIRectCornerBottomRight // 下右
 UIRectCornerAllCorners // 全部
 
 @param cornerRadius 圆角半径
 */
- (void)setPartRoundWithView:(UIView *)view corners:(UIRectCorner)corners cornerRadius:(float)cornerRadius;
//切不同的角
- (void)setCornerWithLeftTopCorner:(CGFloat)leftTop
                    rightTopCorner:(CGFloat)rigtTop
                  bottomLeftCorner:(CGFloat)bottemLeft
                 bottomRightCorner:(CGFloat)bottemRight
                              view:(UIView *)view
                             frame:(CGRect)frame;
//高斯模糊
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hidHudInView:(UIView *)view;

+ (UIViewController *)getCurrentShowViewController;
//获取图片主色
-(UIColor *)mainColorOfImage:(UIImage *)image with:(BOOL)isMain;
//比较版本号
- (BOOL)versionCompareFirst:(NSString *)first andVersionSecond:(NSString *)second;
- (NSString *)convertToJsonData:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
