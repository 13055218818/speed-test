//
//  CSLiveInfoModel.m
//  ColorStar
//
//  Created by gavin on 2020/10/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveInfoModel.h"
#import <YYModel.h>

@implementation CSLiveInfoModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"liveId":@"id"};
}

- (NSString*)topic{
    return [@"room" stringByAppendingString:self.liveId];
}

@end
