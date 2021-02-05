//
//  CSHomeTopicBaseModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CSHomeTopicBaseModelType) {
    CSHomeTopicBaseModelTypeNone = 0,
    CSHomeTopicBaseModelTypeImage,//图文
    CSHomeTopicBaseModelTypeAudio,//音频
    CSHomeTopicBaseModelTypeVideo,//视频
    CSHomeTopicBaseModelTypeLive//直播
};

@interface CSHomeTopicBaseModel : NSObject

@property (nonatomic, strong)NSString * topicId;

@property (nonatomic, strong)NSString * pink_money;//拼团价

@property (nonatomic, strong)NSString * is_pink;

@property (nonatomic, strong)NSString * image;

@property (nonatomic, strong)NSString * video;

@property (nonatomic, strong)NSString * abstract;

@property (nonatomic, strong)NSArray  * label;

@property (nonatomic, strong)NSString * money;//正常价

@property (nonatomic, strong)NSString * pay_type;

@property (nonatomic, assign)NSInteger  special_type;

@property (nonatomic, strong)NSString * subject_name;

@property (nonatomic, strong)NSString * link_id;

@property (nonatomic, strong)NSString * browse_count;

@property (nonatomic, strong)NSString * member_pay_type;

@property (nonatomic, strong)NSString * member_money;//会员价

@property (nonatomic, strong)NSString * count;

@property (nonatomic, strong)NSString * special_type_name;



@property (nonatomic, strong)NSString * thumbnail;//缩略图

@property (nonatomic, strong)NSString * infoType;//图文专题

@property (nonatomic, strong)NSString * title;//标题

@property (nonatomic, strong)NSString * author;//作者

@property (nonatomic, strong)NSString * price;//价格

@property (nonatomic, strong)NSString * courses;//

@property (nonatomic, strong)NSString * studies;

@property (nonatomic, assign)CSHomeTopicBaseModelType   topicType;

@property (nonatomic, assign)BOOL showVideo;

@end


