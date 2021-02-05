//
//  CSLiveGiftCountSelecteView.h
//  ColorStar
//
//  Created by gavin on 2020/10/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLiveGiftCountSelecteView : UIView

/**
 *  创建一个弹出下拉控件
 *
 *  @param point      箭头
 *  @param selectData 选择控件的数据源
 *  @param action     点击回调方法
 *  @param animate    是否动画弹出
 */
+ (void)addGiftCountSelecteViewWithPoint:(CGPoint)point
                                   selectData:(NSArray *)selectData
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate;
/**
 *  手动隐藏
 */
+ (void)hiden;
@end


