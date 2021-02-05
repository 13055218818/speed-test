//
//  CSBasePopupView.h
//  ColorStar
//
//  Created by gavin on 2020/12/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBaseIPopupView.h"

typedef void(^DismissCallback)(void);


@interface CSBasePopupView : UIView <CSBaseIPopupView>


@property (nonatomic) BOOL cs_tapToDismiss;
@property (nonatomic) CGFloat cs_animationDuration;


/**
 *  内容容器视图 （请勿直接将subviews添加在PopupMaskView上，添加到contentView）
 */
@property (nonatomic, strong)UIView *cs_contentView;

/**
 *  显示弹出式蒙板视图
 *
 *  @param view         弹出的父视图
 *  @param offsetInsets 偏移边距
 *  @param maskColor    蒙板颜色
 *  @param completion   显示完成Block
 *  @param dismission   消失完成Block
 */
- (void)cs_showInView:(UIView *)view
          offsetInsets:(UIEdgeInsets)offsetInsets
             maskColor:(UIColor *)maskColor
            completion:(void(^)(void))completion
            dismission:(void(^)(void))dismission;
@end


