//
//  CSCalendarNewsInfoModel.m
//  ColorStar
//
//  Created by gavin on 2020/11/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCalendarNewsInfoModel.h"

@implementation CSCalendarNewsInfoModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"newsId":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"label" : [NSString class]};
}

@end
