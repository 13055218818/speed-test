//
//  CSNewShopNetManage.m
//  ColorStar
//
//  Created by apple on 2020/11/26.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewShopNetManage.h"

@interface CSNewShopNetManage ()

@property (nonatomic, strong)NSString * baseURL;

@property (nonatomic, strong)NSString * sessionKey;

@end
static CSNewShopNetManage * manager = nil;
@implementation CSNewShopNetManage
+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSNewShopNetManage alloc]init];
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

//商城首页banner数据
- (void)getShopBannerInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/store/jsondata/api/getShopBanner";
    
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}

//商城首页分类数据
- (void)getShopCategopryListSuccessWithLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/store/jsondata/api/getCategory";
    NSDictionary  *dict = @{@"limit":limit};
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//商城列表数据
- (void)getShopCategopryListSuccessWithCid:(NSString *)cid withKey:(NSString *)key withPage:(NSString *)page withLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure
{
    NSString * url = @"/wap/store/jsondata/api/getStoreGoodsList";
    NSDictionary  *dict = @{@"cid":cid,
                            @"keyword":key,
                            @"limit":limit,
                            @"page":page
    };
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//商城商品详情数据
- (void)getShopListDetailSuccessWithCid:(NSString *)shopId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/store/jsondata/api/getGoodsDetail";
    NSDictionary *dict = @{@"id":shopId};
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//商城商品购物车ID
- (void)getShopListShopCartIdSuccessWithproductId:(NSString *)shopId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/order/jsondata/api/now_buy";
    NSDictionary *dict = @{@"productId":shopId,
                           @"cartNum":@"1",
                           @"token":[CSAPPConfigManager sharedConfig].sessionKey
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//商城商品订单key
- (void)getShopListShopCartIdSuccessWithcart_id:(NSString *)shopId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/order/jsondata/api/confirm_order";
    NSDictionary *dict = @{@"cart_id":shopId,
                           @"token":[CSAPPConfigManager sharedConfig].sessionKey
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//商城地址列表
- (void)getShopAddressListShopSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/order/jsondata/api/userAddressList";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey};
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//商城地址新增和修改
- (void)getShopAddressAddAndEdit:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure
{
    NSString * url = @"/wap/order/jsondata/api/addUserAddress";
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//商城地址删除
- (void)getShopAddressDelete:(NSString *)addressId Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/order/jsondata/api/delUserAddress";
    NSDictionary *dict = @{@"id":addressId,
                           @"token":[CSAPPConfigManager sharedConfig].sessionKey
    };
    
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//商品购买
- (void)getBuyShopWith:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/order/jsondata/api/now_buy";
    
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
