//
//  CSLiveUserInputView.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CSTutorLiveSurfaceBottomTypeKeyBoard,//键盘
    CSTutorLiveSurfaceBottomTypeGift,//礼物
    CSTutorLiveSurfaceBottomTypeAttention,//关注
    CSTutorLiveSurfaceBottomTypeShare,//分享
} CSTutorLiveSurfaceBottomType;

typedef void(^CSTutorLiveSurfaceBottomBlock)(CSTutorLiveSurfaceBottomType type,id obj);

@interface CSTutorLiveSurfaceBottomView : UIView

@property (nonatomic, copy)CSTutorLiveSurfaceBottomBlock clickBlock;

@property (nonatomic, assign)BOOL  hasAttention;
@end


