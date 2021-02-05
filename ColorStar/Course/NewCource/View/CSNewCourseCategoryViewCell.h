//
//  CSNewCourseCategoryViewCell.h
//  ColorStar
//
//  Created by apple on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewCourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSNewCourseCategoryViewCell : UITableViewCell
@property (nonatomic, strong)UILabel            *categoryLabel;
@property (nonatomic, strong)CSNewCourseCategoryModel *model;
@end

NS_ASSUME_NONNULL_END
