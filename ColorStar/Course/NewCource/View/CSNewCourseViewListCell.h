//
//  CSNewCourseViewListCell.h
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewCourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSNewCourseViewListCell : UICollectionViewCell
@property(nonatomic, strong)CSNewCourseModel  *model;
@property (nonatomic, strong)UIImageView        *statuImageView;
@end

NS_ASSUME_NONNULL_END
