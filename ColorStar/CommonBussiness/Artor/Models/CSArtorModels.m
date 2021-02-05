//
//  CSArtorModels.m
//  ColorStar
//
//  Created by gavin on 2020/8/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSArtorModels.h"
#import <YYModel.h>

@implementation CSArtorCourseRowModel


- (CSCourseType)courseType{
    if (self.type == 1) {
        return CSCourseTypeImageText;
    }else if (self.type == 2){
        return CSCourseTypeAudio;
    }else if (self.type == 3){
        return CSCourseTypeVideo;
    }
    return CSCourseTypeNone;
}

@end

@implementation CSArtorCourseSectionModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"list" : [CSArtorCourseRowModel class]};
}

@end

@implementation CSArtorSpecialDetailProfileModel


@end

@implementation CSArtorSpecialDetailModel

- (NSString*)price{
    if ([self.money isEqualToString:@"0.00"]) {
        return @"免费";
    }
    return self.money;
}

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"specialId":@"id"};
}


@end

@implementation CSArtorSpecialModel


@end

@implementation CSArtorDetailModel


@end
