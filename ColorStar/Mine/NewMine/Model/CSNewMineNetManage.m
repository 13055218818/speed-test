//
//  CSNewMineNetManage.m
//  ColorStar
//
//  Created by apple on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewMineNetManage.h"
@interface CSNewMineNetManage ()

@property (nonatomic, strong)NSString * baseURL;

@property (nonatomic, strong)NSString * sessionKey;

@end
static CSNewMineNetManage * manager = nil;
@implementation CSNewMineNetManage
+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSNewMineNetManage alloc]init];
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

- (void)getMineCollectionListInfoSuccessPagge:(NSString *)page withLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/myCollect";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
                           @"page":page,
                           @"limit":limit
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

- (void)getMineOrederListInfoSuccessPagge:(NSString *)page withLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/order/jsondata/api/getOrderList";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
                           @"page":page,
                           @"limit":limit
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

- (void)getDeleteOrederListInfoSuccessOrderId:(NSString *)orderid Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/order/jsondata/api/delOrder";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
                           @"order_id":orderid
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}


- (void)getEditInfoSuccessNickname:(NSString *)nickname Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/My/jsondata/api/editSelf";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
                           @"order_id":nickname
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//ios app内购成功
- (void)getAppPaySuccess:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/pay/iosPayGold";

    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//签到信息
- (void)getSiginInfoComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/signIndex";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//签到
- (void)getSiginComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/sign";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//签到累计奖励
- (void)getSignRewardWithRid:(NSString *)rid Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/signReward";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
                           @"rid":rid
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//签到明细
- (void)getSignListWithPage:(NSString *)page Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/getSignList";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
                           @"page":page,
                           @"limit":@"10"
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//分享内容
-(void)getShareInforComplete:(CSNetWorkSuccessCompletion)success Complete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/getFxMsg";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//分享列表
- (void)getShareListWithPage:(NSString *)page Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/getSpreadUserList";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
                           @"page":page,
                           @"limit":@"10"
    };
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//获取直播推流地址
- (void)getLiveAddressComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/live/jsondata/api/getPushAddress";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey
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
