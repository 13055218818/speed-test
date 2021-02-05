//
//  CSIMGiftModel.h
//  ColorStar
//
//  Created by gavin on 2020/10/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSChatModel.h"
#import <UIKit/UIKit.h>

/**
 {"type":"live_reward","uid":1,"live_gift_id":171,"live_gift_num":1,"live_id":"15","special_id":26}
 这个是打赏礼物的消息体
 */

@interface CSIMGiftModel : NSObject

@property (nonatomic, strong)NSString  * type;

@property (nonatomic, strong)NSString  * uid;

@property (nonatomic, strong)NSString  * live_gift_id;

@property (nonatomic, strong)NSString  * live_gift_num;

@property (nonatomic, strong)NSString  * live_id;

@property (nonatomic, strong)NSString  * special_id;

@property (nonatomic, strong)NSString  * user_avatar;

@property (nonatomic, strong)NSString  * live_gift_name;

@property (nonatomic, strong)NSString  * live_gift_image;

@property (nonatomic, strong)NSString  * username;

@property (nonatomic, strong)NSString  * user_type;

@property (nonatomic, strong)NSString  * recharge_status;

- (CSChatModel*)transformChatModelWithGiftImage:(UIImage*)giftImage;

@end


