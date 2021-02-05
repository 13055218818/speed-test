//
//  CSColorStar.h
//  ColorStar
//
//  Created by gavin on 2020/8/8.
//  Copyright © 2020 gavin. All rights reserved.
//

#ifndef CSColorStar_h
#define CSColorStar_h


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define heightScale ([UIScreen mainScreen].bounds.size.height/812.0)
#define widthScale  ([UIScreen mainScreen].bounds.size.width/375.0)


#define CS_Weakify(oriInstance, weakInstance) __weak typeof(oriInstance) weakInstance = oriInstance;

//frame
#define Frame(x,y,width,height)  CGRectMake(x, y, width, height)

//最大最小值
#define MaxX(frame) CGRectGetMaxX(frame)
#define MaxY(frame) CGRectGetMaxY(frame)
#define MinX(frame) CGRectGetMinX(frame)
#define MinY(frame) CGRectGetMinY(frame)

//宽度高度
#define Width(frame)    CGRectGetWidth(frame)
#define Height(frame)   CGRectGetHeight(frame)

//16进制颜色
#define UICOLOR_RGB_Alpha(_color,_alpha) [UIColor colorWithRed:((_color>>16)&0xff)/255.0f green:((_color>>8)&0xff)/255.0f blue:(_color&0xff)/255.0f alpha:_alpha]
//分割线
#define  UILineColor           UICOLOR_RGB_Alpha(0xe6e6e6,1)
//主白色
#define  UIMainWhiteColor  [UIColor whiteColor]
//主背景色
#define UIMainBackColor UICOLOR_RGB_Alpha(0xf0f0f0,1)

#define IsIphoneX          ScreenW < 375.0

#define SizeScale           (IsIphoneX ? 0 : 2)

//#define kFontSize(value)    value*SizeScale

#define kFont(value)        [UIFont systemFontOfSize:value-SizeScale]
//设置字体
#define FontSet(fontSize)  [UIFont systemFontOfSize:fontSize]

///  View加边框
#define ViewBorder(View, BorderColor, BorderWidth )\
\
View.layer.borderColor = BorderColor.CGColor;\
View.layer.borderWidth = BorderWidth;

/// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//加载本地图片
#define LoadImage(imageName) [UIImage imageNamed:imageName]

#define LoadColor(colorName) [UIColor colorWithHexString:colorName]
#define LoadFont(font)   [UIFont systemFontOfSize:font]
#define EmptyColor  LoadColor(@"#E7E8EA")

#define kSafeAreaBottomHeight (ScreenH >= 812. ? 34.f : 0.f)
#define kStatusBarHeight CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
#define kNavigationHeight (kStatusBarHeight + 44.0f)

/*TabBar高度*/
#define kTabBarHeight (ScreenH >= 812. ? (34.f + 49.f) : 49.f)
#define kTabBarStatusHeight (ScreenH >= 812. ? 34.f : 0)

#define csnation(string)  NSLocalizedString(string, nil)

#endif /* CSColorStar_h */
