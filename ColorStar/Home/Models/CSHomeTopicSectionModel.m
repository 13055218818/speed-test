//
//  CSHomeTopicSectionModel.m
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeTopicSectionModel.h"
#import <YYModel.h>
#import "CSHomeTopicBaseModel.h"


@implementation CSHomeTopicSectionModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"sectionId":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"list" : [CSHomeTopicBaseModel class]};
}

- (CSHomeTopicSectionType)sectionType{
    if ([self.typesetting isEqualToString:@"1"]) {
        return CSHomeTopicSectionTypeBig;
    }else if ([self.typesetting isEqualToString:@"2"]){
        return CSHomeTopicSectionTypeSquare;
    }else if ([self.typesetting isEqualToString:@"3"]){
        return CSHomeTopicSectionTypeSmall;
    }else if ([self.typesetting isEqualToString:@"4"]){
        return CSHomeTopicSectionTypeCheck;
    }
    return CSHomeTopicSectionTypeNone;
}

- (BOOL)showHead{
    return NO;
}


@end
