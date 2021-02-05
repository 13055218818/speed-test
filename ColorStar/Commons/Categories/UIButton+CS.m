//
//  UIButton+CS.m
//  ColorStar
//
//  Created by gavin on 2020/8/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "UIButton+CS.h"
#import <objc/runtime.h>

static char topEdgeKey;
static char rightEdgeKey;
static char bottomEdgeKey;
static char leftEdgeKey;

@implementation UIButton (CS)

- (void)setTouchEdgeWithUnifyValue:(CGFloat)unifyValue {
    [self setTouchEnlargeEdge:UIEdgeInsetsMake(unifyValue, unifyValue, unifyValue, unifyValue)];
}

- (void)setTouchEnlargeEdge:(UIEdgeInsets)edgeInsets {
    objc_setAssociatedObject(self, &topEdgeKey, @(edgeInsets.top), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rightEdgeKey, @(edgeInsets.right), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bottomEdgeKey, @(edgeInsets.bottom), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &leftEdgeKey, @(edgeInsets.left), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGRect)ymm_touchRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topEdgeKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightEdgeKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomEdgeKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftEdgeKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x + leftEdge.floatValue,
                          self.bounds.origin.y + topEdge.floatValue,
                          self.bounds.size.width - (leftEdge.floatValue + rightEdge.floatValue),
                          self.bounds.size.height - (topEdge.floatValue + bottomEdge.floatValue));
    }
    else
    {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self ymm_touchRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}


- (void)setYMMButtonImageTitleStyle:(YMMButtonImageTitleStyle)style
                           padding:(CGFloat)padding {
    if (self.imageView.image != nil && self.titleLabel.text != nil)
    {
        //先还原
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        
        CGRect imageRect = self.imageView.frame;
        CGRect titleRect = self.titleLabel.frame;
        
        CGFloat totalHeight = imageRect.size.height + padding + titleRect.size.height;
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        
        switch (style) {
            case YMMButtonImageTitleStyleLeft:
                if (padding != 0)
                {
                    self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                            padding/2,
                                                            0,
                                                            -padding/2);
                    
                    self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                            -padding/2,
                                                            0,
                                                            padding/2);
                }
                break;
            case YMMButtonImageTitleStyleRight:
            {
                //图片在右，文字在左
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                        -(imageRect.size.width + padding/2),
                                                        0,
                                                        (imageRect.size.width + padding/2));
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (titleRect.size.width+ padding/2),
                                                        0,
                                                        -(titleRect.size.width+ padding/2));
            }
                break;
            case YMMButtonImageTitleStyleTop:
            {
                //图片在上，文字在下
                self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                        (selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2,
                                                        -((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                        -(selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                        (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        -((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                        -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
                
            }
                break;
            case YMMButtonImageTitleStyleBottom:
            {
                //图片在下，文字在上。
                self.titleEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                        (selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                        -(selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                        (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        -((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                        -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case YMMButtonImageTitleStyleCenterTop:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y - padding),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        (titleRect.origin.y - padding),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case YMMButtonImageTitleStyleCenterBottom:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake((selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -(selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case YMMButtonImageTitleStyleCenterUp:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake(-(titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        (titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case YMMButtonImageTitleStyleCenterDown:
            {
                self.titleEdgeInsets = UIEdgeInsetsMake((imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                        (selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -(imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                        -(selfWidth / 2 -  titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case YMMButtonImageTitleStyleRightLeft:
            {
                //图片在右，文字在左，距离按钮两边边距
                
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                        -(titleRect.origin.x - padding),
                                                        0,
                                                        (titleRect.origin.x - padding));
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth - padding - imageRect.origin.x - imageRect.size.width),
                                                        0,
                                                        -(selfWidth - padding - imageRect.origin.x - imageRect.size.width));
            }
                
                break;
                
            case YMMButtonImageTitleStyleLeftRight:
            {
                //图片在左，文字在右，距离按钮两边边距
                
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth - padding - titleRect.origin.x - titleRect.size.width),
                                                        0,
                                                        -(selfWidth - padding - titleRect.origin.x - titleRect.size.width));
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        -(imageRect.origin.x - padding),
                                                        0,
                                                        (imageRect.origin.x - padding));
                
                
                
            }
                break;
            default:
                break;
        }
    }
    else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

@end
