//
//  CSNewCourseCategoryView.h
//  ColorStar
//
//  Created by apple on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSNewCourseModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNewCourseCategoryViewClickBlock)(CSNewCourseCategoryModel *model);
@interface CSNewCourseCategoryView : UIView
-(void)showView;
@property (nonatomic, copy)CSNewCourseCategoryViewClickBlock clickBlock;
- (void)refreshUIWith:(NSMutableArray *)arrray;
@end

NS_ASSUME_NONNULL_END
