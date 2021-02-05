//
//  MyCell.h
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CSHomeRecommendInterestingBannerCellDelegate <NSObject>

- (void)deleteCellWith:(CSNewHomeRecommendInterstingModel *)model;

@end
@interface CSHomeRecommendInterestingBannerCell : UICollectionViewCell

@property(nonatomic,strong)UIButton                     *deleteButton;
@property (nonatomic, strong)UIImageView                *headImage;
@property (nonatomic, strong)UIImageView                *headRaiduImage;
@property(nonatomic,strong)UILabel                      *nameLabel;
@property(nonatomic,strong)UIButton                     *tagButton;
@property(nonatomic,strong)UIButton                     *attentionButton;
@property(nonatomic, weak)id<CSHomeRecommendInterestingBannerCellDelegate> delegate;
@property(nonatomic, strong)CSNewHomeRecommendInterstingModel  *model;
@end

NS_ASSUME_NONNULL_END
