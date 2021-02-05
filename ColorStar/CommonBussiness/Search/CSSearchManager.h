//
//  CSSearchManager.h
//  ColorStar
//
//  Created by gavin on 2020/12/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetResponseModel.h"

typedef void(^CSSearchComplete)(CSNetResponseModel * response, NSError * error);

@interface CSSearchManager : NSObject

+ (instancetype)shared;

- (void)fetchHotWordsComplete:(CSSearchComplete)complete;

- (void)fetchSearchResult:(NSString*)words type:(NSString*)type page:(NSInteger)page limit:(NSInteger)limit complete:(CSSearchComplete)complete;

@end


