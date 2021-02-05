//
//  CSTutorLiveDetailModel.h
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"
/**
 "data": {...<object>
 "errorCode": 0,... <number>
 -"goldInfo": {虚拟币信息<object>
 "gold_rate": "10",比率 <string>
 "gold_name": "金币",名称 <string>
 "gold_image": "http://cremb-zsff.oss-cn-beijing.aliyuncs.com/61d9d202006181439471781.png"图像 <string>
 },
 -"liveInfo": {...<object>
 "id": 15,直播间id <number>
 "stream_name": "10928160",直播间房间号 <string>
 "uid": 0,用户id <number>
 "live_title": "彩色世界云音乐会",直播标题 <string>
 "live_image": "http://colorstar.oss-cn-hangzhou.aliyuncs.com/b791e202008082232275053.png",直播间封面 <string>
 "start_play_time": "2020-10-10 14:30:00",直播开始时间 <string>
 "stop_play_time": "2020-10-11 20:30:00",直播间数时间 <string>
 "live_introduction": "“彩色世界云音乐会”系列演出是以“无畏，色彩世界”为主题的。在全球流行的环境中，彩星科技决心通过这次在线演唱会给全球观众带来欢乐和希望。因此，公司已尽最大努力，以最佳的表现与明星阵容和高质量的设备支持。彩星科技真诚希望世界各地的歌迷都能感受到“五彩缤纷的音乐，丰富多彩的生活，丰富多彩的世界”的精神",直播简介 <string>
 "special_id": 26,专题id <number>
 "online_user_num": 0,在线人数 <number>
 "online_num": 0,虚拟在线人数 <number>
 "studio_pwd": "",... <string>
 "is_remind": 1,开播提醒 <number>
 "remind_time": 20,... <number>
 "auto_phrase": "欢迎观看彩色世界云音乐会",进入直播间自动回复 <string>
 "add_time": 1596903482,... <number>
 "is_del": 0,... <number>
 "is_recording": 0,... <number>
 "is_play": 0,是否开播 <number>
 "recording": 0,是否录制进行中 <number>
 "record_time": 0,录制开始时间 <number>
 "is_playback": 0,是否回放 <number>
 "playback_record_id": "",回放RecordId <string>
 "sort": 0,... <number>
 "is_top": 0,... <number>
 "abstract": "“彩色世界云音乐会”系列演出是以“无畏，色彩世界”为主题的。在全球流行的环境中，彩星科技决心通过这次在线演唱会给全球观众带来欢乐和希望。因此，公司已尽最大努力，以最佳的表现与明星阵容和高质量的设备支持。彩星科技真诚希望世界各地的歌迷都能感受到“五彩缤纷的音乐，丰富多彩的生活，丰富多彩的世界”的精神"... <string>
 },
 "UserSum": "7",直播间人数 <string>
 "live_title": "彩色世界云音乐会",直播间标题 <string>
 "PullUrl": false,拉流地址 <string>
 "is_ban": 0,是否禁言 <number>
 "room": 15,房间号id <number>
 "datatime": 1602311400,房间号 <number>
 -"workerman": {聊天室信息<object>
 "name": "CRMEB_ZSFF",... <string>
 "count": 2,... <number>
 "protocol": "websocket",... <string>
 "ip": "0.0.0.0",... <string>
 "port": "20014"... <string>
 },
 "phone_type": 3,判断手机机型1=ios,2=android,3=其他 <number>
 "live_status": 2,直播状态:1-正在直播2-直播结束0-尚未直播 <number>
 "user_type": 2,... <number>
 -"live_gift": [直播礼物<array>
 -{
 "id": 171,礼物id <number>
 "live_gift_name": "爱心",礼物名称 <string>
 "live_gift_price": "1",礼物价格 <string>
 -"live_gift_num": [赠送数量列表<array>
 "1"
 ],
 "live_gift_show_img": "http://cremb-zsff.oss-cn-beijing.aliyuncs.com/5a2d520200701101025960.png"礼物图标 <string>
 }
 ],
 -"live_goods": {直播带货商品列表<object>
 "list": [ ],
 "page": 2... <number>
 },
 -"OpenComment": {直播弹幕列表<object>
 -"list": [...<array>
 -{
 "type": 1,消息类型，1=文本，2=图片，3=语音 <number>
 "content": "测试",弹幕内容 <string>
 "uid": 1165,... <number>
 "live_id": 15,... <number>
 "id": 183,... <number>
 "nickname": "13055218818",发送人名称 <string>
 "avatar": "https://m.icolorstar.com/system/images/user_log.jpg",发送人头像 <string>
 "user_type": 2嘉宾类型 0=助教，1=讲师, 2=普通用户 <number>
 }
 ],
 "page": 0... <number>
 },
 -"live_reward": {礼物打赏列表<object>
 -"list": [...<array>
 -{
 "total_price": "11",... <string>
 "uid": 23,打赏人id <number>
 "gift_id": 171,礼物id <number>
 "id": 6,... <number>
 "gift_price": 1,礼物价格 <number>
 "gift_num": 1,礼物数量 <number>
 "nickname": "18119887209",打赏人名称 <string>
 "avatar": "https://m.icolorstar.com/system/images/user_log.jpg"打赏人头像 <string>
 }
 ],
 "page": 0,... <number>
 -"gold_info": {金币信息<object>
 "gold_name": "金币",金币名称 <string>
 "gold_image": "http://cremb-zsff.oss-cn-beijing.aliyuncs.com/61d9d202006181439471781.png"金币图像 <string>
 }
 },
 "OpenCommentCount": 110,弹幕数量 <number>
 "OpenCommentTime": 1602405385,最新弹幕时间戳 <number>
 "CommentCount": 0,用户弹幕数量 <number>
 "CommentTime": null用户上次提交弹幕时间 <string>
 },
 */
@class CSTutorLiveGoldModel;
@class CSTutorLiveInfoModel;
@class CSTutorCommentListModel;
@class CSTutorLiveGiftDetailModel;
@class CSTutorLiveUserTotalModel;
@interface CSTutorLiveModel : CSBaseModel

@property (nonatomic, strong)CSTutorLiveGoldModel * goldInfo;//虚拟币信息

@property (nonatomic, strong)CSTutorLiveInfoModel * liveInfo;

@property (nonatomic, strong)CSTutorLiveUserTotalModel *liveUser;

@property (nonatomic, strong)NSString               * UserSum;

@property (nonatomic, strong)NSString               * live_title;

@property (nonatomic, strong)NSString               * PullUrl;

@property (nonatomic, strong)NSString               * is_ban;

@property (nonatomic, strong)NSString               * room;

@property (nonatomic, assign)BOOL                     is_follow;

@property (nonatomic, strong)NSString               * datatime;

@property (nonatomic, strong)NSString               * phone_type;

@property (nonatomic, strong)NSString               * live_status;

@property (nonatomic, strong)NSString               * user_type;

@property (nonatomic, strong)NSString               * OpenCommentCount;

@property (nonatomic, strong)NSString               * OpenCommentTime;

@property (nonatomic, strong)NSString               * CommentCount;

@property (nonatomic, strong)NSString               * CommentTime;

@property (nonatomic, strong)CSTutorCommentListModel * OpenComment;

@property (nonatomic, strong)NSArray<CSTutorLiveGiftDetailModel*>  * live_gift;

@end

@interface CSTutorLiveGoldModel : CSBaseModel

@property (nonatomic, strong)NSString   * gold_rate;

@property (nonatomic, strong)NSString   * gold_name;

@property (nonatomic, strong)NSString   * gold_image;

@end

@interface CSTutorLiveInfoModel : CSBaseModel

@property (nonatomic, strong)NSString  * liveId;

@property (nonatomic, strong)NSString  * stream_name;

@property (nonatomic, strong)NSString  * uid;

@property (nonatomic, strong)NSString  * live_title;

@property (nonatomic, strong)NSString  * live_image;

@property (nonatomic, strong)NSString  * start_play_time;

@property (nonatomic, strong)NSString  * stop_play_time;

@property (nonatomic, strong)NSString  * live_introduction;

@property (nonatomic, strong)NSString  * special_id;

@property (nonatomic, strong)NSString  * online_user_num;

@property (nonatomic, strong)NSString  * studio_pwd;

@property (nonatomic, strong)NSString  * is_remind;

@property (nonatomic, strong)NSString  * remind_time;

@property (nonatomic, strong)NSString  * auto_phrase;

@property (nonatomic, strong)NSString  * hlsPullUrl;

@property (nonatomic, strong)NSString  * httpPullUrl;

@property (nonatomic, strong)NSString  * add_time;

@property (nonatomic, strong)NSString  * is_del;

@property (nonatomic, strong)NSString  * is_recording;

@property (nonatomic, strong)NSString  * is_play;

@property (nonatomic, strong)NSString  * recording;

@property (nonatomic, strong)NSString  * record_time;

@property (nonatomic, strong)NSString  * is_playback;

@property (nonatomic, strong)NSString  * playback_record_id;

@property (nonatomic, strong)NSString  * sort;

@property (nonatomic, strong)NSString  * topic;


@property (nonatomic, assign)NSInteger  click_count;


@end

@class CSTutorCommentDetailModel;
@interface CSTutorCommentListModel : CSBaseModel

@property (nonatomic, strong)NSArray<CSTutorCommentDetailModel*> *list;

@property (nonatomic, assign)NSInteger    page;

@end


@interface CSTutorCommentDetailModel : CSBaseModel

@property (nonatomic, strong)NSString  * type;

@property (nonatomic, strong)NSString  * content;

@property (nonatomic, strong)NSString  * uid;

@property (nonatomic, strong)NSString  * live_id;

@property (nonatomic, strong)NSString  * commonId;

@property (nonatomic, strong)NSString  * nickname;

@property (nonatomic, strong)NSString  * avatar;

@property (nonatomic, strong)NSString  * user_type;

@property (nonatomic, strong)NSString  * gift_num;

@property (nonatomic, strong)NSString  * gift_image;

@property (nonatomic, strong)NSString  * gift_name;

@end


@interface CSTutorLiveGiftDetailModel : CSBaseModel

@property (nonatomic, strong)NSString  * giftId;

@property (nonatomic, strong)NSString  * live_gift_name;

@property (nonatomic, strong)NSString  * live_gift_price;

@property (nonatomic, strong)NSArray   * live_gift_num;

@property (nonatomic, strong)NSString  * live_gift_show_img;

@end

@class CSTutorLiveRewardDetailModel;
@interface CSTutorLiveRewardModel : CSBaseModel

@property (nonatomic, strong)NSArray<CSTutorLiveRewardDetailModel*>   * list;

@property (nonatomic, strong)NSString  * page;

@end

@interface CSTutorLiveRewardDetailModel : CSBaseModel

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

@class CSTutorLiveUserModel;
@interface CSTutorLiveUserTotalModel : CSBaseModel

@property (nonatomic, assign)NSInteger count;

@property (nonatomic, strong)NSArray<CSTutorLiveUserModel*>   *list;

@end

@interface CSTutorLiveUserModel : CSBaseModel

@property (nonatomic, strong)NSString  *avatar;

@property (nonatomic, strong)NSString  *uid;
@end
