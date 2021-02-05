//
//  CSHomeNewsModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSHomePressModel : CSBaseModel

@property (nonatomic, strong)NSString  * pressId;

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

@property (nonatomic, strong)NSString  * mer_id;

@property (nonatomic, strong)NSString  * is_hot;

@property (nonatomic, strong)NSString  * is_banner;

@property (nonatomic, strong)NSString  * consult_image;

@property (nonatomic, strong)NSString  * consult_type;

@property (nonatomic, strong)NSString  * is_consult;

@property (nonatomic, strong)NSString  * is_show;

@end

NS_ASSUME_NONNULL_END
