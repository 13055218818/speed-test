//
//  CSNewCourseViewPageCell.h
//  ColorStar
//
//  Created by apple on 2020/11/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewCourseModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewCourseViewPageCellClickBlock)(CSNewCourseListInfoTaskListModel *model);

@interface CSNewCourseViewPageCell : UICollectionViewCell
@property (nonatomic ,strong)UIImageView            *headImageView;
@property (nonatomic ,strong)UIImageView            *statuImageView;
@property (nonatomic ,strong)UILabel                *moreLabel;
@property(nonatomic, strong)CSNewCourseModel  *model;
@property (nonatomic, copy)CSNewCourseViewPageCellClickBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
