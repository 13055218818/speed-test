//
//  CSArtorCourseListCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSArtorCourseListCell.h"
#import "CSArtorBriefView.h"
#import "CSArtorCourseListView.h"
#import "CSColorStar.h"

@interface CSArtorCourseListCell ()

@property (nonatomic, strong)CSArtorBriefView      * briefView;

@property (nonatomic, strong)CSArtorCourseListView * courseListView;

@end

@implementation CSArtorCourseListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    
    self.briefView = [[CSArtorBriefView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.briefView];
    
    self.courseListView = [[CSArtorCourseListView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.courseListView];
    self.courseListView.hidden = YES;
    
    CS_Weakify(self, weakSelf);
    
    self.courseListView.courseClick = ^(CSArtorCourseRowModel *rowModel, NSIndexPath *index) {
        if (weakSelf.courseClick) {
            weakSelf.courseClick(rowModel,index);
        }
    };
    
}

- (void)layoutSubviews{
    self.briefView.frame = self.contentView.bounds;
    self.courseListView.frame = self.contentView.bounds;
}

- (void)setModel:(CSArtorDetailModel *)model{
    _model = model;
    self.briefView.content = _model.special.special.content;
    self.courseListView.courses = _model.special.courses.list;
}

- (void)switchToIndex:(NSInteger)index{
    if (index == 0) {
        self.briefView.hidden = NO;
        self.courseListView.hidden = YES;
    }else{
        self.briefView.hidden = YES;
        self.courseListView.hidden = NO;
    }
}

@end
