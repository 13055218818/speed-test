//
//  CSNewHomeFindHotBannerCell.h
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSNewHomeFindHotBannerCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *TextLabel;
@property(nonatomic,strong)UIImageView *bgImage;
@property(nonatomic, strong)CSNewHomeFindHotModel  *model;
@end

NS_ASSUME_NONNULL_END
