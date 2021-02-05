//
//  CSTutorCustomControlView.h
//  ColorStar
//
//  Created by gavin on 2020/12/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayerMediaControl.h>
#import <ZFPlayer/ZFSliderView.h>

typedef void(^CSTutorCustomControlBackBlock)(void);
@interface CSTutorCustomControlView : UIView <ZFPlayerMediaControl>

/// 滑杆
@property (nonatomic, strong) ZFSliderView *slider;

/// 控制层自动隐藏的时间，默认2.5秒
@property (nonatomic, assign) NSTimeInterval autoHiddenTimeInterval;

/// 控制层显示、隐藏动画的时长，默认0.25秒
@property (nonatomic, assign) NSTimeInterval autoFadeTimeInterval;

@property (nonatomic, copy) CSTutorCustomControlBackBlock backBlock;

@end


