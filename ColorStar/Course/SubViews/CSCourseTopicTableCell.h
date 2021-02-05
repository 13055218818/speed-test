//
//  CSCourseTopicTableCell.h
//  ColorStar
//
//  Created by gavin on 2020/8/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSCourseTopicModel.h"


@interface CSCourseTopicTableCell : UITableViewCell

@property (nonatomic, strong)CSCourseTopicModel * baseModel;

- (void)configModel:(CSCourseTopicModel*)model;

@end


