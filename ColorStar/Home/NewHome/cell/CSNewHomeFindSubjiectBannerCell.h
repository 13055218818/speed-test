//
//  CSNewHomeFindSubjiectBannerCell.h
//  ColorStar
//
//  Created by apple on 2020/11/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSNewHomeFindSubjiectBannerCell : UICollectionViewCell
@property(nonatomic, strong)UIImageView *topImageView;
@property(nonatomic, strong)UILabel  *nameLabel;
@property(nonatomic, strong)UILabel *rightTimeLabel;
@property(nonatomic, strong)UIView  *colorView;
@property(nonatomic, strong)UILabel *detailLabel;
@property(nonatomic, strong)CSNewHomeRecommendModel *model;
@end

NS_ASSUME_NONNULL_END
