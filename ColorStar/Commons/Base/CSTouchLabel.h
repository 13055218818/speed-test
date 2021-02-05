//
//  CSTouchLabel.h
//  ColorStar
//
//  Created by gavin on 2020/11/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchEvent)(UIView * obj);

@interface CSTouchLabel : UILabel

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, strong)NSString  * normalText;

@property (nonatomic, strong)UIColor   * normalTextColor;

@property (nonatomic, strong)UIColor   * normalBackColor;

@property (nonatomic, strong)UIColor   * normalBorderColor;

@property (nonatomic, strong)NSString  * selectText;

@property (nonatomic, strong)UIColor   * selectTextColor;

@property (nonatomic, strong)UIColor   * selectBackColor;

@property (nonatomic, strong)UIColor   * selectBorderColor;

@property (nonatomic, copy)TouchEvent    touch;

- (void)updateAppear;

@end


