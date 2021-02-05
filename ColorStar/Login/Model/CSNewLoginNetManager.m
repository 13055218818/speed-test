//
//  CSNewLoginNetManager.m
//  ColorStar
//
//  Created by apple on 2020/12/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewLoginNetManager.h"
@interface CSNewLoginNetManager ()

@property (nonatomic, strong)NSString * baseURL;

@property (nonatomic, strong)NSString * sessionKey;

@end
static CSNewLoginNetManager * manager = nil;
@implementation CSNewLoginNetManager
+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSNewLoginNetManager alloc]init];
    });
    return manager;
}


- (instancetype)init{
    if (self = [super init]) {
        self.netManager = [AFHTTPSessionManager manager];
        self.netManager.securityPolicy.allowInvalidCertificates = YES;
        self.netManager.securityPolicy.validatesDomainName = NO;
      //  self.netManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.netManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    }
    return self;
}
- (void)getLoginTokenWithWXCode:(NSString *)code Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/Login/jsondata/api/weChatRegisterOrLogin";
    
    [self netGetWithURL:url param:@{@"code":code} successComplete:success failureComplete:failure];
}
//手机号绑定--用于微信注册后
- (void)getLoginToWechatPhoneCode:(NSString *)code  withPhone:(NSString *)phone withOpenid:(NSString *)openId withPwd:(NSString *)pwd Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/Login/jsondata/api/wechatPhone";
    NSDictionary *dict = @{@"phone":phone,
                           @"code":code,
                           @"openid":openId,
                           @"pwd":pwd
    };
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//验证token获取用户信息
- (void)getUserInfoWithTokenComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/getUserInfo";
    NSDictionary *dict = @{@"token":[CSAPPConfigManager sharedConfig].sessionKey,
    };
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//发送短信验证码
-(void)getSendPhoneCodeWithPhone:(NSString *)phone Withprefix:(NSString *)prefix Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/public_api/code";
    NSDictionary *dict = @{@"phone":phone,
                           @"prefix":prefix
    };
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

- (void)getLoginWithPhone:(NSString *)phone withCode:(NSString *)code Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure
{
    NSString * url = @"/wap/Login/jsondata/api/phoneApp";
    NSDictionary  *dict = @{@"phone":phone,
                            @"code":code
    };
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//密码登录
- (void)getLoginWithPhone:(NSString *)phone withPws:(NSString *)pws Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"/wap/login/jsondata/api/pwdLogin";
    NSDictionary  *dict = @{@"account":phone,
                            @"pwd":pws
    };

    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//登录/注册facebook/google
- (void)getLoginFacebookAndGoogleWithDict:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/login/jsondata/api/faceBookLogin";

    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//密码重置
- (void)getRestPwdWithPhone:(NSString *)phone withPws:(NSString *)pws withCode:(NSString *)code Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/Login/jsondata/api/resetPwd";
    NSDictionary  *dict = @{@"phone":phone,
                            @"pwd":pws,
                            @"code":code
    };

    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//发送邮箱验证
-(void)getsendEmailCode:(NSString *)email Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/login/jsondata/api/sendEmailCode";
    NSDictionary  *dict = @{@"email":email
    };

    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//邮箱注册登陆
-(void)getEmailLoginWithEmail:(NSString *)email WithVerify:(NSString *)verfiy Withpws:(NSString *)pws Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/Login/jsondata/api/emailCheckCode";
    NSDictionary  *dict = @{@"email":email,
                            @"code":verfiy,
                            @"pwd":pws
    };

    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

//版本更新接口
- (void)getNewVersionInfoComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/index/jsondata/api/getVersion";

    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}

- (void)getAppleLoginWith:(NSDictionary *)dict Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/login/jsondata/api/appleLogin";

    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}


//绑定邀请码
- (void)getUserInviteCodeWith:(NSString *)code Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/my/jsondata/api/setSpreadCode";
    NSDictionary  *dict = @{@"code":code,
                            @"token":[CSAPPConfigManager sharedConfig].sessionKey
    };
    [self netGetWithURL:url param:dict successComplete:success failureComplete:failure];
}

- (void)netGetWithURL:(NSString*)url param:(NSDictionary*)param successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * complete = [self.baseURL stringByAppendingString:url];
    [self.netManager GET:complete parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---------------/n收到数据啦:%@------/n%@-----/n",responseObject,url);
        CSNetResponseModel * model = [CSNetResponseModel yy_modelWithDictionary:responseObject];
        if (model.code == 200) {
            if (success) {
                success(model);
            }
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
