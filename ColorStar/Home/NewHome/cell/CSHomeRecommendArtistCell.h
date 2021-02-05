//
//  CSHomeRecommendArtistCell.h
//  ColorStar
//
//  Created by apple on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewHomeRecommendModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol CSHomeRecommendArtistCellDelegate <NSObject>
- (void)CSHomeRecommendArtistCellPlayButton:(CSNewHomeRecommendModel *)model;
@end
@interface CSHomeRecommendArtistCell : UITableViewCell
@property (nonatomic, strong)CSNewHomeRecommendModel  *model;
@property(nonatomic,weak)id<CSHomeRecommendArtistCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
