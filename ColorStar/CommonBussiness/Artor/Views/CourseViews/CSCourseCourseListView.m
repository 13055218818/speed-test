//
//  CSCourseCourseListView.m
//  ColorStar
//
//  Created by gavin on 2020/8/20.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseCourseListView.h"
#import <Masonry.h>
#import "CSArtorModels.h"


@interface CSCourseCourseListItemCell : UITableViewCell

@property (nonatomic, strong)UILabel  * titleLabel;

@property (nonatomic, strong)UILabel  * abstractLabel;

@property (nonatomic, strong)UIImageView * playIcon;

@property (nonatomic, strong)UIView   * bottomLine;

@property (nonatomic, strong)CSArtorCourseRowModel * model;

@end

@implementation CSCourseCourseListItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor blackColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.abstractLabel];
    [self.contentView addSubview:self.playIcon];
    [self.contentView addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(14);
        make.width.mas_equalTo(30);
    }];
    
    [self.abstractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.contentView).offset(-40);
    }];
    
    [self.playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.abstractLabel);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.abstractLabel);
        make.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
}

- (void)setModel:(CSArtorCourseRowModel *)model{
    _model = model;
    self.abstractLabel.text = _model.title;
}

#pragma mark - Properties Method

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.38];
    }
    return _titleLabel;
}

- (UILabel*)abstractLabel{
    if (!_abstractLabel) {
        _abstractLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _abstractLabel.textColor = [UIColor whiteColor];
        _abstractLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _abstractLabel;
}

- (UIImageView*)playIcon{
    if (!_playIcon) {
        _playIcon = [[UIImageView alloc]initWithFrame:CGRectZero];
        _playIcon.image = [UIImage imageNamed:@"cs_video_play_icon"];
    }
    return _playIcon;
}

- (UIView*)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.12];
    }
    return _bottomLine;
}


@end

NSString * const CSCourseCourseListItemCellReuseIdentifier = @"CSCourseCourseListItemCellReuseIdentifier";

@interface CSCourseCourseListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;

@end

@implementation CSCourseCourseListView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self setUpViews];
    }
    return self;
}


- (void)setUpViews{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CSCourseCourseListItemCell class] forCellReuseIdentifier:CSCourseCourseListItemCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.tableView];
    
}

- (void)setCourses:(NSArray *)courses{
    _courses = courses;
    [self.tableView reloadData];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

#pragma mark - UITableView Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.courses.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CSCourseCourseListItemCell * itemCell = [tableView dequeueReusableCellWithIdentifier:CSCourseCourseListItemCellReuseIdentifier forIndexPath:indexPath];
    NSInteger number = indexPath.row + 1;
    NSString * string;
    if (number > 9) {
        string = [NSString stringWithFormat:@"%li",(long)number];
    }else{
        string = [NSString stringWithFormat:@"0%li",(long)number];
    }
    itemCell.titleLabel.text = string;
    itemCell.model = self.courses[indexPath.row];
    itemCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return itemCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.courseClick) {
        self.courseClick(indexPath.row);
    }
    
}

@end
