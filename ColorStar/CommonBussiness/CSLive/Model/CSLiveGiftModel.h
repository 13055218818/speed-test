//
//  CSLiveGiftModel.h
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
"id": 171,
"live_gift_name": "\u7231\u5fc3",
"live_gift_price": "1",
"live_gift_num": ["1", "5", "10", "20"],
"live_gift_show_img": "http:\/\/cremb-zsff.oss-cn-beijing.aliyuncs.com\/5a2d520200701101025960.png"
 */
@interface CSLiveGiftModel : NSObject

@property (nonatomic, strong)NSString  * giftId;

@property (nonatomic, strong)NSString  * live_gift_name;

@property (nonatomic, strong)NSString  * live_gift_price;

@property (nonatomic, strong)NSArray   * live_gift_num;

@property (nonatomic, strong)NSString  * live_gift_show_img;

@end


