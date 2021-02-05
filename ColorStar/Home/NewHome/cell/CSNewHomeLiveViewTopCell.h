//
//  CSNewHomeLiveViewTopCell.h
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewHomeLiveViewTopCellTagsViewClickBlock)(CSNewHomeLiveTagModel *model);
@interface CSNewHomeLiveViewTopCell : UICollectionViewCell
@property (nonatomic, strong)NSMutableArray   *tagsArray;
@property (nonatomic, strong)NSMutableArray   *bannerArray;
@property (nonatomic, copy)CSNewHomeLiveViewTopCellTagsViewClickBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
