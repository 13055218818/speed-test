//
//  CSBaseIPopupView.h
//  ColorStar
//
//  Created by gavin on 2020/12/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPopupMaskConfig.h"

typedef void(^PopupMaskViewDismissedBlock)(void);


@protocol CSBaseIPopupView <NSObject>

/// 外部接收蒙版消失回调
@property (nonatomic, copy) PopupMaskViewDismissedBlock dismissedBlock;


#pragma mark - 基本能力方法

-(BOOL) isRun;

- (void)addCompletion:(void(^)(void))completion
           dismission:(void(^)(void))dismission;

-(void) show;

-(void) setMaskConfig:(CSPopupMaskConfig *) config;

-(CSPopupMaskConfig *) getMaskConfig;

-(void) initSubview;

-(UIView *) contentView;


#pragma mark - 生命周期
/**
 *  蒙板加载视图 (重载后请调用super方法)
 */
- (void)cs_loadView;

/**
 *  蒙板将要显示时被调用
 */
- (void)cs_maskWillAppear;

/**
 *  蒙板正在显示时被调用
 */
- (void)cs_maskDoAppear;

/**
 *  蒙板已显示时被调用
 */
- (void)cs_maskDidAppear;

/**
 *  蒙板将要消失时被调用
 */
- (void)cs_maskWillDisappear;

/**
 *  蒙板正在消失时被调用
 */
- (void)cs_maskDoDisappear;

/**
 *  蒙板已消失时被调用
 */
- (void)cs_maskDidDisappear;

-(void) cs_doDismiss;

/**
*  解散弹出式蒙板视图,重改结束回调
*/
- (void)cs_doDismiss:(void(^)(void))dismission;

@end
