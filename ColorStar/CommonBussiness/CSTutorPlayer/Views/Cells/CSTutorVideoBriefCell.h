//
//  CSVideoTutorBriefCell.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTableCell.h"

typedef enum : NSUInteger {
    CSTutorVideoBriefBlockTypeLike,//点赞
    CSTutorVideoBriefBlockTypeShare,//分享
    CSTutorVideoBriefBlockTypeCollect,//收藏
    CSTutorVideoBriefBlockTypeFollow,//关注
} CSTutorVideoBriefBlockType;

typedef void(^CSTutorVideoBriefBlock)(CSTutorVideoBriefBlockType type);

@interface CSTutorVideoBriefCell : CSBaseTableCell

@property (nonatomic, copy)CSTutorVideoBriefBlock briefBlock;
@property (nonatomic, strong)UILabel      * briefRightLabel;
@end

