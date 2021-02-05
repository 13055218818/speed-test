//
//  CSHomeCategoryCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSHomeCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSHomeCategoryCell : UICollectionViewCell

- (void)configModel:(CSHomeCategoryModel*)model;

@end

NS_ASSUME_NONNULL_END
