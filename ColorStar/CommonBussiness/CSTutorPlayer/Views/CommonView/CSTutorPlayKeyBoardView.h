//
//  CSVideoKeyBoardView.h
//  ColorStar
//
//  Created by gavin on 2020/11/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CSTutorPlayKeyBoardBlockTypeComment,
    CSTutorPlayKeyBoardBlockTypeScroll,
} CSTutorPlayKeyBoardBlockType;

typedef void(^CSTutorPlayKeyBoardBlock)(CSTutorPlayKeyBoardBlockType type);

@interface CSTutorPlayKeyBoardView : UIView

@property (nonatomic, strong)CSTutorPlayKeyBoardBlock  keyboardBlock;

@property (nonatomic, strong)UIImageView  * avtorImageView;


@end


