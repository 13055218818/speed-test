//
//  CSArtorCourseListView.h
//  ColorStar
//
//  Created by gavin on 2020/8/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSArtorModels.h"

typedef void(^CSArtorCourseListClick)(CSArtorCourseRowModel * rowModel,NSIndexPath * index);
@interface CSArtorCourseListView : UIView

@property (nonatomic, strong)NSArray * courses;

@property (nonatomic, copy)CSArtorCourseListClick  courseClick;

@end


