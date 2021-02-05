//
//  CSLiveRewardModel.h
//  ColorStar
//
//  Created by gavin on 2020/10/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "total_price": "5",
                 "uid": 3,
                 "gift_id": 171,
                 "id": 1,
                 "gift_price": 1,
                 "gift_num": 1,
                 "nickname": "kuuwf",
                 "avatar": "http:\/\/thirdwx.qlogo.cn\/mmopen\/yhZQjNNOKR5ibcCm9aK0iaiaMlpj01cxbygh4mKXPuCFvJibBdUlhIKziacoCONLYF2rURkDiafmLMFnicSQkVAojTgAL4eHnExia0Yx\/132"
 */
@interface CSLiveRewardDetailModel : NSObject

@property (nonatomic, strong)NSString  * rewardId;

@property (nonatomic, strong)NSString  * total_price;

@property (nonatomic, strong)NSString  * uid;

@property (nonatomic, strong)NSString  * gift_id;

@property (nonatomic, strong)NSString  * gift_price;

@property (nonatomic, strong)NSString  * gift_num;

@property (nonatomic, strong)NSString  * nickname;

@property (nonatomic, strong)NSString  * avatar;

@property (nonatomic, assign)NSInteger   rank;

@end

@interface CSLiveRewardModel : NSObject

@property (nonatomic, strong)NSArray<CSLiveRewardDetailModel*>   * list;

@property (nonatomic, strong)NSString  * page;

@end


