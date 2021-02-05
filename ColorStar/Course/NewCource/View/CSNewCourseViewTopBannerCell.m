//
//  CSNewCourseViewTopBannerCell.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewCourseViewTopBannerCell.h"

@implementation CSNewCourseViewTopBannerCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.icon = [UIImageView new];
        self.icon.clipsToBounds = YES;
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        self.icon.layer.masksToBounds = YES;
        [self.contentView addSubview:self.icon];
        self.icon.frame = self.contentView.bounds;
        ViewRadius(self.contentView, 10);
        self.userInteractionEnabled = YES;
        self.icon.userInteractionEnabled = YES;
        
    }
    return self;
}


@end
