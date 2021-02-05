//
//  CSCourseBasicModel.m
//  ColorStar
//
//  Created by gavin on 2020/8/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseBasicModel.h"
#import <YYModel.h>
@implementation CSCourseBasicModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"courseId":@"id"};
}

@end
