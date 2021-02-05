//
//  CSCommonDataManager.h
//  ColorStar
//
//  Created by gavin on 2021/1/16.
//  Copyright © 2021 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetResponseModel.h"

typedef void(^CSCommonDataComplete)(CSNetResponseModel * response, NSError * error);


@interface CSCommonDataManager : NSObject

@property (nonatomic, strong)NSArray    *giftList;

+ (instancetype)shared;

- (void)fetchGiftList:(CSCommonDataComplete)complete;

@end


