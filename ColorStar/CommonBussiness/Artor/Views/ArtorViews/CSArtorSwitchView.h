//
//  CSArtorSwitchView.h
//  ColorStar
//
//  Created by gavin on 2020/8/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CSArtorSwitchBlock)(NSInteger index);

@interface CSArtorSwitchView : UIView

@property (nonatomic, copy)CSArtorSwitchBlock switchBlock;

@property (nonatomic, assign)BOOL isLive;

@end


