//
//  CSCalendarNewsModel.m
//  ColorStar
//
//  Created by gavin on 2020/11/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCalendarNewsModel.h"
#import "CSCalendarNewsInfoModel.h"
#import <YYModel/YYModel.h>

@implementation CSCalendarNewsModel

//+ (NSDictionary *)modelCustomPropertyMapper{
//    return @{@"modelId":@"id"};
//}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"day_list" : [CSCalendarNewsInfoModel class],@"month_list":[CSCalendarNewsInfoModel class]};
}

@end
