//
//  CSHomeCategoryModel.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeCategoryModel.h"
#import <YYModel.h>

@implementation CSHomeCategoryModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"categoryId":@"id"};
}


@end
