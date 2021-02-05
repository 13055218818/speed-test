//
//  DLBaseTableViewCell.m
//  整理
//
//  Created by 周冰烽 on 2020/7/6.
//  Copyright © 2020 周冰烽. All rights reserved.
//

#import "DLBaseTableViewCell.h"
#import "UIImage+GKCategory.h"
#import "UIColor+DLGlobalColor.h"

@implementation DLBaseTableViewCell

// 分割线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor screenColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor lineColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(10, rect.size.height - 1, ScreenW, 1.0));
}

@end
