//
//  CSNewHomeLiveViewTopBannerCell.h
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewShopModel.h"
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSNewHomeLiveViewTopBannerCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic, strong)CSNewShopBannerModel  *model;
@property(nonatomic, strong)CSNewHomeLiveBannerModel  *liveModel;
@end

NS_ASSUME_NONNULL_END
