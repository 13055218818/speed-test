//
//  CSTutorVideoModel.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/23.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorVideoModel.h"
#import <YYModel/YYModel.h>
#import "CSTutorCommentModel.h"
@implementation CSTutorVideoModel

//+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
//    return @{@"taskInfo":[CSTutorTaskInfo class],@"specialInfo":[CSTutorSpecialInfo class]};
//}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"discussList" : [CSTutorCommentModel class],@"specialList":[CSTutorMasterCourse class]};
}

@end

@implementation CSTutorTaskInfo
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"taskInfoId":@"id"};
}

@end


@implementation CSTutorSpecialInfo


@end

@implementation CSTutorMasterCourse

@end
