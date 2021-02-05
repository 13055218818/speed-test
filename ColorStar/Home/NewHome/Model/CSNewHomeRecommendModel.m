//
//  CSNewHomeRecommendModel.m
//  ColorStar
//
//  Created by apple on 2020/11/24.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeRecommendModel.h"

@implementation CSNewHomeRecommendModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"specialId":@"id"};
}
@end

@implementation CSNewHomeRecommendBannerModel : NSObject
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"bannerId":@"id"};
}
@end

@implementation CSNewHomeRecommendDayModel : NSObject
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"dayId":@"id"};
}

@end

@implementation CSNewHomeRecommendInterstingModel : NSObject

@end

@implementation CSNewHomeRecommendGuitarListModel : NSObject
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"guitarId":@"id"};
}
@end

@implementation CSNewHomeRecommendGuitarModel : NSObject

@end

@implementation CSNewHomeFindWeekModel : NSObject


@end

@implementation CSNewHomeFindHotModel : NSObject
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"hot_id":@"id"};
}
@end

@implementation CSNewHomeFindstudyModel : NSObject
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"study_id":@"id"};
}
@end


@implementation CSNewHomeLiveBannerModel : NSObject
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"banner_id":@"id"};
}
@end


@implementation CSNewHomeLiveTagModel : NSObject
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"subjectId":@"id"};
}
@end

@implementation CSNewHomeLiveListModel : NSObject
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"liveListId":@"id"};
}
@end
