//
//  CSStorgeManager.m
//  ColorStar
//
//  Created by gavin on 2020/8/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSStorgeManager.h"
#import "CSNetworkManager.h"


NSString * const cs_search_words_key = @"cs_search_words_key";
NSString * const cs_guide_key = @"cs_guide_key";

@interface CSStorgeManager ()

@property (nonatomic, strong)NSArray * hotWords;

@end

@implementation CSStorgeManager
CSStorgeManager * manaer = nil;
+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manaer = [[CSStorgeManager alloc]init];
    });
    return manaer;
}

- (void)storeSearchWords:(NSString*)words{
    if ([NSString isNilOrEmpty:words]) {
        return;
    }
    NSArray * list = [self getSearchHistoryWords];
    BOOL needStore = YES;
    for (NSString * word in list) {
        if ([word isEqualToString:words]) {
            needStore = NO;
            break;
        }
    }
    if (needStore) {
        NSMutableArray * wordsList = [NSMutableArray arrayWithArray:list];
        [wordsList addObject:words];
        [[NSUserDefaults standardUserDefaults] setObject:wordsList forKey:cs_search_words_key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSArray*)getSearchHistoryWords{
//    return @[@"街舞",@"贝斯"];
    NSString * key = cs_search_words_key;
    NSArray* list = [[NSUserDefaults standardUserDefaults] arrayForKey:key];
    if (!list) {
        list = [NSArray array];
    }
    return list;
}


- (void)quarySearchHotWords{
    
    [[CSNetworkManager sharedManager] getSearchHotWordsSuccessComplete:^(CSNetResponseModel *response) {
        
        NSArray * words = (NSArray*)response.data;
        self.hotWords = words;
        
    } failureComplete:^(NSError *error) {
        
    }];
    
}

- (NSArray*)getSearchHotWords{
    return self.hotWords;
}

- (BOOL)needGuide{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:cs_guide_key];
}

- (void)hasGuide{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:cs_guide_key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
