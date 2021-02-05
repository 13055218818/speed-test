//
//  CSNewCourseNetManage.m
//  ColorStar
//
//  Created by apple on 2020/11/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewCourseNetManage.h"
@interface CSNewCourseNetManage ()

@property (nonatomic, strong)NSString * baseURL;

@property (nonatomic, strong)NSString * sessionKey;

@end
static CSNewCourseNetManage * manager = nil;
@implementation CSNewCourseNetManage
+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSNewCourseNetManage alloc]init];
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
- (void)getCourseBannerInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/special/jsondata/api/getClassBanner";
    
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}

//课程分类数据
- (void)getCourseCategoryListInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/special/get_grade_cate";
    
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}

//课程list数据
- (void)getCourseListInfoSuccessWith:(NSString *)grade_id withOrder:(NSString *)order withPage:(NSString *)page withLimit:(NSString *)limit Complete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    NSString * url = @"/wap/special/jsondata/api/special_search_list";
    NSDictionary * params = @{@"grade_id":grade_id,
                              @"order":order,
                              @"page":page,
                              @"limit":limit
    };
    [self netGetWithURL:url param:params successComplete:success failureComplete:failure];
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
