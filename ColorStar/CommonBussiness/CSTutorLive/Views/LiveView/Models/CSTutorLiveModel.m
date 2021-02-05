//
//  CSTutorLiveDetailModel.m
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveModel.h"

@implementation CSTutorLiveModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"live_gift":[CSTutorLiveGiftDetailModel class]};
}

@end


@implementation CSTutorLiveGoldModel


@end

@implementation CSTutorLiveInfoModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"liveId":@"id"};
}

- (NSString*)topic{
    return [@"room" stringByAppendingString:self.liveId];
}

@end

@implementation CSTutorCommentListModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"list" : [CSTutorCommentDetailModel class]};
}

@end

@implementation CSTutorCommentDetailModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"commonId":@"id"};
}

@end

@implementation CSTutorLiveGiftDetailModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"giftId":@"id"};
}

@end

@implementation CSTutorLiveRewardModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"list" : [CSTutorLiveRewardDetailModel class]};
}

@end

@implementation CSTutorLiveRewardDetailModel


@end


@implementation CSTutorLiveUserTotalModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"list" : [CSTutorLiveUserModel class]};
}

@end

@implementation CSTutorLiveUserModel


@end
