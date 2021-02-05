//
//  CSIMClient.m
//  ColorStar
//
//  Created by gavin on 2020/9/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSIMClient.h"

@implementation CSIMClient

- (instancetype)initWithClientId:(NSString*)clientId{
    if (self = [super init]) {
        _dms = [DMS dmsWithClientId:clientId];
    }
    return self;
}

@end
