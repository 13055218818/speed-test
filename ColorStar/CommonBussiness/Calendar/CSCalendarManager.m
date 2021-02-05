//
//  CSCalendarManager.m
//  ColorStar
//
//  Created by gavin on 2020/11/28.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCalendarManager.h"
#import "CSNetworkManager.h"

static CSCalendarManager * manager = nil;
@implementation CSCalendarManager

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSCalendarManager alloc]init];
    });
    return manager;
}



- (void)fetchCalendarRedPointInfo:(NSString*)year month:(NSString*)month complete:(CSCalendarInfoComplete)complete{
    
    NSString * url = @"/wap/article/jsondata/api/getCalendar";
    NSDictionary * dict = @{@"year":year,@"month":month};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:dict successComplete:^(CSNetResponseModel *response) {
        if (complete) {
            complete(response,nil);
        }
        
        } failureComplete:^(NSError *error) {
            if (complete) {
                complete(nil,error);
            }
        }];
    
}

- (void)fetchCalendarDaysNewsInfo:(NSString*)date complete:(CSCalendarInfoComplete)complete{
    
    NSString * url = @"/wap/article/jsondata/api/getCalendarData";
    NSDictionary * params = @{@"date":date,@"limit":@"1000"};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:params successComplete:^(CSNetResponseModel *response) {
        if (complete) {
            complete(response,nil);
        }
        
        } failureComplete:^(NSError *error) {
            if (complete) {
                complete(nil,error);
            }
        }];
}

- (void)fetchCalendarMonthNewsInfo:(NSString*)date complete:(CSCalendarInfoComplete)complete{
    
    NSString * url = @"/wap/article/jsondata/api/getMoreArticleList";
    NSDictionary * params = @{@"date":date,@"limit":@"1000"};
    [[CSNetworkManager sharedManager] baseFetchInfo:url param:params successComplete:^(CSNetResponseModel *response) {
        if (complete) {
            complete(response,nil);
        }
        
        } failureComplete:^(NSError *error) {
            if (complete) {
                complete(nil,error);
            }
        }];
    
}

@end
