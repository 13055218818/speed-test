//
//  CSArtorDetailNavView.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSFollowButton.h"

typedef enum : NSUInteger {
    CSTutorDetailNavBlockTypeBack,//返回
    CSTutorDetailNavBlockTypeShare,//分享
    CSTutorDetailNavBlockTypeFollow,//关注
} CSTutorDetailNavBlockType;


typedef void(^CSTutorDetailNavBlock)(CSTutorDetailNavBlockType type);

@interface CSTutorDetailNavView : UIView

@property (nonatomic, strong)UILabel  * titleLabel;

@property (nonatomic, strong)CSFollowButton * followBtn;

@property (nonatomic, copy)CSTutorDetailNavBlock     navBlock;

@end


