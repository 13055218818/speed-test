//
//  CSNewHomeRecommendModel.h
//  ColorStar
//
//  Created by apple on 2020/11/24.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSNewHomeRecommendModel : NSObject
@property (nonatomic, strong)NSString                *specialId;
@property (nonatomic, strong)NSString                *title;
@property (nonatomic, strong)NSString                *video;
@property (nonatomic, strong)NSMutableArray          *label;
@property (nonatomic, strong)NSString                *subject_name;
@property (nonatomic, strong)NSString                *browse_count;
@property (nonatomic, strong)NSString                *image;
@property (nonatomic, strong)NSString                *head_img;
@property (nonatomic, strong)NSString                *is_follow;
@property (nonatomic, strong)NSString                *add_time;
@end

@interface CSNewHomeRecommendBannerModel : NSObject
@property (nonatomic, strong)NSString           *bannerId;
@property (nonatomic, strong)NSString           *title;
@property (nonatomic, strong)NSString           *url;
@property (nonatomic, strong)NSString           *pic;
@end

@interface CSNewHomeRecommendDayModel : NSObject
@property (nonatomic, strong)NSString           *dayId;
@property (nonatomic, strong)NSString           *title;
@property (nonatomic, strong)NSString           *detail;
@property (nonatomic, strong)NSString           *type;
@property (nonatomic, strong)NSString           *image;
@end

@interface CSNewHomeRecommendInterstingModel : NSObject
@property (nonatomic, strong)NSString           *title;
@property (nonatomic, strong)NSString           *subject_id;
@property (nonatomic, strong)NSString           *is_follow;
@property (nonatomic, strong)NSString           *image;
@property (nonatomic, strong)NSString           *subject_name;
@end

@interface CSNewHomeRecommendGuitarListModel : NSObject
@property (nonatomic, strong)NSString           *guitarId;
@property (nonatomic, strong)NSString           *title;
@property (nonatomic, strong)NSString           *detail_short;
@property (nonatomic, strong)NSString           *type;
@property (nonatomic, strong)NSString           *image;
@end

@interface CSNewHomeRecommendGuitarModel : NSObject
@property (nonatomic, strong)NSString           *subject_id;
@property (nonatomic, strong)NSString           *subject_name;
@property (nonatomic, strong)NSMutableArray     *list;

@end


@interface CSNewHomeFindWeekModel : NSObject
@property (nonatomic, strong)NSString           *special_id;
@property (nonatomic, strong)NSString           *source_id;
@property (nonatomic, strong)NSString           *play_count;
@property (nonatomic, strong)NSString           *title;
@property (nonatomic, strong)NSString           *task_name;
@property (nonatomic, strong)NSString           *image;
@property (nonatomic, strong)NSString           *name;
@end


@interface CSNewHomeFindHotModel : NSObject
@property (nonatomic, strong)NSString           *hot_id;
@property (nonatomic, strong)NSString           *name;
@property (nonatomic, strong)NSString           *sort;
@property (nonatomic, strong)NSString           *add_time;
@property (nonatomic, strong)NSString           *is_del;
@property (nonatomic, strong)NSString           *pic;
@end

@interface CSNewHomeFindstudyModel : NSObject
@property (nonatomic, strong)NSString           *study_id;
@property (nonatomic, strong)NSString           *title;
@property (nonatomic, strong)NSString           *detail;
@property (nonatomic, strong)NSString           *link;
@property (nonatomic, strong)NSString           *image;
@property (nonatomic, strong)NSMutableArray           *subjec_name;
@property (nonatomic, strong)NSMutableArray           *label;
@end

@interface CSNewHomeLiveBannerModel : NSObject
@property (nonatomic, strong)NSString           *bannerId;
@property (nonatomic, strong)NSString           *live_image;
@property (nonatomic, strong)NSString           *live_title;
@property (nonatomic, strong)NSString           *countdown;
@property (nonatomic, strong)NSString           *is_countdown;
@property (nonatomic, strong)NSString           *url;
@end


@interface CSNewHomeLiveTagModel : NSObject
@property (nonatomic, strong)NSString    *subjectId;
@property (nonatomic, assign)BOOL        isSelect;

@property (nonatomic, strong)NSString  * name;
@end


@interface CSNewHomeLiveListModel : NSObject
@property (nonatomic, strong)NSString           *liveListId;
@property (nonatomic, strong)NSString           *name;
@property (nonatomic, strong)NSString           *stream_name;
@property (nonatomic, strong)NSString           *image;
@property (nonatomic, strong)NSString           *title;
@property (nonatomic, strong)NSString           *browse_count;
@property (nonatomic, strong)NSString           *is_play;
@property (nonatomic, strong)NSString           *special_id;
@property (nonatomic, strong)NSString           *playback_record_id;
@property (nonatomic, strong)NSString           *online_num;
@property (nonatomic, strong)NSString           *online_user_num;
@property (nonatomic, strong)NSString           *start_play_time;
@property (nonatomic, strong)NSString           *live_title;
@property (nonatomic, strong)NSString           *live_image;
@end
NS_ASSUME_NONNULL_END
