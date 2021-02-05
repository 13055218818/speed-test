//
//  CSLiveSurfaceView.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTutorLiveModel.h"
typedef enum : NSUInteger {
    CSTutorLiveSurfaceViewTypeBack,//返回
} CSTutorLiveSurfaceViewType;

typedef void(^CSTutorLiveSurfaceViewBlock)(CSTutorLiveSurfaceViewType type);

@interface CSTutorLiveSurfaceView : UIView

@property (nonatomic, strong)CSTutorLiveModel  * liveModel;

@property (nonatomic, copy)CSTutorLiveSurfaceViewBlock surfaceBlock;

@property (nonatomic, strong)NSArray  * vistors;

@end


