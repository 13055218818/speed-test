//
//  CSNewArtorCoursePreviewCell.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTableCell.h"

typedef void(^CSTutorCoursePreviewBlock)(void);
@interface CSTutorCoursePreviewCell : CSBaseTableCell

@property (nonatomic,copy)CSTutorCoursePreviewBlock  previewBlock;


@end


