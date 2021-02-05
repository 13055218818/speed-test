//
//  CSTutorLiveManager.h
//  ColorStar
//
//  Created by gavin on 2020/12/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetResponseModel.h"

typedef void(^CSTutorLiveComplete)(CSNetResponseModel * response, NSError * error);
@interface CSTutorLiveManager : NSObject

+ (instancetype)shared;

- (void)fetchLiveInfo:(NSString*)streamName liveId:(NSString*)liveId specialId:(NSString*)specialId complete:(CSTutorLiveComplete)complete;

- (void)fetchVistors:(NSString*)roomId complete:(CSTutorLiveComplete)complete;

- (void)followOrLikeLive:(NSString*)liveId complete:(CSTutorLiveComplete)complete;

- (void)uploadLiveCount:(NSInteger)clickCount liveId:(NSString*)liveId complete:(CSTutorLiveComplete)complete;

- (NSString*)loadGiftImageURL:(NSString*)giftId gitfList:(NSArray*)giftList;

- (NSString*)loadGiftName:(NSString*)giftId gitfList:(NSArray*)giftList;

@end


