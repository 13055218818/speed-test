//
//  CSFollowButton.h
//  ColorStar
//
//  Created by gavin on 2020/12/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CSFollowButtonSearch,
    CSFollowButtonNormal,
    CSFollowButtonVideo,
} CSFollowButtonType;

@interface CSFollowButton : UIButton

+ (CSFollowButton*)creatButton;

@property (nonatomic, assign)CGFloat viewHeight;

@property (nonatomic, assign)CGFloat fontSize;

@property (nonatomic, assign)CGFloat sideMargin;

@property (nonatomic, assign)CSFollowButtonType type;

@property (nonatomic, assign)BOOL   isFollow;

- (void)setup;
@end


