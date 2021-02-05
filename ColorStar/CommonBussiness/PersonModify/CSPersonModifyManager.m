//
//  CSPersonModifyManager.m
//  ColorStar
//
//  Created by gavin on 2020/12/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSPersonModifyManager.h"
#import "CSNetworkManager.h"

static CSPersonModifyManager * manager = nil;
@implementation CSPersonModifyManager

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSPersonModifyManager alloc]init];
    });
    return manager;
}

- (void)modifyName:(NSString*)name complete:(CSPersonModifyComplete)complete{
    NSString * url = @"/wap/My/jsondata/api/editSelf";
    NSDictionary * dict = @{@"nickname":name};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:dict successComplete:^(CSNetResponseModel *response) {
        if (response && complete) {
            complete(response,nil);
        }
        } failureComplete:^(NSError *error) {
            if (error && complete) {
                complete(nil,error);
            }
        }];
}

@end
