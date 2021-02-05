//
//  CSCourseTopView.m
//  ColorStar
//
//  Created by gavin on 2020/8/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseTopView.h"
#import "UIColor+CS.h"

@interface CSCourseTopView ()

@property (nonatomic, strong)UIView * playContainer;

@property (nonatomic, strong)CSArtorCourseRowModel * detailModel;

@end

@implementation CSCourseTopView

- (instancetype)initWithModel:(CSArtorCourseRowModel*)detailModel{
    if (self = [super init]) {
        _detailModel = detailModel;
        self.backgroundColor = [UIColor colorWithHexString:@"#111111"];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
}

@end
