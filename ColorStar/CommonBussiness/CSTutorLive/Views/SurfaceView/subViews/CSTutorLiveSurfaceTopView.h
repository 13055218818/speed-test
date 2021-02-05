//
//  CSLiveAnchorInfoView.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTutorLiveModel.h"

typedef enum : NSUInteger {
    CSTutorLiveSurfaceTopViewBlockTypeFollow,
    CSTutorLiveSurfaceTopViewBlockTypeMore,
    CSTutorLiveSurfaceTopViewBlockTypeBack,
} CSTutorLiveSurfaceTopViewBlockType;

typedef void(^CSTutorLiveSurfaceTopViewBlock)(CSTutorLiveSurfaceTopViewBlockType type);

@interface CSTutorLiveSurfaceTopView : UIView

@property (nonatomic, strong)YYLabel * visitorNumLabel;

- (void)mockData;

@property (nonatomic, strong)CSTutorLiveModel  *liveModel;

@property (nonatomic, strong)NSArray  * vistors;

@property (nonatomic, copy)CSTutorLiveSurfaceTopViewBlock topBlock;

@property (nonatomic, assign)NSInteger clickCount;

- (void)clickLike;

@end


