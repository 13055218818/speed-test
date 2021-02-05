//
//  CSLiveInfoModel.h
//  ColorStar
//
//  Created by gavin on 2020/10/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 "liveInfo": {
         "id": 15,
         "stream_name": "10928160",
         "uid": 0,
         "live_title": "\u5f69\u8272\u4e16\u754c\u4e91\u97f3\u4e50\u4f1a",
         "live_image": "http:\/\/colorstar.oss-cn-hangzhou.aliyuncs.com\/b791e202008082232275053.png",
         "start_play_time": "2020-10-10 14:30:00",
         "stop_play_time": "2020-10-11 20:30:00",
         "live_introduction": "\u201c\u5f69\u8272\u4e16\u754c\u4e91\u97f3\u4e50\u4f1a\u201d\u7cfb\u5217\u6f14\u51fa\u662f\u4ee5\u201c\u65e0\u754f\uff0c\u8272\u5f69\u4e16\u754c\u201d\u4e3a\u4e3b\u9898\u7684\u3002\u5728\u5168\u7403\u6d41\u884c\u7684\u73af\u5883\u4e2d\uff0c\u5f69\u661f\u79d1\u6280\u51b3\u5fc3\u901a\u8fc7\u8fd9\u6b21\u5728\u7ebf\u6f14\u5531\u4f1a\u7ed9\u5168\u7403\u89c2\u4f17\u5e26\u6765\u6b22\u4e50\u548c\u5e0c\u671b\u3002\u56e0\u6b64\uff0c\u516c\u53f8\u5df2\u5c3d\u6700\u5927\u52aa\u529b\uff0c\u4ee5\u6700\u4f73\u7684\u8868\u73b0\u4e0e\u660e\u661f\u9635\u5bb9\u548c\u9ad8\u8d28\u91cf\u7684\u8bbe\u5907\u652f\u6301\u3002\u5f69\u661f\u79d1\u6280\u771f\u8bda\u5e0c\u671b\u4e16\u754c\u5404\u5730\u7684\u6b4c\u8ff7\u90fd\u80fd\u611f\u53d7\u5230\u201c\u4e94\u5f69\u7f24\u7eb7\u7684\u97f3\u4e50\uff0c\u4e30\u5bcc\u591a\u5f69\u7684\u751f\u6d3b\uff0c\u4e30\u5bcc\u591a\u5f69\u7684\u4e16\u754c\u201d\u7684\u7cbe\u795e",
         "special_id": 26,
         "online_user_num": 0,
         "online_num": 0,
         "studio_pwd": "",
         "is_remind": 1,
         "remind_time": 20,
         "auto_phrase": "\u6b22\u8fce\u89c2\u770b\u5f69\u8272\u4e16\u754c\u4e91\u97f3\u4e50\u4f1a",
         "add_time": 1596903482,
         "is_del": 0,
         "is_recording": 0,
         "is_play": 0,
         "recording": 0,
         "record_time": 0,
         "is_playback": 0,
         "playback_record_id": "",
         "sort": 0
     },
 */
@interface CSLiveInfoModel : NSObject

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

@end


