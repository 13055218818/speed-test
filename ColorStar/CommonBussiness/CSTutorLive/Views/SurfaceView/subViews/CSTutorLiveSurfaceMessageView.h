//
//  CSLiveNewMessageShowView.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTutorLiveMessageModel.h"
#import "CSIMMessageModel.h"
#import "CSIMGiftModel.h"

@interface CSTutorLiveSurfaceMessageView : UIView

- (void)initComments:(NSArray*)comments;

- (void)addComment:(CSIMMessageModel*)comment;

- (void)addGift:(CSIMGiftModel*)gift;
@end


