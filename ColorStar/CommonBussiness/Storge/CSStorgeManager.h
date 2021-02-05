//
//  CSStorgeManager.h
//  ColorStar
//
//  Created by gavin on 2020/8/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSStorgeManager : NSObject

+ (instancetype)sharedManager;

- (void)storeSearchWords:(NSString*)words;

- (NSArray*)getSearchHistoryWords;

- (void)quarySearchHotWords;

- (NSArray*)getSearchHotWords;

- (BOOL)needGuide;

- (void)hasGuide;

@end


