//
//  CSNewMineModel.h
//  ColorStar
//
//  Created by apple on 2020/12/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSNewMineModel : NSObject
@property(nonatomic, strong)NSString            *link_id;
@property(nonatomic, strong)NSString            *title;
@property(nonatomic, strong)NSString            *image;
@property(nonatomic, strong)NSString            *relation_count;
@property(nonatomic, strong)NSString            *detail;
@property(nonatomic, strong)NSString            *subject_name;
@end

@interface CSNewMineOrderModel : NSObject
@property(nonatomic, strong)NSString            *productId;
@property(nonatomic, strong)NSString            *order_id;
@property(nonatomic, strong)NSString            *total_price;
@property(nonatomic, strong)NSString            *total_num;
@property(nonatomic, strong)NSString            *type;
@property(nonatomic, strong)NSDictionary            *goodsInfo;
@property(nonatomic, strong)NSDictionary            *_status;
@end

@interface CSNewMinePunchModel : NSObject
@property(nonatomic, strong)NSString            *coin;
@property(nonatomic, strong)NSString            *days;
@property(nonatomic, assign)BOOL                is_sign;
@property(nonatomic, strong)NSMutableArray      *sign_config;
@end

@interface CSNewMinePunchSign_configModel : NSObject
@property(nonatomic, strong)NSString            *coin;
@property(nonatomic, strong)NSString            *days;
@property(nonatomic, strong)NSString            *is_reward;
@property(nonatomic, strong)NSString            *sign_configId;
@end

@interface CSNewPunchListModel : NSObject
@property(nonatomic, strong)NSString            *number;
@property(nonatomic, strong)NSString            *add_time;
@property(nonatomic, strong)NSString            *days;
@property(nonatomic, strong)NSString            *uid;
@property(nonatomic, strong)NSString            *avatar;
@property(nonatomic, strong)NSString            *nickname;
@end

@interface CSNewShareListModel : NSObject
@property(nonatomic, strong)NSString            *avatar;
@property(nonatomic, strong)NSString            *add_time;
@property(nonatomic, strong)NSString            *account;
@property(nonatomic, strong)NSString            *uid;
@property(nonatomic, strong)NSString            *nickname;
@end

NS_ASSUME_NONNULL_END
