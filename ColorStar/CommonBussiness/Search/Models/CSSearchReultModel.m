//
//  CSSearchReultModel.m
//  ColorStar
//
//  Created by gavin on 2020/8/15.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSSearchReultModel.h"
#import <YYModel.h>

@implementation CSSearchReultModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"modelId":@"id"};
}

- (NSString*)price{
    if ([self.money isEqualToString:@"0.00"]) {
        return @"免费";
    }
    return self.money;
}

@end
