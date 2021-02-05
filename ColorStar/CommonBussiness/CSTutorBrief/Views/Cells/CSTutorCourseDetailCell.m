//
//  CSNewArtorCourseDetailCell.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorCourseDetailCell.h"
#import "CSColorStar.h"
#import "CSTutorDetailModel.h"




@interface CSTutorCourseDetailCell ()

@property (nonatomic, strong)UIView * containerView;

@property (nonatomic, strong)UIImageView  * backImageView;

@property (nonatomic, strong)UIImageView  * timeImageView;

@property (nonatomic, strong)UILabel      * timeLabel;

@property (nonatomic, strong)UILabel      * nameLabel;

@property (nonatomic, strong)UIImageView  * eyeImageView;

@property (nonatomic, strong)UILabel      * eyeLabel;

@property (nonatomic, strong)UILabel      * dateLabel;

@property (nonatomic, strong)CSTutorCourseModel  * course;
@end

@implementation CSTutorCourseDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.backImageView];
    [self.containerView addSubview:self.timeImageView];
    [self.containerView addSubview:self.timeLabel];
    [self.containerView addSubview:self.nameLabel];
    [self.containerView addSubview:self.eyeLabel];
    [self.containerView addSubview:self.eyeImageView];
    [self.containerView addSubview:self.dateLabel];
    self.timeImageView.hidden = YES;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
        make.top.mas_equalTo(self.contentView);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.containerView).offset(15);
        make.bottom.mas_equalTo(self.containerView).offset(-15);
        make.width.mas_equalTo(140);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backImageView.mas_right).offset(15);
        make.right.mas_equalTo(self.containerView).offset(-15);
        make.top.mas_equalTo(self.containerView).offset(25);
        make.bottom.mas_lessThanOrEqualTo(self.eyeLabel.mas_top).offset(5);
    }];
    
    [self.eyeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.containerView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(20, 14));
    }];
    
    [self.eyeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.eyeImageView);
        make.left.mas_equalTo(self.eyeImageView.mas_right).offset(5);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.eyeLabel);
        make.right.mas_equalTo(self.nameLabel);
    }];
    
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.backImageView).offset(-5);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.timeImageView);
    }];
}

- (CGSize)collectionCellSize{
    return CGSizeMake(ScreenW, 130);
}

- (void)mockData{
    self.backImageView.backgroundColor = [UIColor redColor];
    self.nameLabel.text = @"《因为爱情》歌曲展示...";
    self.timeLabel.text = @"09:46";
    self.dateLabel.text = @"2020/11/03";
    self.eyeLabel.text = @"256";
    self.eyeImageView.image = LoadImage(@"cs_artor_new_course_detail_eye");
    self.timeImageView.image = LoadImage(@"cs_artor_new_course_detail_time");
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSTutorCourseModel class]]) {
        return;
    }
    
    self.course = model;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:self.course.image] placeholderImage:LoadImage(@"")];
    self.nameLabel.text = self.course.title;
    self.timeLabel.text = @"";
    self.dateLabel.text = self.course.add_time;
    self.eyeLabel.text = self.course.play_count;
    self.eyeImageView.image = LoadImage(@"cs_artor_new_course_detail_eye");
    self.timeImageView.image = LoadImage(@"cs_artor_new_course_detail_time");
}


#pragma mark - properties

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.06];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 3.5;
    }
    return _containerView;
}

- (UIImageView*)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _backImageView.layer.masksToBounds = YES;
        _backImageView.layer.cornerRadius = 5.0f;
        _backImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _backImageView;
}

- (UIImageView*)timeImageView{
    if (!_timeImageView) {
        _timeImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _timeImageView;
}

- (UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _timeLabel.textColor = LoadColor(@"#181F30");
        _timeLabel.font = [UIFont systemFontOfSize:9];
    }
    return _timeLabel;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.numberOfLines = 2;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _nameLabel;
}

- (UIImageView*)eyeImageView{
    if (!_eyeImageView) {
        _eyeImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _eyeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _eyeImageView;
}

- (UILabel*)eyeLabel{
    if (!_eyeLabel) {
        _eyeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _eyeLabel.textColor = [UIColor whiteColor];
        _eyeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _eyeLabel;
}

- (UILabel*)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _dateLabel;
}

@end
