//
//  CSArtorModels.h
//  ColorStar
//
//  Created by gavin on 2020/8/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"
#import "CSLiveInfoModel.h"

/*
 "id": 28,
 "coures_id": 0,
 "special_id": "17",
 "title": "\u5f20\u65d7\u683c\u7235\u58eb\u821e\u9ad8\u7ea7\u6559\u7a0b",
 "content": "<p><br\/><\/p><div><video style=\"width: 100%\" src=\"http:\/\/colorstar.oss-cn-hangzhou.aliyuncs.com\/D2yHD2cNBHR4CjJyTn.mp4\" class=\"video-ue\" controls=\"controls\"><\/video><\/div><p><span style=\"color:white\">.<\/span><\/p>",
 "detail": "<p>\u5f20\u65d7\u683c\u7235\u58eb\u821e\u9ad8\u7ea7\u6559\u7a0b<\/p>",
 "type": 3,
 "is_pay": 0,
 "link": "http:\/\/colorstar.oss-cn-hangzhou.aliyuncs.com\/D2yHD2cNBHR4CjJyTn.mp4",
 "image": "http:\/\/colorstar.oss-cn-hangzhou.aliyuncs.com\/ad6db202008081717099534.jpg",
 "abstract": "",
 "sort": 0,
 "play_count": 3,
 "is_show": 1,
 "add_time": 1596891486,
 "edit_time": 0,
 "live_id": 0,
 "pay_status": 0,
 "type_name": "\u89c6\u9891\u4e13\u9898",
 "taskTrue": false
 */

typedef NS_ENUM(NSUInteger, CSCourseType) {
    CSCourseTypeNone,
    CSCourseTypeImageText = 1,//图文
    CSCourseTypeAudio,//音频
    CSCourseTypeVideo,//视频
   
};


@interface CSArtorCourseRowModel : CSBaseModel

@property (nonatomic, strong)NSString  * rowId;

@property (nonatomic, strong)NSString  * coures_id;

@property (nonatomic, strong)NSString  * special_id;

@property (nonatomic, strong)NSString  * title;

@property (nonatomic, strong)NSString  * content;

@property (nonatomic, strong)NSString  * detail;

@property (nonatomic, assign)NSInteger   type;

@property (nonatomic, assign)NSInteger   is_pay;

@property (nonatomic, strong)NSString  * link;

@property (nonatomic, strong)NSString  * image;

@property (nonatomic, strong)NSString  * abstract;

@property (nonatomic, assign)NSInteger   sort;

@property (nonatomic, assign)NSInteger   play_count;

@property (nonatomic, assign)NSInteger   is_show;

@property (nonatomic, strong)NSString   * add_time;

@property (nonatomic, strong)NSString   * edit_time;

@property (nonatomic, strong)NSString   * live_id;

@property (nonatomic, assign)NSInteger    pay_status;

@property (nonatomic, strong)NSString   * type_name;

@property (nonatomic, assign)BOOL         taskTrue;

@property (nonatomic, assign)CSCourseType  courseType;

@end


@interface CSArtorCourseSectionModel : CSBaseModel

@property (nonatomic, assign)NSInteger  page;

@property (nonatomic, strong)NSArray   * list;

@end



@interface CSArtorSpecialDetailProfileModel : CSBaseModel

@property (nonatomic, strong)NSString  * content;

@end

@interface CSArtorSpecialDetailModel : CSBaseModel

@property (nonatomic, strong)NSString  * specialId;

@property (nonatomic, strong)NSString  * title;

@property (nonatomic, strong)NSString  * subject_id;

@property (nonatomic, strong)NSString  * admin_id;

@property (nonatomic, assign)NSInteger   type;

@property (nonatomic, assign)NSString  * abstract;

@property (nonatomic, strong)NSString  * phrase;

@property (nonatomic, strong)NSString  * image;

@property (nonatomic, strong)NSString  * video;

@property (nonatomic, strong)NSString  * banner;

@property (nonatomic, strong)NSString  * poster_image;

@property (nonatomic, strong)NSString  * service_code;

@property (nonatomic, assign)NSInteger   is_show;

@property (nonatomic, assign)NSInteger   is_del;

@property (nonatomic, assign)NSInteger   is_live;

@property (nonatomic, strong)NSString    *money;

@property (nonatomic, strong)NSString    *price;

@property (nonatomic, strong)NSString    *pink_money;

@property (nonatomic, assign)NSInteger    is_pink;

@property (nonatomic, assign)NSInteger    pink_number;

@property (nonatomic, strong)NSString    *pink_strar_time;

@property (nonatomic, strong)NSString    *pink_end_time;

@property (nonatomic, assign)NSInteger    pink_time;

@property (nonatomic, assign)NSInteger    is_fake_pink;

@property (nonatomic, assign)NSInteger    fake_pink_number;

@property (nonatomic, assign)NSInteger    sort;

@property (nonatomic, assign)NSInteger    sales;

@property (nonatomic, assign)NSInteger    fake_sales;

@property (nonatomic, strong)NSString    *browse_count;

@property (nonatomic, strong)NSString    *add_time;

@property (nonatomic, assign)NSInteger    pay_type;

@property (nonatomic, assign)NSInteger    member_pay_type;

@property (nonatomic, strong)NSString    *member_money;

@property (nonatomic, strong)NSString    *link;

@property (nonatomic, assign)BOOL         collect;

@property (nonatomic, strong)NSString    *content;

@property (nonatomic, strong)NSArray     *label;

@property (nonatomic, strong)CSArtorSpecialDetailProfileModel  * profile;

@end


@interface CSArtorSpecialModel : CSBaseModel

@property (nonatomic, strong)NSArray  * swiperlist;

@property (nonatomic, strong)NSString * title;

@property (nonatomic, strong)NSArray  * pinkUser;

@property (nonatomic, strong)NSArray  * pinkIngList;

@property (nonatomic, strong)CSArtorSpecialDetailModel  * special;

@property (nonatomic, strong)CSArtorCourseSectionModel  * courses;


@end

@interface CSArtorConfigModel : CSBaseModel

@property (nonatomic, strong)NSString  * site_name;

@property (nonatomic, strong)NSString  * seo_title;

@property (nonatomic, strong)NSString  * site_logo;

@end


@interface CSArtorDetailModel : CSBaseModel

@property (nonatomic, assign)NSInteger code;

@property (nonatomic, strong)CSArtorConfigModel * confing;

@property (nonatomic, strong)CSArtorSpecialModel  * special;

@property (nonatomic, assign)NSInteger pinkId;

@property (nonatomic, assign)NSInteger is_member;

@property (nonatomic, assign)NSInteger count;

@property (nonatomic, assign)BOOL      isPink;

@property (nonatomic, assign)BOOL      isPay;

@property (nonatomic, strong)CSLiveInfoModel   *liveInfo;

@property (nonatomic, strong)NSString  * orderId;

@property (nonatomic, strong)NSString  * partake;

@property (nonatomic, strong)NSString  * link_pay;

@property (nonatomic, strong)NSString  * gift;

@property (nonatomic, strong)NSString  * link_pay_uid;

@property (nonatomic, strong)NSString  * BarrageShowTime;

@property (nonatomic, strong)NSString  * barrage_index;

@end


