//
//  CSNewLiveDefinitionView.h
//  ColorStar
//
//  Created by apple on 2021/1/13.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSBasePopupView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CSNewLiveDefinitionViewDelegate <NSObject>
- (void)CSNewLiveDefinitionViewSelectDefinition:(NSInteger)index;
@end
@interface CSNewLiveDefinitionView : CSBasePopupView

@property(nonatomic,weak)id<CSNewLiveDefinitionViewDelegate> delegate;

- (void)refreshDefinitionView:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
