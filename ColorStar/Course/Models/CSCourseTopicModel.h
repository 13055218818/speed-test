//
//  CSCourseTopicModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/8.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

@interface CSCourseTopicModel : CSBaseModel

@property (nonatomic, strong)NSString  * browse_count;

@property (nonatomic, strong)NSString  * count;

@property (nonatomic, strong)NSString  * topicId;

@property (nonatomic, strong)NSString  * image;

@property (nonatomic, strong)NSString  * is_pink;

@property (nonatomic, strong)NSArray   * label;

@property (nonatomic, strong)NSString  * money;

@property (nonatomic, strong)NSString  * pink_money;

@property (nonatomic, strong)NSString  * subject_id;

@property (nonatomic, strong)NSString  * subject_name;

@property (nonatomic, strong)NSString  * type;


@property (nonatomic, strong)NSString  * thumbnail;//缩略图

@property (nonatomic, strong)NSString  * title;//标题

@property (nonatomic, strong)NSString  * subject;//简介

@property (nonatomic, strong)NSString  * price;//价格

@property (nonatomic, strong)NSString  * course;//课程数

@property (nonatomic, strong)NSString  * studies;//学习人数

@end


