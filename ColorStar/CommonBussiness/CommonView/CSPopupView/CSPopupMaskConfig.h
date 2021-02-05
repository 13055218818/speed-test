//
//  CSPopupMaskConfig.h
//  ColorStar
//
//  Created by gavin on 2020/12/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CSPopupCompletionBlock)(void);


@interface CSPopupMaskConfig : NSObject

@property (nonatomic, strong) UIColor *maskColor;//蒙层背景

@property (nonatomic, strong) UIView *superView;//创建在view上

@property (nonatomic) UIEdgeInsets offsetInsets;

/**
 *  是否点击即消失,默认是NO
 */
@property (nonatomic) BOOL tapToDismiss;

/**
 *  动画持续时间
 */
@property (nonatomic)CGFloat animationDuration;


@property (copy, nonatomic) CSPopupCompletionBlock completion;
@property (copy, nonatomic) CSPopupCompletionBlock dismiss;

@end


