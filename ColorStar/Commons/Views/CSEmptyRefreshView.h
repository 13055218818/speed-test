//
//  CSEmptyRefreshView.h
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CSHomeRefreshBlock)(void);

@interface CSEmptyRefreshView : UIView

@property (nonatomic, copy)CSHomeRefreshBlock refreshBlock;

@end


