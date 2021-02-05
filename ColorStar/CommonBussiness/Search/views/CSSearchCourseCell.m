//
//  CSSearchCourseCell.m
//  ColorStar
//
//  Created by gavin on 2020/11/27.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSSearchCourseCell.h"
#import "CSSearchReultModel.h"

@interface CSSearchCourseCell ()

@property (nonatomic, strong)UIView * containerView;

@property (nonatomic, strong)UIImageView * briefImageView;

@property (nonatomic, strong)UILabel * briefLabel;

@property (nonatomic, strong)UILabel * typeLabel;

@property (nonatomic, strong)UIButton * shareBtn;

@property (nonatomic, strong)CSSearchReultModel  * model;


@end

@implementation CSSearchCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.briefImageView];
    [self.containerView addSubview:self.briefLabel];
    [self.containerView addSubview:self.typeLabel];
    [self.containerView addSubview:self.shareBtn];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.briefImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.containerView).offset(6);
        make.bottom.mas_equalTo(self.containerView).offset(-6);
        make.width.mas_equalTo(176);
    }];
    
    [self.briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView).offset(22);
        make.left.mas_equalTo(self.briefImageView.mas_right).offset(15);
        make.bottom.lessThanOrEqualTo(self.typeLabel.mas_top).offset(-5);
        make.right.mas_equalTo(self.containerView).offset(-20);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.containerView).offset(-13);
        make.left.mas_equalTo(self.briefImageView.mas_right).offset(10);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.containerView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
}

- (void)mockData{
    self.briefImageView.backgroundColor = [UIColor greenColor];
    self.briefLabel.text = @"课程介绍课程介绍课程介绍课程介绍课程介绍";
    self.typeLabel.text = @"#演示";
}

- (void)configModel:(id)model{
    
    if (![model isKindOfClass:[CSSearchReultModel class]]) {
        return;
    }
    
    self.model = model;
    
    if (![NSString isNilOrEmpty:self.model.image]) {
        [self.briefImageView sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    }
    self.briefLabel.text = self.model.title;

    if (![NSString isNilOrEmpty:self.model.subject_name]) {
        self.typeLabel.text = [@"#" stringByAppendingString:self.model.subject_name];
    }
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _containerView;
}

- (UIImageView*)briefImageView{
    if (!_briefImageView) {
        _briefImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _briefImageView.layer.masksToBounds = YES;
        _briefImageView.layer.cornerRadius = 4.0f;
        _briefImageView.contentMode = UIViewContentModeScaleAspectFill;
        _briefImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _briefImageView;
}

- (UILabel*)briefLabel{
    if (!_briefLabel) {
        _briefLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _briefLabel.numberOfLines = 0;
        _briefLabel.textColor = [UIColor whiteColor];
        _briefLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    }
    return _briefLabel;
}

- (UILabel*)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _typeLabel.textColor = [UIColor whiteColor];
        _typeLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    }
    return _typeLabel;
}

- (UIButton*)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:LoadImage(@"cs_tutor_new_course_share") forState:UIControlStateNormal];
    }
    return _shareBtn;
}

@end
