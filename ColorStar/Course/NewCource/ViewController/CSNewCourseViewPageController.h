//
//  CSNewCourseViewPageController.h
//  ColorStar
//
//  Created by apple on 2020/11/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
#import "CSNewCourseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSNewCourseViewPageController : UIViewController <JXCategoryListContentViewDelegate>
@property (nonatomic, strong)NSString  *order;//1:全部2:最新3:最热
@property (nonatomic, strong)CSNewCourseCategoryModel   *categoryModel;
@property (nonatomic, strong)NSString  *titleStr;
- (void)loadDataForFirst;
- (void)loadData;
@end

NS_ASSUME_NONNULL_END
