//
//  CSIMMessageModel.h
//  ColorStar
//
//  Created by gavin on 2020/10/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSChatModel.h"
/**
 {"message":"testte","m_type":"1","type":"message","user_type":2,"userInfo":{"uid":12387,"account":"13514915985","pwd":"e10adc3949ba59abbe56e057f20f883e","nickname":"13514915985","avatar":"\/system\/images\/user_log.jpg","name":null,"phone":"13514915985","grade_id":0,"full_name":"","bank_card":"","add_time":1602393076,"add_ip":"36.35.34.107","last_time":1602393076,"last_ip":"36.35.34.107","now_money":"0.00","gold_num":0,"brokerage_price":"0.00","integral":"0.00","status":1,"level":0,"spread_uid":0,"spread_time":0,"valid_time":0,"user_type":"","is_promoter":0,"pay_count":0,"is_binding":0,"is_senior":0,"is_h5user":1,"overdue_time":0,"is_permanent":0,"client_id":""},"id":"1334"}
 */

@interface CSIMMessageSenderModel : NSObject

@property (nonatomic, strong)NSString * uid;

@property (nonatomic, strong)NSString * account;

@property (nonatomic, strong)NSString * pwd;

@property (nonatomic, strong)NSString * nickname;

@property (nonatomic, strong)NSString * avatar;

@property (nonatomic, strong)NSString * name;

@property (nonatomic, strong)NSString * phone;

@property (nonatomic, strong)NSString * grade_id;

@property (nonatomic, strong)NSString * message;

@property (nonatomic, strong)NSString * full_name;

@property (nonatomic, strong)NSString * bank_card;

@property (nonatomic, strong)NSString * add_time;

@property (nonatomic, strong)NSString * add_ip;

@property (nonatomic, strong)NSString * last_time;

@property (nonatomic, strong)NSString * last_ip;

@property (nonatomic, strong)NSString * now_money;

@property (nonatomic, strong)NSString * gold_num;

@property (nonatomic, strong)NSString * integral;

@property (nonatomic, strong)NSString * status;

@property (nonatomic, strong)NSString * level;

@property (nonatomic, strong)NSString * spread_uid;

@property (nonatomic, strong)NSString * brokerage_price;

@property (nonatomic, strong)NSString * spread_time;

@property (nonatomic, strong)NSString * valid_time;

@property (nonatomic, strong)NSString * user_type;

@property (nonatomic, strong)NSString * is_promoter;

@property (nonatomic, strong)NSString * pay_count;

@property (nonatomic, strong)NSString * is_binding;

@property (nonatomic, strong)NSString * is_senior;

@property (nonatomic, strong)NSString * is_h5user;

@property (nonatomic, strong)NSString * overdue_time;

@property (nonatomic, strong)NSString * is_permanent;

@property (nonatomic, strong)NSString * client_id;

@end

@interface CSIMMessageModel : NSObject

@property (nonatomic, strong)NSString * message;

@property (nonatomic, strong)NSString * m_type;

@property (nonatomic, strong)NSString * type;

@property (nonatomic, strong)NSString * user_type;

@property (nonatomic, strong)NSString * messageId;

@property (nonatomic, strong)CSIMMessageSenderModel  * userInfo;

- (CSChatModel*)transformChatModel;

@end


