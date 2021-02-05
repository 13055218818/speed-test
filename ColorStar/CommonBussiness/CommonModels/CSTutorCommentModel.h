//
//  CSTutorCommonModel.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/23.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

@interface CSTutorCommonReplyModel : CSBaseModel

@property (nonatomic, strong)NSString * uid;

@property (nonatomic, strong)NSString * nickname;

@property (nonatomic, strong)NSString * content;

@property (nonatomic, strong)NSString * account;

@property (nonatomic, strong)NSString * avatar;

@property (nonatomic, strong)NSString * user_name;

@end


@interface CSTutorCommentModel : CSBaseModel

@property (nonatomic, strong)NSString * commonId;

@property (nonatomic, strong)NSString * uid;

@property (nonatomic, strong)NSString * content;

@property (nonatomic, assign)NSInteger  click_count;

@property (nonatomic, strong)NSString * is_follow;

@property (nonatomic, strong)NSString * rid;

@property (nonatomic, strong)NSString * add_time;

@property (nonatomic, strong)NSString * nickname;

@property (nonatomic, strong)NSString * avatar;

@property (nonatomic, strong)NSString * user_name;

@property (nonatomic, strong)NSArray  * down_info;

@property (nonatomic, assign)BOOL   is_click;

@end

