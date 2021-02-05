//
//  CSLiveGiftModel.m
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveGiftModel.h"
#import <YYModel/YYModel.h>


@implementation CSLiveGiftModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"giftId":@"id"};
}

@end
