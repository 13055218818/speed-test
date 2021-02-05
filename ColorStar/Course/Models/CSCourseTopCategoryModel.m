//
//  CSCourseTopCategoryModel.m
//  ColorStar
//
//  Created by gavin on 2020/8/7.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseTopCategoryModel.h"
#import <YYModel.h>

@implementation CSCourseTopCategoryModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"categoryId":@"id"};
}

@end
