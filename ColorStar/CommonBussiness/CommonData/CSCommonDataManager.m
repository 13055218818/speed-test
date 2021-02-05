//
//  CSCommonDataManager.m
//  ColorStar
//
//  Created by gavin on 2021/1/16.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSCommonDataManager.h"
#import "CSNetworkManager.h"


static CSCommonDataManager * manager = nil;
@implementation CSCommonDataManager

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSCommonDataManager alloc]init];
    });
    return manager;
}

- (void)fetchGiftList:(CSCommonDataComplete)complete{
    
    NSString * url = @"";
    
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:@{} successComplete:^(CSNetResponseModel *response) {
        if (response.code == 200) {
            
        }
        
    } failureComplete:^(NSError *error) {
            
    }];
    
    
    
}
@end
