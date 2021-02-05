//
//  CSMediaInfoModel.h
//  ColorStar
//
//  Created by gavin on 2021/1/29.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSBaseModel.h"


@interface CSMediaInfoModel : CSBaseModel

@property (nonatomic, strong)NSString   *live_id;

@property (nonatomic, strong)NSString   *live_image;

@property (nonatomic, strong)NSString   *live_title;

@property (nonatomic, strong)NSString   *url;

@property (nonatomic, strong)NSString   *topic;

@end


