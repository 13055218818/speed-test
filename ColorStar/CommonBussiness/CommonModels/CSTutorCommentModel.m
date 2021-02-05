//
//  CSTutorCommonModel.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/23.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorCommentModel.h"
#import <YYModel/YYModel.h>

@implementation CSTutorCommonReplyModel


@end

@implementation CSTutorCommentModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"commonId":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"down_info" : [CSTutorCommentModel class]};
}

@end

