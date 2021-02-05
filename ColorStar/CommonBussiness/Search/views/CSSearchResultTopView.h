//
//  CSSearchHeaderView.h
//  ColorStar
//
//  Created by gavin on 2020/11/28.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CSSearchHeaderClickTypeSpecial,
    CSSearchHeaderClickTypeCourse,
} CSSearchHeaderClickType;

typedef void(^CSSearchHeaderClick)(CSSearchHeaderClickType clickType);

@interface CSSearchResultTopView : UIView

@property (nonatomic, copy)CSSearchHeaderClick headerClick;


- (void)specialClick;

- (void)courseClick;

@end


