//
//  CSNewHomeNetManager.m
//  ColorStar
//
//  Created by apple on 2020/11/24.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeNetManager.h"
@interface CSNewHomeNetManager ()

@property (nonatomic, strong)NSString * baseURL;

@property (nonatomic, strong)NSString * sessionKey;

@end
static CSNewHomeNetManager * manager = nil;
@implementation CSNewHomeNetManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSNewHomeNetManager alloc]init];
    });
    return manager;
}


- (instancetype)init{
    if (self = [super init]) {
        self.netManager = [AFHTTPSessionManager manager];
        self.netManager.securityPolicy.allowInvalidCertificates = YES;
        self.netManager.securityPolicy.validatesDomainName = NO;
       // self.netManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.netManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    }
    return self;
}
//推荐
- (void)getHomeRecommendInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/index/jsondata/api/home";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey};
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//首页推荐列表数据获取
- (void)getHomeRecommendListSuccessWithDict:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/index/jsondata/api/getSpecialList";
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}
//首页推荐精选列表数据获取
- (void)getHomeRecommendBestListSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/index/jsondata/api/getGuitarList";
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}

//首页发现数据
- (void)getHomeFindInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/index/jsondata/api/found";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey};

    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}
//发现列表数据获取
- (void)getFindLiveInfoListSuccessWithDict:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/index/jsondata/api/getTaskList";
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
    
}
//首页直播数据
- (void)getHomeLiveInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/Live/jsondata/api/getLiveIndex";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey};

    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}
//直播列表数据获取
- (void)getHomeLiveInfoListSuccessWithDict:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/Live/jsondata/api/getLiveList";
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//艺人专题关注
- (void)getHomeaddFollowSuccessId:(NSString *)classId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/special/jsondata/api/addFollow";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
                           @"id":classId
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

- (void)netGetWithURL:(NSString*)url param:(NSDictionary*)param successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * complete = [self.baseURL stringByAppendingString:url];
    [self.netManager GET:complete parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---------------/n收到数据啦:%@-----------/n",responseObject);
        CSNetResponseModel * model = [CSNetResponseModel yy_modelWithDictionary:responseObject];
        if (success) {
            success(model);
        }
        if (model.code == 401 || model.code == 480 || model.code == 499 || model.code == 498) {
            [WHToast showMessage:csnation(@"登陆失效！请重新登录！") duration:1 finishHandler:nil];
            [[CSNewLoginUserInfoManager sharedManager] outLogin];
        }else if(model.code !=200){
            [WHToast showMessage:model.msg duration:1 finishHandler:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-----------/n失败啦:%@------------/n",error);
        if (failure) {
            failure(error);
        }
        [WHToast showMessage:csnation(@"请检查网络连接后重试") duration:1 finishHandler:nil];
    }];
    
}

- (NSString*)baseURL{
    return [CSAPPConfigManager sharedConfig].baseURL;
}

- (NSString*)sessionKey{
    return [NSString isNilOrEmpty:[CSAPPConfigManager sharedConfig].sessionKey] ? @"" : [CSAPPConfigManager sharedConfig].sessionKey;;
}


@end
