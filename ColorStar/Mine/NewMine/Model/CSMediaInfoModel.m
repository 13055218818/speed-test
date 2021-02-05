//
//  CSMediaInfoModel.m
//  ColorStar
//
//  Created by gavin on 2021/1/29.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSMediaInfoModel.h"

@implementation CSMediaInfoModel

- (NSString*)topic{
    return [@"room" stringByAppendingString:self.live_id];
}

@end
