//
//  CSNewCourseModel.m
//  ColorStar
//
//  Created by apple on 2020/11/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewCourseModel.h"


@implementation CSNewCourseListInfoTaskListModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"taskList_id":@"id"};
}
@end
@implementation CSNewCourseListInfoModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"info_id":@"id"};
}
@end

@implementation CSNewCourseModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"courseId":@"id"};
}
@end

@implementation CSNewCourseBannerModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"bannerId":@"id"};
}
@end

@implementation CSNewCourseCategoryModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"categoryId":@"id"};
}
@end

