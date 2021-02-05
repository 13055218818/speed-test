//
//  CSTutorVideoModel.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/23.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

/**
 {
 "code": 200,... <number>
 "msg": "ok",... <string>
 -"data": {...<object>
 -"taskInfo": {素材视频信息<object>
 "title": "魏巡演唱技巧大师课",视屏标题 <string>
 "content": "<p>魏巡演唱技巧大师课</p>",... <string>
 "link": "",视屏地址 <string>
 "image": "http://colorstar.oss-cn-hangzhou.aliyuncs.com/0d3c6202008081717032016.jpg",封面图 <string>
 "play_count": 21,播放次数 <number>
 "add_time": "08月08日",时间 <string>
 "is_show": 1,... <number>
 "detail": "<p>魏巡演唱技巧大师课</p>"简介 <string>
 },
 "is_member": 0,... <number>
 "specialId": 21,... <number>
 -"specialInfo": {专题信息<object>
 "title": "魏巡",名称 <string>
 "image": "http://colorstar.oss-cn-hangzhou.aliyuncs.com/9bd24202008081717106504.jpg",封面图 <string>
 "money": "0.00",价格 <string>
 "is_pink": 0,是否平团 <number>
 "abstract": "魏巡（Win），天娱传媒旗下签约艺人，中国内地流行乐男歌手。2008年，参加江苏卫视选秀娱乐节目《绝对唱响》比赛，获得武汉赛区八强，从而正式进入演艺圈；同年，获得“第13届CCTV全国青年歌手电视大奖赛”通俗唱法金奖。2009年，获得“第二届光谷音乐节”自由组冠军、最佳台风奖。2011年，参加“全国K歌之王选拔赛”，获得全国总决赛冠军。2014年，加入方向乐团，并担任主唱；2015年，担任“第二届SING星索原创中国流行音乐网络大赛”的评委。2017年，相继推出个人单曲《Hey We Go》、《I Miss U》；同年9月获得《快乐男声》全国冠军，签约天娱传媒公司。2019全新首发创作专辑《我的光》，魏巡在专辑中统领制作、词曲创作的硬实力。《我的光》不以传统流行讨巧的做法，更强调了魏巡作为制作人的能力与胆识。2020年6月10日全新单曲《星星断了线》一经发出就大获好评。魏巡有着独具特色的嗓音，用音乐带动氛围，对音乐有着超群的驾驭能力 。拥有青春有型的脸庞、偶像般的气质，独有的魅力和活力具有极强的舞台感染力 。",简介 <string>
 "follow_count": 0... <number>
 },
 -"specialList": [大师课程<array>
 -{
 "special_id": 21,... <number>
 "source_id": 33,... <number>
 "play_count": 48,... <number>
 "title": "魏巡",... <string>
 "task_name": "魏巡演唱技巧大师课",课程名称 <string>
 "image": "http://colorstar.oss-cn-hangzhou.aliyuncs.com/0d3c6202008081717032016.jpg",封面图 <string>
 "name": "演唱"课程类目 <string>
 }
 ],
 "isPay": 1,是否收费 <number>
 "isPink": false,是否拼团 <boolean>
 -"discussList": [最新评论<array>
 -{
 "id": 7,... <number>
 "uid": 1165,... <number>
 "content": "测试测试",评论内容 <string>
 "click_count": 0,点赞数量 <number>
 "ruid": 1165,... <number>
 "rid": 5,... <number>
 "nickname": "13055218818",... <string>
 "account": "13055218818",... <string>
 "avatar": "/system/images/user_log.jpg",头像 <string>
 "user_name": "13055218818",用户名 <string>
 -"down_info": {被回复内容<object>
 "uid": 1165,... <number>
 "content": "测试测试内容内容2",评论内容 <string>
 "nickname": "13055218818",... <string>
 "account": "13055218818",... <string>
 "avatar": "/system/images/user_log.jpg",头像 <string>
 "user_name": "13055218818"用户名 <string>
 },
 "is_click": 0是否点赞 <number>
 }
 ]
 },
 "count": 0... <number>
 }
 */
@class CSTutorTaskInfo;
@class CSTutorSpecialInfo;
@interface CSTutorVideoModel : CSBaseModel

@property (nonatomic, strong)CSTutorTaskInfo  * taskInfo;

@property (nonatomic, strong)NSString * is_member;

@property (nonatomic, strong)NSString * specialId;

@property (nonatomic, strong)CSTutorSpecialInfo  * specialInfo;

@property (nonatomic, strong)NSArray  * specialList;

@property (nonatomic, strong)NSString * isPay;

@property (nonatomic, strong)NSString * isPink;

@property (nonatomic, strong)NSArray  * discussList;



@end


@interface CSTutorTaskInfo : CSBaseModel
@property (nonatomic, strong)NSString * taskInfoId;

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSString * content;

@property (nonatomic, strong)NSString * link;

@property (nonatomic, strong)NSString * image;

@property (nonatomic, strong)NSString * play_count;

@property (nonatomic, strong)NSString * add_time;

@property (nonatomic, strong)NSString * is_show;

@property (nonatomic, strong)NSString * detail;

@property (nonatomic, assign)BOOL       is_click;//点赞

@property (nonatomic, assign)BOOL       is_collect;//收藏

@property (nonatomic, strong)NSString * money;

@property (nonatomic, strong)NSString * member_money;

@property (nonatomic, strong)NSString * money_info;

@property (nonatomic, strong)NSString * member_money_info;

@property (nonatomic, strong)NSString * member_pay_type;

@property (nonatomic, strong)NSString * pay_type;

@property (nonatomic, assign)NSInteger free_time;

@end

@interface CSTutorSpecialInfo : CSBaseModel

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSString * image;



@property (nonatomic, strong)NSString * is_pink;

@property (nonatomic, strong)NSString * abstract;

@property (nonatomic, strong)NSString * follow_count;

@property (nonatomic, assign)BOOL       is_follow;//关注




@end

@interface CSTutorMasterCourse : CSBaseModel

@property (nonatomic, strong)NSString * special_id;

@property (nonatomic, strong)NSString * source_id;

@property (nonatomic, strong)NSString * follow_count;

@property (nonatomic, strong)NSString * play_count;

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSString * task_name;

@property (nonatomic, strong)NSString * image;

@property (nonatomic, strong)NSString * name;

@end


