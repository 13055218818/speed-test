//
//  CSNetworkManager.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetResponseModel.h"
@class AFHTTPSessionManager;
typedef NS_ENUM(NSUInteger, CSRegisterLoginType) {
    CSRegisterTypeTelephone = 0,//手机号注册
    CSRegisterTypeEmail,//邮箱注册
};

typedef void(^CSNetWorkSuccessCompletion)(CSNetResponseModel * response);
typedef void(^CSNetWorkFailureCompletion)(NSError * error);



@interface CSNetworkManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong)NSString * baseURL;

@property (nonatomic, strong)NSString * sessionKey;

@property (nonatomic, strong)AFHTTPSessionManager  * netManager;
///首页数据
- (void)getHomeInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;


///获取查看页面分类数据
- (void)getTopLevelCategoriesSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取查看页面二级分类数据
- (void)getSecondLevelCategoriesWithCategoryId:(NSString*)categoryId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取查看页面详细数据
- (void)getTopicListWithCategoryId:(NSString*)categoryId page:(NSInteger)page successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///查询搜索热词
- (void)getSearchHotWordsSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///搜索接口
- (void)getSearchResultWithWord:(NSString*)words successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;


///注册接口
- (void)registerWithType:(CSRegisterLoginType)type account:(NSString*)account code:(NSString*)code password:(NSString*)password successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///登陆接口
- (void)loginWithType:(CSRegisterLoginType)type account:(NSString*)account password:(NSString*)password code:(NSString*)code successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///自动登陆接口
- (void)autoLoginSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取验证码
- (void)quaryCodeWithType:(CSRegisterLoginType)type account:(NSString*)account successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;


///获取艺人详情接口
- (void)quaryArtorDetail:(NSString*)artorId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;


///获取收藏列表
- (void)quaryFavoriteListSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取浏览记录
- (void)quaryBrowseListSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取购买记录
- (void)quaryPurchaseListSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取用户协议的内容
- (void)quaryUserProtocalInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;


///获取关于我们的信息
- (void)quaryAboutUSInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///收藏接口
- (void)addOrRemoveFavoriteInfoWithArtorId:(NSString*)artorId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取收藏和记录数目
- (void)quaryMyInfoNumberSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取首页更多的数据
- (void)quaryHomeMoreInitInfoWithType:(NSString*)type title:(NSString*)title recommandId:(NSString*)recommandId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取会员界面信息
- (void)quaryMemberInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;


///获取直播界面信息
- (void)quaryLiveInfoWithStreamName:(NSString*)streamName successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///发送消息时上传服务器
- (void)uploadMessage:(NSString*)message liveId:(NSString*)liveId messageType:(NSString*)messageType successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///赠送礼物时上传服务器
- (void)uploadGift:(NSString*)giftId gitfNum:(NSString*)giftNum liveId:(NSString*)liveId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取配置项

- (void)getThirdTabInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

- (void)netGetWithURL:(NSString*)url param:(NSDictionary*)param successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

- (void)baseFetchInfo:(NSString*)url param:(NSDictionary*)param successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

//设置环境
- (void)getBaseUrlSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;
@end


