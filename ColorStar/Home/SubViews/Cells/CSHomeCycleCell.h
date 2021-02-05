//
//  CSHomeCycleCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSHomeCycleModel.h"

typedef void(^CSHomeCycleClick)(CSHomeCycleModel * model);
NS_ASSUME_NONNULL_BEGIN

@interface CSHomeCycleCell : UICollectionViewCell

@property (nonatomic, copy)CSHomeCycleClick  cycleClick;

- (void)loadMockData;

- (void)configModels:(NSArray*)models;

@end

NS_ASSUME_NONNULL_END
