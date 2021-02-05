//
//  CSTutorLiveManager.m
//  ColorStar
//
//  Created by gavin on 2020/12/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveManager.h"
#import "CSNetworkManager.h"
#import "CSTutorLiveModel.h"

static CSTutorLiveManager * manager = nil;
@implementation CSTutorLiveManager

+ (instancetype)shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSTutorLiveManager alloc]init];
    });
    return manager;
}

- (void)fetchLiveInfo:(NSString*)streamName liveId:(NSString*)liveId specialId:(NSString*)specialId complete:(CSTutorLiveComplete)complete{
    
    NSString * url = @"/wap/live/jsondata/api/liveDetail";
    NSDictionary * dict = @{@"stream_name":streamName,@"live_id":liveId,@"special_id":specialId};
    
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:dict successComplete:^(CSNetResponseModel *response) {
            
        if (complete && response) {
            complete(response,nil);
        }
        } failureComplete:^(NSError *error) {
            if (complete && error) {
                complete(nil,error);
            }
        }];
    
}

- (void)fetchVistors:(NSString*)roomId complete:(CSTutorLiveComplete)complete{
    NSString * url = @"/wap/live/jsondata/api/getNowUser";
    NSDictionary * dict = @{@"room_id":roomId};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:dict successComplete:^(CSNetResponseModel *response) {
            
        if (complete && response) {
            complete(response,nil);
        }
        } failureComplete:^(NSError *error) {
            if (complete && error) {
                complete(nil,error);
            }
        }];
}

- (void)followOrLikeLive:(NSString*)liveId complete:(CSTutorLiveComplete)complete{
    NSString * url = @"/wap/live/jsondata/api/addLiveFollow";
    NSDictionary * dict = @{@"id":liveId};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:dict successComplete:^(CSNetResponseModel *response) {
            
        if (complete && response) {
            complete(response,nil);
        }
        } failureComplete:^(NSError *error) {
            if (complete && error) {
                complete(nil,error);
            }
        }];
    
    
}

- (void)uploadLiveCount:(NSInteger)clickCount liveId:(NSString*)liveId complete:(CSTutorLiveComplete)complete{
    
    NSString * url = @"/wap/live/jsondata/api/addLiveClicks";
    NSDictionary * dict = @{@"id":liveId,@"count":[@(clickCount) stringValue]};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:dict successComplete:^(CSNetResponseModel *response) {
            
        if (complete && response) {
            complete(response,nil);
        }
        } failureComplete:^(NSError *error) {
            if (complete && error) {
                complete(nil,error);
            }
        }];
    
}


- (NSString*)loadGiftImageURL:(NSString*)giftId gitfList:(NSArray*)giftList{
    NSString * url = nil;
    for (CSTutorLiveGiftDetailModel * gift in giftList) {
        if ([gift.giftId isEqualToString:giftId]) {
            url = gift.live_gift_show_img;
            break;
        }
    }
    return url;
}

- (NSString*)loadGiftName:(NSString*)giftId gitfList:(NSArray*)giftList{
    NSString * name = nil;
    for (CSTutorLiveGiftDetailModel * gift in giftList) {
        if ([gift.giftId isEqualToString:giftId]) {
            name = gift.live_gift_name;
            break;
        }
    }
    return name;
}

@end
