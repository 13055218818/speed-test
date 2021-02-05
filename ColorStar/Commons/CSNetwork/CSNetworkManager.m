//
//  CSNetworkManager.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNetworkManager.h"
#import <AFNetworking.h>
#import <YYModel.h>
#import "NSString+CSAlert.h"
#import "CSAPPConfigManager.h"
#import "NSString+CS.h"

@interface CSNetworkManager ()


@end

static CSNetworkManager * manager = nil;
@implementation CSNetworkManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSNetworkManager alloc]init];
    });
    return manager;
}


- (instancetype)init{
    if (self = [super init]) {
        self.netManager = [AFHTTPSessionManager manager];
        self.netManager.securityPolicy.allowInvalidCertificates = YES;
        self.netManager.securityPolicy.validatesDomainName = NO;
//        self.netManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.netManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    }
    return self;
}


- (void)getHomeInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/index/jsondata/api/all";
    
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}


///获取查看页面分类数据
- (void)getTopLevelCategoriesSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/special/jsondata/api/grade_cate.html";
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
    
    
}

///获取查看页面二级分类数据
- (void)getSecondLevelCategoriesWithCategoryId:(NSString*)categoryId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/special/jsondata/api/subject_cate";
    [self netGetWithURL:url param:@{@"grade_id":categoryId} successComplete:success failureComplete:failure];
    
}

///获取查看页面详细数据
- (void)getTopicListWithCategoryId:(NSString*)categoryId page:(NSInteger)page successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/special/jsondata/api/special_list.html?subject_id=21&search=&page=1&limit=10";
    NSDictionary * param = @{@"subject_id":categoryId,@"search":@"",@"page":@(page),@"limit":@(10)};
    [self netGetWithURL:url param:param successComplete:success failureComplete:failure];
    
}

- (void)getSearchHotWordsSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/index/jsondata/api/hot_search";
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
    
}

- (void)getSearchResultWithWord:(NSString*)words successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/index/jsondata/api/search_content";
    [self netGetWithURL:url param:@{@"search":words,@"limit":@(20)} successComplete:success failureComplete:failure];
    
}


///注册接口
- (void)registerWithType:(CSRegisterLoginType)type account:(NSString*)account code:(NSString*)code password:(NSString*)password successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    if (type == CSRegisterTypeTelephone) {
        NSString * url = @"/wap/Login/jsondata/api/phoneApp";
        NSDictionary * params = @{@"phone":account,@"code":code};
        [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    }
    
}

///登陆接口
- (void)loginWithType:(CSRegisterLoginType)type account:(NSString*)account password:(NSString*)password code:(NSString*)code successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    if (type == CSRegisterTypeTelephone) {
        NSString * url = @"/wap/Login/jsondata/api/phoneApp";
        NSDictionary * params = @{@"phone":account,@"code":code};
        [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    }
    
}

///获取验证码
- (void)quaryCodeWithType:(CSRegisterLoginType)type account:(NSString*)account successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    if (type == CSRegisterTypeTelephone) {
        NSString * url = @"/wap/public_api/code.html";
        NSDictionary * params = @{@"phone":account};
        [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
        
    }
}

///自动登陆
- (void)autoLoginSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/Login/jsondata/api/valid_sessionkey";
    if (![NSString isNilOrEmpty:[CSAPPConfigManager sharedConfig].sessionKey]) {
        NSDictionary * params = @{@"sessionkey":[CSAPPConfigManager sharedConfig].sessionKey};
        [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    }
    
    
}

///获取艺人详情接口
- (void)quaryArtorDetail:(NSString*)artorId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/special/jsondata/api/all";
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:artorId forKey:@"id"];
    if (![NSString isNilOrEmpty:[CSAPPConfigManager sharedConfig].sessionKey]) {
        [dict setValue:[CSAPPConfigManager sharedConfig].sessionKey forKey:@"sessionkey"];
    }
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

///获取收藏列表
- (void)quaryFavoriteListSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/my/jsondata/api/special_coll";
    NSString * sessionKey = [NSString isNilOrEmpty:[CSAPPConfigManager sharedConfig].sessionKey] ? @"" : [CSAPPConfigManager sharedConfig].sessionKey;
    NSDictionary * params = @{@"sessionkey":sessionKey};
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    
}

///获取浏览记录
- (void)quaryBrowseListSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/special_recode";
    NSString * sessionKey = [NSString isNilOrEmpty:[CSAPPConfigManager sharedConfig].sessionKey] ? @"" : [CSAPPConfigManager sharedConfig].sessionKey;
    NSDictionary * params = @{@"sessionkey":sessionKey};
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
}

///获取购买记录
- (void)quaryPurchaseListSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/my/jsondata/api/special_grade";
    NSString * sessionKey = [NSString isNilOrEmpty:[CSAPPConfigManager sharedConfig].sessionKey] ? @"" : [CSAPPConfigManager sharedConfig].sessionKey;
    NSDictionary * params = @{@"sessionkey":sessionKey};
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    
}

///获取用户协议的内容
- (void)quaryUserProtocalInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/index/jsondata/api/user_agreement";
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}

- (void)quaryAboutUSInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/aboutus_content";
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}

///收藏接口
- (void)addOrRemoveFavoriteInfoWithArtorId:(NSString*)artorId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/special/jsondata/api/collectApp";
    NSString * sessionKey = [NSString isNilOrEmpty:[CSAPPConfigManager sharedConfig].sessionKey] ? @"" : [CSAPPConfigManager sharedConfig].sessionKey;
    NSDictionary * params = @{@"id":artorId,@"sessionkey":sessionKey};
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    
}

- (void)quaryMyInfoNumberSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/all";
    //&sessionkey=489f1a4b55c82c93a55481a7e894c3be_14
    NSString * sessionKey = [NSString isNilOrEmpty:[CSAPPConfigManager sharedConfig].sessionKey] ? @"" : [CSAPPConfigManager sharedConfig].sessionKey;
    NSDictionary * params = @{@"sessionkey":sessionKey};
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
}

///获取首页更多的数据
- (void)quaryHomeMoreInitInfoWithType:(NSString*)type title:(NSString*)title recommandId:(NSString*)recommandId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/index/jsondata/api/more";
    NSDictionary * params = @{@"type":type,@"title":title,@"recommend_id":recommandId};
    
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    
}

- (void)quaryMemberInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/member/jsondata/api/all";
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}

///获取直播界面信息
- (void)quaryLiveInfoWithStreamName:(NSString*)streamName successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    //?stream_name=10928160&sessionkey=24a0cf13225c23c404299bfe8fd57b50_23
    NSString * url = @"/wap/live/jsondata/api/all";
    
    NSDictionary * params = @{@"stream_name":streamName,@"sessionkey":self.sessionKey};
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    
}

- (void)uploadMessage:(NSString*)message liveId:(NSString*)liveId messageType:(NSString*)messageType successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    /*
     https://color.ehxkc.com/wap/live/jsondata/api/save_send_msg?sessionkey=24a0cf13225c23c404299bfe8fd57b50_23&live_id=15&message=323222&ms_type=1
     */
    NSString * url = @"/wap/live/jsondata/api/save_send_msg";
    NSDictionary * params = @{@"token":self.sessionKey,@"live_id":liveId,@"message":message,@"ms_type":messageType};
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    
}

- (void)getThirdTabInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url  = @"/wap/public_api/store_url";
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}

//设置环境
- (void)getBaseUrlSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString *url = @"https://color.ehxkc.com/wap/index/jsondata/api/getTestUrl";
    [self netGetWithURLWithNobaserUrl:url param:nil successComplete:success failureComplete:failure];
}

- (void)netGetWithURLWithNobaserUrl:(NSString*)url param:(NSDictionary*)param successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    [self.netManager GET:url parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---------------/n收到数据啦:%@-----------/n",responseObject);
        CSNetResponseModel * model = [CSNetResponseModel yy_modelWithDictionary:responseObject];
        if (success) {
            success(model);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-----------/n失败啦:%@------------/n",error);
        if (failure) {
            failure(error);
        }
        
        
    }];
    
}

- (void)uploadGift:(NSString*)giftId gitfNum:(NSString*)giftNum liveId:(NSString*)liveId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    /*
     https://color.ehxkc.com/wap/live/jsondata/api/save_live_reward?sessionkey=24a0cf13225c23c404299bfe8fd57b50_23&live_id=15&live_gift_id=171&live_gift_num=2
     */
    NSString * url = @"/wap/live/jsondata/api/save_live_reward";
    NSDictionary * params = @{@"token":self.sessionKey,@"live_id":liveId,@"live_gift_id":giftId,@"live_gift_num":giftNum};
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
    
}
/*
 //https://m.icolorstar.com/wap/live/jsondata/api/all?sessionkey=489f1a4b55c82c93a55481a7e894c3be_14&stream_name=93191521
 //https://color.ehxkc.com/wap/live/jsondata/api/save_live_reward?sessionkey=489f1a4b55c82c93a55481a7e894c3be_14&live_id=15&live_gift_id=171&live_gift_num=2
 */
- (void)netGetWithURL:(NSString*)url param:(NSDictionary*)param successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * complete = [self.baseURL stringByAppendingString:url];
    [self.netManager GET:complete parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---------------/n收到数据啦:%@-----------/n",responseObject);
        CSNetResponseModel * model = [CSNetResponseModel yy_modelWithDictionary:responseObject];
        if (success) {
            success(model);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-----------/n失败啦:%@------------/n",error);
        if (failure) {
            failure(error);
        }
        
        
    }];
    
}

- (void)baseFetchInfo:(NSString*)url param:(NSDictionary*)param successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:param];
    [dict setValue:self.sessionKey forKey:@"token"];
    [[CSNetworkManager sharedManager] netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

- (NSString*)baseURL{
    return [CSAPPConfigManager sharedConfig].baseURL;
}

- (NSString*)sessionKey{
    return [NSString isNilOrEmpty:[CSAPPConfigManager sharedConfig].sessionKey] ? @"" : [CSAPPConfigManager sharedConfig].sessionKey;;
}

@end
