//
//  CSArtorCourseListCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSArtorModels.h"

typedef void(^CSArtorCourseClick)(CSArtorCourseRowModel * rowModel,NSIndexPath * index);

@interface CSArtorCourseListCell : UITableViewCell

- (void)switchToIndex:(NSInteger)index;

@property (nonatomic, strong)CSArtorDetailModel * model;

@property (nonatomic, copy)CSArtorCourseClick  courseClick;

@end

