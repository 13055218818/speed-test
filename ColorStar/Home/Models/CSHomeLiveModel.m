//
//  CSHomeLiveModel.m
//  ColorStar
//
//  Created by gavin on 2020/9/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeLiveModel.h"
#import <YYModel.h>


@implementation CSHomeLiveModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"liveId":@"id"};
}

@end
