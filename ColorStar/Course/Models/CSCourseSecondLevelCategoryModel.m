//
//  CSCourseSecondLevelCategoryModel.m
//  ColorStar
//
//  Created by gavin on 2020/8/7.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseSecondLevelCategoryModel.h"
#import <YYModel.h>

@implementation CSCourseSecondLevelCategoryModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"subCategoryId":@"id"};
}


@end
