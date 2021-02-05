//
//  CSHomePressCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSHomePressModel.h"

typedef void(^CSHomePressClick)(CSHomePressModel * _Nullable pressModel);
NS_ASSUME_NONNULL_BEGIN

@interface CSHomePressCell : UICollectionViewCell

@property (nonatomic,copy)CSHomePressClick  pressClick;

- (void)loadMockData;

- (void)configPresses:(NSArray*)presses;

@end

NS_ASSUME_NONNULL_END
