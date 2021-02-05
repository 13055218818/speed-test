//
//  CSHomeLiveModel.h
//  ColorStar
//
//  Created by gavin on 2020/9/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"


@interface CSHomeLiveModel : CSBaseModel

@property (nonatomic, strong)NSString  * liveId;//直播id

@property (nonatomic, strong)NSString  * title;//标题

@property (nonatomic, strong)NSString  * image;//缩略图

@property (nonatomic, strong)NSString  * browse_count;//观看次数

@property (nonatomic, strong)NSString  * is_play;//是否在直播

@property (nonatomic, strong)NSString  * playback_record_id;//回播id

@property (nonatomic, strong)NSString  * start_play_time;//开始直播的时间

@end


