//
//  CSTutorDetailModel.h
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
 "id": 21,... <number>
 "title": "魏巡",导师名称 <string>
 "subject_id": 37,... <number>
 "admin_id": 0,... <number>
 "type": 1,... <number>
 "abstract": "魏巡（Win），天娱传媒旗下签约艺人，中国内地流行乐男歌手。2008年，参加江苏卫视选秀娱乐节目《绝对唱响》比赛，获得武汉赛区八强，从而正式进入演艺圈；同年，获得“第13届CCTV全国青年歌手电视大奖赛”通俗唱法金奖。2009年，获得“第二届光谷音乐节”自由组冠军、最佳台风奖。2011年，参加“全国K歌之王选拔赛”，获得全国总决赛冠军。2014年，加入方向乐团，并担任主唱；2015年，担任“第二届SING星索原创中国流行音乐网络大赛”的评委。2017年，相继推出个人单曲《Hey We Go》、《I Miss U》；同年9月获得《快乐男声》全国冠军，签约天娱传媒公司。2019全新首发创作专辑《我的光》，魏巡在专辑中统领制作、词曲创作的硬实力。《我的光》不以传统流行讨巧的做法，更强调了魏巡作为制作人的能力与胆识。2020年6月10日全新单曲《星星断了线》一经发出就大获好评。魏巡有着独具特色的嗓音，用音乐带动氛围，对音乐有着超群的驾驭能力 。拥有青春有型的脸庞、偶像般的气质，独有的魅力和活力具有极强的舞台感染力 。",... <string>
 "phrase": "魏巡演唱技巧",简介 <string>
 "image": "http://colorstar.oss-cn-hangzhou.aliyuncs.com/9bd24202008081717106504.jpg",封面图 <string>
 "video": null,... <string>
 -"label": [标签<array>
 "演唱技巧"
 ],
 -"banner": [banner图片(达到五张才使用)<array>
 "http://colorstar.oss-cn-hangzhou.aliyuncs.com/0d3c6202008081717032016.jpg"
 ],
 "poster_image": "http://colorstar.oss-cn-hangzhou.aliyuncs.com/1c164202007251427561586.jpg",海报图片 <string>
 "service_code": "http://colorstar.oss-cn-hangzhou.aliyuncs.com/3aabb202007292306583962.jpg",客服二维码 <string>
 "is_show": 1,... <number>
 "is_del": 0,... <number>
 "is_live": 0,... <number>
 "money": "0.00",金额 <string>
 "pink_money": "0.00",... <string>
 "is_pink": 0,... <number>
 "pink_number": 0,... <number>
 "pink_strar_time": "",... <string>
 "pink_end_time": "",... <string>
 "pink_time": 0,... <number>
 "is_fake_pink": 1,... <number>
 "fake_pink_number": 0,... <number>
 "sort": 0,... <number>
 "sales": 0,... <number>
 "fake_sales": 0,... <number>
 "browse_count": 95,... <number>
 "add_time": "2020-08-08 21:15:06",... <string>
 "pay_type": 0,... <number>
 "member_pay_type": 0,... <number>
 "member_money": "0.00",... <string>
 "link": "",... <string>
 -"task_list": [课程列表<array>
 -{
 "id": 33,... <number>
 "title": "魏巡演唱技巧大师课",课程名称 <string>
 "image": "http://colorstar.oss-cn-hangzhou.aliyuncs.com/0d3c6202008081717032016.jpg",课程封面图 <string>
 "play_count": 21播放次数 <number>
 }
 ],
 "task_count": 1,课程数量 <number>
 "play_count": 21,播放总量 <number>
 "follow_count": 0,关注量 <number>
 "is_follow": 0,是否关注 <number>
 -"discuss_list": [评论列表<array>
 -{
 "id": 2,... <number>
 "uid": 1165,... <number>
 "content": "测试测试内容内容",评论内容 <string>
 "click_count": 0,... <number>
 "ruid": 0,... <number>
 "rid": 0,... <number>
 "add_time": "2020-11-12",评论时间 <string>
 "nickname": "13055218818",评论人昵称 <string>
 "account": "13055218818",评论人账号 <string>
 "avatar": "/system/images/user_log.jpg",头像 <string>
 "user_name": "13055218818",... <string>
 "down_info": [ ],
 "is_click": 0是否点赞 <number>
 }
 ],
 -"round_tasks": [随机课程信息<array>
 -{
 "id": 194,... <number>
 "title": "杨硕《Gashina》第一课  整舞展示",课程名称 <string>
 "special_id": 0,... <number>
 "play_count": 1,播放次数 <number>
 "add_time": "2020-09-25",添加时间 <string>
 "special_title": null专题名称 <string>
 }
 ]
 },
 "count": 0... <number>
 }
 */

@interface CSTutorDetailModel : CSBaseModel

@property (nonatomic, strong)NSString * tutorId;

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSString * subject_id;

@property (nonatomic, strong)NSString * admin_id;

@property (nonatomic, strong)NSString * type;

@property (nonatomic, strong)NSString * abstract;

@property (nonatomic, strong)NSString * phrase;

@property (nonatomic, strong)NSString * image;

@property (nonatomic, strong)NSString * video;

@property (nonatomic, strong)NSArray  * label;

@property (nonatomic, strong)NSArray  * banner;

@property (nonatomic, strong)NSString * poster_image;

@property (nonatomic, strong)NSString * service_code;

@property (nonatomic, strong)NSString * is_show;

@property (nonatomic, strong)NSString * is_del;

@property (nonatomic, strong)NSString * is_live;

@property (nonatomic, strong)NSString * money;

@property (nonatomic, strong)NSString * pink_money;

@property (nonatomic, strong)NSString * is_pink;

@property (nonatomic, strong)NSString * pink_number;

@property (nonatomic, strong)NSString * pink_strar_time;

@property (nonatomic, strong)NSString * pink_end_time;

@property (nonatomic, strong)NSString * pink_time;

@property (nonatomic, strong)NSString * is_fake_pink;

@property (nonatomic, strong)NSString * fake_pink_number;

@property (nonatomic, strong)NSString * sort;

@property (nonatomic, strong)NSString * sales;

@property (nonatomic, strong)NSString * fake_sales;

@property (nonatomic, strong)NSString * browse_count;

@property (nonatomic, strong)NSString * add_time;

@property (nonatomic, strong)NSString * pay_type;

@property (nonatomic, strong)NSString * member_pay_type;

@property (nonatomic, strong)NSString * member_money;

@property (nonatomic, strong)NSString * link;

@property (nonatomic, strong)NSArray  * task_list;

@property (nonatomic, strong)NSString * task_count;

@property (nonatomic, strong)NSString * play_count;

@property (nonatomic, strong)NSString * follow_count;

@property (nonatomic, assign)BOOL       is_follow;

@property (nonatomic, strong)NSArray  * discuss_list;

@property (nonatomic, strong)NSArray  * round_tasks;

@property (nonatomic, assign)BOOL       shouldExpand;

@property (nonatomic, assign)CGFloat       textHeight;

@property (nonatomic, assign)BOOL       expanding;

@property (nonatomic, assign)BOOL       showBanner;

@end

@interface CSTutorCourseModel : CSBaseModel

@property (nonatomic, strong)NSString * courseId;

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSString * image;

@property (nonatomic, strong)NSString * play_count;

@property (nonatomic, strong)NSString * special_id;

@property (nonatomic, strong)NSString * add_time;

@property (nonatomic, strong)NSString * special_title;


@end

