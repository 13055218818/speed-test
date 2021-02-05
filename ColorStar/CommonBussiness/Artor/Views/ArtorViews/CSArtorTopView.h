//
//  CSArtorTopView.h
//  ColorStar
//
//  Created by gavin on 2020/8/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSArtorModels.h"

@interface CSArtorTopView : UIView

- (instancetype)initWithModel:(CSArtorDetailModel*)detailModel;

@property (nonatomic, assign)BOOL  isLive;

@end


