//
//  CSCalendarNewsInfoModel.h
//  ColorStar
//
//  Created by gavin on 2020/11/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"
/**
 {
 "id": 13,... <number>
 "cid": "0",... <string>
 "title": "彩色世界，将于2020年8月8日正式内测",標題 <string>
 "author": null,... <string>
 "image_input": "http://colorstar.oss-cn-hangzhou.aliyuncs.com/0af54202007291134503187.png",封面图 <string>
 "synopsis": "彩色世界，将于2020年8月8日正式内测",简介 <string>
 -"label": [标签<array>
 "图文"
 ],
 "share_title": null,... <string>
 "share_synopsis": null,... <string>
 "visit": "102",... <string>
 "sort": 0,... <number>
 "url": null,... <string>
 "status": null,... <string>
 "add_time": "1581921949",... <string>
 "hide": 0,... <number>
 "admin_id": 0,... <number>
 "mer_id": 0,... <number>
 "is_hot": 0,... <number>
 "is_banner": 0,... <number>
 "consult_image": null,... <string>
 "consult_type": 0,... <number>
 "is_consult": 0,... <number>
 "is_show": 0,... <number>
 "show_time": 1606060800,... <number>
 "time": "十一月二十三号"日期 <string>
 }
 */
@interface CSCalendarNewsInfoModel : CSBaseModel

@property (nonatomic, strong)NSString  * newsId;

@property (nonatomic, strong)NSString  * cid;

@property (nonatomic, strong)NSString  * title;

@property (nonatomic, strong)NSString  * author;

@property (nonatomic, strong)NSString  * image_input;

@property (nonatomic, strong)NSString  * synopsis;

@property (nonatomic, strong)NSArray   * label;

@property (nonatomic, strong)NSString  * share_title;

@property (nonatomic, strong)NSString  * share_synopsis;

@property (nonatomic, strong)NSString  * visit;

@property (nonatomic, strong)NSString  * sort;

@property (nonatomic, strong)NSString  * url;

@property (nonatomic, strong)NSString  * status;

@property (nonatomic, strong)NSString  * add_time;

@property (nonatomic, strong)NSString  * hide;

@property (nonatomic, strong)NSString  * admin_id;

@property (nonatomic, strong)NSString  * is_hot;

@property (nonatomic, strong)NSString  * is_banner;

@property (nonatomic, strong)NSString  * consult_image;

@property (nonatomic, strong)NSString  * consult_type;

@property (nonatomic, strong)NSString  * is_consult;

@property (nonatomic, strong)NSString  * is_show;

@property (nonatomic, strong)NSString  * show_time;

@property (nonatomic, strong)NSString  * time;

@property (nonatomic, strong)NSString  * web_url;

@end


