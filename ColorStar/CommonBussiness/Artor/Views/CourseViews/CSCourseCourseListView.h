//
//  CSCourseCourseListView.h
//  ColorStar
//
//  Created by gavin on 2020/8/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSArtorModels.h"

typedef void(^CSCourseCourseClick)(NSInteger index);


@interface CSCourseCourseListView : UIView

@property (nonatomic, strong)NSArray * courses;

@property (nonatomic, copy)CSCourseCourseClick  courseClick;

@end

