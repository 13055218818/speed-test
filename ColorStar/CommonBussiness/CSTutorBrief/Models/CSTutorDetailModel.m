//
//  CSTutorDetailModel.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/23.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorDetailModel.h"
#import <YYModel/YYModel.h>
#import "CSTutorCommentModel.h"


@implementation CSTutorDetailModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"task_list" : [CSTutorCourseModel class],@"round_tasks":[CSTutorCourseModel class],@"discuss_list":[CSTutorCommentModel class],@"label":[NSString class],@"banner":[NSString class],};
}

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"tutorId":@"id"};
}

- (BOOL)showBanner{
    return self.banner.count >= 5;
}

@end


@implementation CSTutorCourseModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"courseId":@"id"};
}

@end

