//
//  CSNewCourseModel.h
//  ColorStar
//
//  Created by apple on 2020/11/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CSNewCourseListInfoTaskListModel : NSObject
@property(nonatomic, strong)NSString            *taskList_id;
@property(nonatomic, strong)NSString            *title;
@property(nonatomic, strong)NSString            *image;
@property(nonatomic, strong)NSString            *play_count;
@property(nonatomic, strong)NSString            *is_show;
@end

@interface CSNewCourseListInfoModel : NSObject
@property(nonatomic, strong)NSString            *info_id;
@property(nonatomic, strong)NSString            *title;
@property(nonatomic, strong)NSString            *image;
@property(nonatomic, strong)NSMutableArray      *label;
@property(nonatomic, strong)NSString            *task_count;
@property(nonatomic, strong)NSString            *play_count;
@property(nonatomic, strong)NSString            *follow_count;
@property(nonatomic, strong)NSString            *is_follow;
@property (nonatomic, strong)NSMutableArray     *task_list;
@end

@interface CSNewCourseModel : NSObject
@property(nonatomic, strong)NSString            *browse_count;
@property(nonatomic, strong)NSString            *image;
@property(nonatomic, strong)NSString            *title;
@property(nonatomic, strong)NSString            *type;
@property(nonatomic, strong)NSString            *money;
@property(nonatomic, strong)NSString            *pink_money;
@property(nonatomic, strong)NSString            *is_pink;
@property(nonatomic, strong)NSString            *subject_id;
@property(nonatomic, strong)NSMutableArray      *label;
@property(nonatomic, strong)NSString            *courseId;
@property(nonatomic, strong)NSString            *count;
@property(nonatomic, strong)NSString            *subject_name;
@property(nonatomic, strong)CSNewCourseListInfoModel            *info;
@end

@interface CSNewCourseBannerModel : NSObject
@property(nonatomic, strong)NSString            *bannerId;
@property(nonatomic, strong)NSString            *title;
@property(nonatomic, strong)NSString            *url;
@property(nonatomic, strong)NSString            *pic;
@end

@interface CSNewCourseCategoryModel : NSObject
@property(nonatomic, strong)NSString            *categoryId;
@property(nonatomic, strong)NSString            *name;
@property(nonatomic, assign)BOOL                 isSelect;
@end

@interface CSNewCourseCategoryPageListModel : NSObject
@property(nonatomic, strong)NSString            *categoryId;
@property(nonatomic, strong)NSString            *name;
@property(nonatomic, assign)BOOL                  isSelect;
@end
NS_ASSUME_NONNULL_END
