//
//  CSLiveRewardModel.m
//  ColorStar
//
//  Created by gavin on 2020/10/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveRewardModel.h"
#import <YYModel.h>

@implementation CSLiveRewardDetailModel


@end

@implementation CSLiveRewardModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"rewardId":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"list" : [CSLiveRewardDetailModel class]};
}

@end
