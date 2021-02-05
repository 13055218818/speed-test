//
//  CSNewArtorCourseCell.h
//  ColorStar
//
//  Created by 陶涛 on 2020/11/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSBaseTableCell.h"

typedef void(^CSTutorCourseListCellBlock)(id obj);

@interface CSTutorCourseListCell : CSBaseTableCell

@property (nonatomic, copy)CSTutorCourseListCellBlock cellBlock;

@end


