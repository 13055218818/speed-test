//
//  CSLiveModel.h
//  ColorStar
//
//  Created by gavin on 2020/10/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSLiveInfoModel.h"
#import "CSLiveGiftModel.h"
#import "CSChatModel.h"
#import "CSLiveRewardModel.h"


@interface CSLiveGoldInfoModel : NSObject

@property (nonatomic, strong)NSString  * gold_rate;

@property (nonatomic, strong)NSString  * gold_name;

@property (nonatomic, strong)NSString  * gold_image;

@end


@interface CSLiveWorkermanModel : NSObject

@property (nonatomic, strong)NSString  * name;

@property (nonatomic, strong)NSString  * count;

@property (nonatomic, strong)NSString  * protocol;

@property (nonatomic, strong)NSString  * ip;

@property (nonatomic, strong)NSString  * port;

@end

/**
 "type": 1,
"content": "testeststt",
"uid": 1,
"live_id": 15,
 "id": 87,
 "nickname": "\u83b1",
"avatar": "http:\/\/thirdwx.qlogo.cn\/mmopen\/yhZQjNNOKR5e1x4Xic1C3bev7hNwQ1sl3JJIQRRhwo5Q4dODuicRpSibUeaLFHUPvVnWQzicmbRvEVaAlMmzJsxsgw\/132",
                 "user_type": 2
 "gift_num": 5,
                 "gift_image": "http:\/\/cremb-zsff.oss-cn-beijing.aliyuncs.com\/5a2d520200701101025960.png",
                 "gift_name": "\u7231\u5fc3"
 */
@interface CSLiveOpenCommentDetailModel : NSObject

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


- (CSChatModel*)transformChatModel;

@end

@interface CSLiveOpenCommentModel : NSObject

@property (nonatomic, strong)NSArray<CSLiveOpenCommentDetailModel*> * list;

@property (nonatomic, assign)NSInteger page;

@end

/**
 {
     "code": 200,
     "msg": "ok",
     "data": {
         "errorCode": 0,
         "goldInfo": {
             "gold_rate": "10",
             "gold_name": "\u91d1\u5e01",
             "gold_image": "http:\/\/cremb-zsff.oss-cn-beijing.aliyuncs.com\/61d9d202006181439471781.png"
         },
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
             "sort": 0,
             "abstract": "\u201c\u5f69\u8272\u4e16\u754c\u4e91\u97f3\u4e50\u4f1a\u201d\u7cfb\u5217\u6f14\u51fa\u662f\u4ee5\u201c\u65e0\u754f\uff0c\u8272\u5f69\u4e16\u754c\u201d\u4e3a\u4e3b\u9898\u7684\u3002\u5728\u5168\u7403\u6d41\u884c\u7684\u73af\u5883\u4e2d\uff0c\u5f69\u661f\u79d1\u6280\u51b3\u5fc3\u901a\u8fc7\u8fd9\u6b21\u5728\u7ebf\u6f14\u5531\u4f1a\u7ed9\u5168\u7403\u89c2\u4f17\u5e26\u6765\u6b22\u4e50\u548c\u5e0c\u671b\u3002\u56e0\u6b64\uff0c\u516c\u53f8\u5df2\u5c3d\u6700\u5927\u52aa\u529b\uff0c\u4ee5\u6700\u4f73\u7684\u8868\u73b0\u4e0e\u660e\u661f\u9635\u5bb9\u548c\u9ad8\u8d28\u91cf\u7684\u8bbe\u5907\u652f\u6301\u3002\u5f69\u661f\u79d1\u6280\u771f\u8bda\u5e0c\u671b\u4e16\u754c\u5404\u5730\u7684\u6b4c\u8ff7\u90fd\u80fd\u611f\u53d7\u5230\u201c\u4e94\u5f69\u7f24\u7eb7\u7684\u97f3\u4e50\uff0c\u4e30\u5bcc\u591a\u5f69\u7684\u751f\u6d3b\uff0c\u4e30\u5bcc\u591a\u5f69\u7684\u4e16\u754c\u201d\u7684\u7cbe\u795e"
         },
         "UserSum": "0",
         "live_title": "\u5f69\u8272\u4e16\u754c\u4e91\u97f3\u4e50\u4f1a",
         "PullUrl": "http:\/\/pullhls8e1afca7.live.126.net\/live\/7951ba1547404dddaba50169d44ace0d\/playlist.m3u8",
         "is_ban": 0,
         "room": 15,
         "datatime": 1602311400,
         "workerman": {
             "name": "CRMEB_ZSFF",
             "count": 2,
             "protocol": "websocket",
             "ip": "0.0.0.0",
             "port": "20014"
         },
         "phone_type": 3,
         "live_status": 1,
         "user_type": 2,
         "OpenCommentCount": 0,
         "OpenCommentTime": null,
         "CommentCount": 0,
         "CommentTime": null
     },
     "count": 0
 }
 */

@interface CSLiveModel : NSObject

@property (nonatomic, strong)CSLiveGoldInfoModel    * goldInfo;

@property (nonatomic, strong)CSLiveInfoModel        * liveInfo;

@property (nonatomic, strong)NSString               * UserSum;

@property (nonatomic, strong)NSString               * live_title;

@property (nonatomic, strong)NSString               * PullUrl;

@property (nonatomic, strong)NSString               * is_ban;

@property (nonatomic, strong)NSString               * room;

@property (nonatomic, strong)NSString               * datatime;

@property (nonatomic, strong)NSString               * phone_type;

@property (nonatomic, strong)NSString               * live_status;

@property (nonatomic, strong)NSString               * user_type;

@property (nonatomic, strong)NSString               * OpenCommentCount;

@property (nonatomic, strong)NSString               * OpenCommentTime;

@property (nonatomic, strong)NSString               * CommentCount;

@property (nonatomic, strong)NSString               * CommentTime;

@property (nonatomic, strong)CSLiveWorkermanModel   * workerman;

@property (nonatomic, strong)CSLiveOpenCommentModel * OpenComment;

@property (nonatomic, strong)NSArray<CSLiveGiftModel*>        * live_gift;

@property (nonatomic, strong)CSLiveRewardModel      * live_reward;

@end


