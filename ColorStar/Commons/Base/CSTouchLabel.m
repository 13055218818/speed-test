//
//  CSTouchLabel.m
//  ColorStar
//
//  Created by gavin on 2020/11/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTouchLabel.h"


@implementation CSTouchLabel

- (instancetype)init{
    if (self = [super init]) {
        [self addTouchEvent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addTouchEvent];
    }
    return self;
}

- (void)updateAppear{
    
    if (self.selected) {
        self.text = self.selectText;
        self.textColor = self.selectTextColor;
        self.backgroundColor = self.selectBackColor;
        self.layer.borderColor = self.selectBorderColor.CGColor;
    }else{
        self.text = self.normalText;
        self.textColor = self.normalTextColor;
        self.backgroundColor = self.normalBackColor;
        self.layer.borderColor = self.normalBorderColor.CGColor;
    }
    
}

- (void)addTouchEvent{
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    
}

- (void)tap{
    if (self.touch) {
        self.touch(self);
    }
}



@end
