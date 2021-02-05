//
//  CSTutorNewestCommonCell.h
//  ColorStar
//
//  Created by gavin on 2020/11/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTableCell.h"

typedef enum : NSUInteger {
    CSTutorNewestCommentBlockLike,
    CSTutorNewestCommentBlockReply,
} CSTutorNewestCommentBlockType;

typedef void(^CSTutorNewestCommentBlock)(CSTutorNewestCommentBlockType type, id data);

@interface CSTutorNewestCommentCell : CSBaseTableCell

@property (nonatomic, copy)CSTutorNewestCommentBlock  commonBlock;


@end


