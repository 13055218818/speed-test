//
//  CSMemberModel.m
//  ColorStar
//
//  Created by gavin on 2020/9/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMemberModel.h"
#import <YYModel/YYModel.h>

@implementation CSMemberBaseInfoModel


@end

@implementation CSMemberInterestModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"interestId":@"id"};
}

@end

@implementation CSMemberDescriptionModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"descriptId":@"id"};
}

@end

@implementation CSMemberVipInfoModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"vipId":@"id"};
}

@end

@implementation CSMemberFreeDataBaseModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"freeId":@"id"};
}

@end

@implementation CSMemberFreeDataModel


@end

@implementation CSMemberModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"sectionId":@"id",@"descs":@"description"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"interests" : [CSMemberInterestModel class],@"description" : [CSMemberDescriptionModel class],};
}

@end
