//
//  UIButton+CS.h
//  ColorStar
//
//  Created by gavin on 2020/8/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, YMMButtonImageTitleStyle ) {
    YMMButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
    YMMButtonImageTitleStyleLeft  = 0,         //图片在左，文字在右，整体居中。
    YMMButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
    YMMButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
    YMMButtonImageTitleStyleBottom    = 4,     //图片在下，文字在上，整体居中。
    YMMButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上距离按钮顶部。
    YMMButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    YMMButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    YMMButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    YMMButtonImageTitleStyleRightLeft = 9,     //图片在右，文字在左，距离按钮两边边距
    YMMButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
};


@interface UIButton (CS)

/*
 * 设置四边统一的触摸边界
 */
- (void)setTouchEdgeWithUnifyValue:(CGFloat)unifyValue;

/*
 * 设置四边的触摸边界
 */
- (void)setTouchEnlargeEdge:(UIEdgeInsets)edgeInsets;

/*
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的间隔。
 
 */
-(void)setYMMButtonImageTitleStyle:(YMMButtonImageTitleStyle)style
                           padding:(CGFloat)padding;


@end


