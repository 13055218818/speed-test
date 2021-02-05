//
//  CSCourseCourseListCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSArtorModels.h"

typedef void(^CSCourseCourseClick)(NSInteger index);

@interface CSCourseCourseListCell : UITableViewCell

- (void)switchToIndex:(NSInteger)index;

@property (nonatomic, assign)NSInteger  index;

@property (nonatomic, strong)NSArray * models;

@property (nonatomic, copy)CSCourseCourseClick  courseClick;

@end


