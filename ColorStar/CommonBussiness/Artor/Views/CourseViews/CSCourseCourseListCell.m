//
//  CSCourseCourseListCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseCourseListCell.h"
#import "CSCourseBriefView.h"
#import "CSCourseCourseListView.h"
#import "CSColorStar.h"

@interface CSCourseCourseListCell ()

@property (nonatomic, strong)CSCourseBriefView      * briefView;

@property (nonatomic, strong)CSCourseCourseListView * courseListView;

@end


@implementation CSCourseCourseListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    
    self.briefView = [[CSCourseBriefView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.briefView];
    
    self.courseListView = [[CSCourseCourseListView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:self.courseListView];
    self.courseListView.hidden = YES;
    
    CS_Weakify(self, weakSelf);
//    self.courseListView.courseClick = ^(CSArtorCourseRowModel *rowModel) {
//        if (weakSelf.courseClick) {
//            weakSelf.courseClick(rowModel);
//        }
//    };
    
    self.courseListView.courseClick = ^(NSInteger index) {
        weakSelf.index = index;
        if (weakSelf.courseClick) {
            weakSelf.courseClick(index);
        }
    };
}

- (void)layoutSubviews{
    self.briefView.frame = self.contentView.bounds;
    self.courseListView.frame = self.contentView.bounds;
}



- (void)setModels:(NSArray *)models{
    _models = models;
    self.courseListView.courses = _models;
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    CSArtorCourseRowModel * rowModel = self.models[_index];
    self.briefView.content = rowModel.detail;
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
