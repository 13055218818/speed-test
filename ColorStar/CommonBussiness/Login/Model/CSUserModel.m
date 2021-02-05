//
//  CSUserModel.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSUserModel.h"

@implementation CSUserModel

- (instancetype)init{
    if (self = [super init]) {
        _gold_num = @"0";
    }
    return self;
}

- (BOOL)isMember{
    return self.level != 0;
}

@end
