//
//  CSHomeTopicSectionModel.h
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseModel.h"

typedef NS_ENUM(NSUInteger, CSHomeTopicSectionType) {
    CSHomeTopicSectionTypeNone = 0,
    CSHomeTopicSectionTypeBig,//大图
    CSHomeTopicSectionTypeSmall,//小图
    CSHomeTopicSectionTypeSquare,//宫图
    CSHomeTopicSectionTypeCheck//左右切换
};


@interface CSHomeTopicSectionModel : CSBaseModel

@property (nonatomic, strong)NSString   * sectionId;

@property (nonatomic, strong)NSString   * typesetting;

@property (nonatomic, strong)NSString   * title;

@property (nonatomic, strong)NSString   * type;

@property (nonatomic, strong)NSString   * image;

@property (nonatomic, strong)NSString   * grade_id;

@property (nonatomic, strong)NSString   * show_count;

@property (nonatomic, strong)NSString   * sum_count;

@property (nonatomic, strong)NSArray    * list;

@property (nonatomic, strong)NSString   * ceilCount;

@property (nonatomic, strong)NSString   * courseIndex;

@property (nonatomic, assign)CSHomeTopicSectionType   sectionType;

@property (nonatomic, assign)BOOL         showHead;

@property (nonatomic, assign)BOOL  liveSection;

@end


