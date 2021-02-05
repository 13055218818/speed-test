//
//  UILabel+CS.m
//  ColorStar
//
//  Created by gavin on 2020/8/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "UILabel+CS.h"
#import <objc/runtime.h>

#pragma mark - UIEdgeInsets

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}
@implementation UILabel (CS)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(drawTextInRect:), @selector(ymm_drawTextInRect:));
        ReplaceMethod([self class], @selector(sizeThatFits:), @selector(ymm_sizeThatFits:));
    });
}

- (void)ymm_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.ymm_contentInsets;
    [self ymm_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)ymm_sizeThatFits:(CGSize)size {
    UIEdgeInsets insets = self.ymm_contentInsets;
    size = [self ymm_sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(insets), size.height-UIEdgeInsetsGetVerticalValue(insets))];
    size.width += UIEdgeInsetsGetHorizontalValue(insets);
    size.height += UIEdgeInsetsGetVerticalValue(insets);
    return size;
}

const void *kAssociatedYf_contentInsets;

- (void)setYmm_contentInsets:(UIEdgeInsets)ymm_contentInsets {
    objc_setAssociatedObject(self, &kAssociatedYf_contentInsets, [NSValue valueWithUIEdgeInsets:ymm_contentInsets] , OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)ymm_contentInsets {
    return [objc_getAssociatedObject(self, &kAssociatedYf_contentInsets) UIEdgeInsetsValue];
}


#pragma mark - AttributedString

- (void)setLabelAttributedText:(NSMutableDictionary *)dict {
    if (dict) {
        NSString *allText = [dict objectForKey:@"allText"];
        NSString *setText = [dict objectForKey:@"setText"];
        float setFontSize = [[dict objectForKey:@"setFontSize"] floatValue];
        UIColor *setColor = [dict objectForKey:@"setColor"];
        
        NSRange textRange = [allText rangeOfString:setText];
        if (textRange.location != NSNotFound) {
            NSMutableAttributedString *attributedString =
            [[NSMutableAttributedString alloc]
             initWithString:allText];
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:setColor
                                     range:textRange];
            [attributedString addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:setFontSize]
                                     range:textRange];
            [self setAttributedText:attributedString];
        }
    }
}



- (void)setLabelMutilAttributed:(NSString *)allText optionArray:(NSMutableArray *)array
{
    if (allText && array) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                       initWithString:allText];
        for (NSDictionary *dict in array) {
            NSString *setText = [dict objectForKey:@"setText"];
            float setFontSize = [[dict objectForKey:@"setFontSize"] floatValue];
            UIColor *setColor = [dict objectForKey:@"setColor"];
            NSRange textRange = [allText rangeOfString:setText];
            
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:setColor
                                     range:textRange];
            [attributedString addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:setFontSize]
                                     range:textRange];
            [self setAttributedText:attributedString];
        }
    }
}

- (void)setLabelAttributedBySameText:(NSMutableDictionary *)dict withExeceptString:(NSString *)exceptString {

    if (dict) {
        NSString *allText = [dict objectForKey:@"allText"];
        NSString *setText = [dict objectForKey:@"setText"];
        float setFontSize = [[dict objectForKey:@"setFontSize"] floatValue];
        UIColor *setColor = [dict objectForKey:@"setColor"];
        
        unichar setChar = [setText characterAtIndex:0];
        NSMutableAttributedString *attributedString =
        [[NSMutableAttributedString alloc]
         initWithString:allText];
        NSInteger initIndex = exceptString.length;
        for (NSUInteger i = initIndex; i < allText.length; i++) {
            unichar c = [allText characterAtIndex:i];
            if (c == setChar) {
                NSRange textRange = NSMakeRange(i, 1);
                [attributedString addAttribute:NSForegroundColorAttributeName
                                         value:setColor
                                         range:textRange];
                [attributedString addAttribute:NSFontAttributeName
                                         value:[UIFont systemFontOfSize:setFontSize]
                                         range:textRange];
            }
        }
        
        [self setAttributedText:attributedString];
    }
}

// 设置UILabel行间距
- (void)setLabelLineSpacing:(CGFloat)lineSpace {
    if (self.text && 0 < [self.text length]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        
        NSDictionary *attributes = @{NSFontAttributeName:self.font,
                                     NSParagraphStyleAttributeName:paragraphStyle,
                                     NSForegroundColorAttributeName:self.textColor};
         NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text attributes:attributes];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)setLabelLineSpacingWithOption:(NSDictionary *)optionDict {
    if (optionDict) {
        NSString *setText = [optionDict objectForKey:@"setText"];
        NSTextAlignment textAlignment = [[optionDict objectForKey:@"textAlignment"] integerValue];
        NSInteger lineSpacing = [[optionDict objectForKey:@"lineSpacing"] integerValue];
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = textAlignment;
        paraStyle.lineSpacing = lineSpacing;
        paraStyle.hyphenationFactor = 1.0;
        paraStyle.firstLineHeadIndent = 0.0;
        paraStyle.paragraphSpacingBefore = 0.0;
        paraStyle.headIndent = 0;
        paraStyle.tailIndent = 0;
        
        NSDictionary *dic = @{NSParagraphStyleAttributeName:paraStyle};
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:setText attributes:dic];
        self.attributedText = attributeStr;
    }
}

@end
