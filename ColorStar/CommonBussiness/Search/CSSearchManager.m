//
//  CSSearchManager.m
//  ColorStar
//
//  Created by gavin on 2020/12/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSSearchManager.h"
#import "CSNetworkManager.h"


static CSSearchManager * manager = nil;

@implementation CSSearchManager

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSSearchManager alloc]init];
    });
    return manager;
}

- (void)fetchHotWordsComplete:(CSSearchComplete)complete{
    
    [[CSNetworkManager sharedManager] baseFetchInfo:@"/wap/index/jsondata/api/hot_search" param:@{} successComplete:^(CSNetResponseModel *response) {
        if (response) {
            if (complete) {
                complete(response,nil);
            }
        }
        } failureComplete:^(NSError *error) {
            if (error) {
                if (complete) {
                    complete(nil,error);
                }
            }
        }];
    
}

- (void)fetchSearchResult:(NSString*)words type:(NSString*)type page:(NSInteger)page limit:(NSInteger)limit complete:(CSSearchComplete)complete{
    
    NSString * url = @"/wap/index/jsondata/api/go_search_new";
    
    NSDictionary * params = @{@"search":words,@"type":type,@"page":@(page),@"limit":@(limit)};
    
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:params successComplete:^(CSNetResponseModel *response) {
        if (response) {
            if (complete) {
                complete(response,nil);
            }
        }
        } failureComplete:^(NSError *error) {
            if (error) {
                if (complete) {
                    complete(nil,error);
                }
            }
        }];
}

@end
