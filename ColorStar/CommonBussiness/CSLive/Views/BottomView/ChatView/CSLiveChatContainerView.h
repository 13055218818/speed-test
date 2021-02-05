//
//  CSLiveChatContainerView.h
//  ColorStar
//
//  Created by gavin on 2020/10/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLiveModel.h"

@interface CSLiveChatContainerView : UIView

@property (nonatomic, strong)CSLiveModel   * liveModel;

- (void)registeKeyBoard;

@end


