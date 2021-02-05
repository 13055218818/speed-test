//
//  CSNewHomeNetManager.h
//  ColorStar
//
//  Created by apple on 2020/11/24.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CSNetWorkSuccessCompletion)(CSNetResponseModel * response);
typedef void(^CSNetWorkFailureCompletion)(NSError * error);

@interface CSNewHomeNetManager : NSObject
+ (instancetype)sharedManager;

@property (nonatomic, strong)AFHTTPSessionManager  * netManager;

//首页推荐数据
- (void)getHomeRecommendInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//首页推荐列表数据获取
- (void)getHomeRecommendListSuccessWithDict:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//首页推荐精选列表数据获取
- (void)getHomeRecommendBestListSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//首页发现数据
- (void)getHomeFindInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//发现列表数据获取
- (void)getFindLiveInfoListSuccessWithDict:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//首页直播数据
- (void)getHomeLiveInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//直播列表数据获取
- (void)getHomeLiveInfoListSuccessWithDict:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
//艺人专题关注
- (void)getHomeaddFollowSuccessId:(NSString *)classId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
@end

NS_ASSUME_NONNULL_END
