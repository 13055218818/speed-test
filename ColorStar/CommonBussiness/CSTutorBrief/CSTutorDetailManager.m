//
//  CSTutorDetailManager.m
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorDetailManager.h"
#import "CSNetworkManager.h"


static CSTutorDetailManager * manager = nil;
@implementation CSTutorDetailManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSTutorDetailManager alloc]init];
    });
    return manager;
}

- (void)fetchTutorInfo:(NSString*)detailId complete:(CSTutorDetailComplete)complete{
    
    NSString * url = @"/wap/special/jsondata/api/getTeacherDetail";
    NSDictionary * dict = @{@"id":detailId,@"token":[CSNetworkManager sharedManager].sessionKey};
    [[CSNetworkManager sharedManager] netGetWithURL:url param:dict successComplete:^(CSNetResponseModel *response) {
        if (response && complete) {
            complete(response,nil);
        }
        
        } failureComplete:^(NSError *error) {
            if (complete) {
                complete(nil,error);
            }
        }];
    
}

@end
