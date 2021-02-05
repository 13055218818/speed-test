//
//  CSCourseSwitchView.h
//  ColorStar
//
//  Created by gavin on 2020/8/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CSCourseSwitchBlock)(NSInteger index);

@interface CSCourseSwitchView : UIView

@property (nonatomic, copy)CSCourseSwitchBlock switchBlock;


@end


