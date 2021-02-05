//
//  CSTutorCourseCell.m
//  ColorStar
//
//  Created by gavin on 2020/11/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorCourseCell.h"
#import "CSTutorVideoModel.h"
#import "CSShareManager.h"
@interface CSTutorCourseCell ()

@property (nonatomic, strong)UIView * containerView;

@property (nonatomic, strong)UIImageView * briefImageView;

@property (nonatomic, strong)UIImageView * hotImageView;

@property (nonatomic, strong)UILabel * briefLabel;

@property (nonatomic, strong)YYLabel * payLabel;

@property (nonatomic, strong)UILabel * typeLabel;

@property (nonatomic, strong)UIButton * shareBtn;

@property (nonatomic, strong)CSTutorMasterCourse * course;

@end

@implementation CSTutorCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = LoadColor(@"#324C60");
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        self.contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.briefImageView];
    [self.containerView addSubview:self.hotImageView];
    [self.containerView addSubview:self.briefLabel];
    [self.containerView addSubview:self.payLabel];
    [self.containerView addSubview:self.typeLabel];
    [self.containerView addSubview:self.shareBtn];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.briefImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView).offset(12);
        make.top.mas_equalTo(self.containerView).offset(6);
        make.bottom.mas_equalTo(self.containerView).offset(-6);
        make.width.mas_equalTo(176);
    }];
    
    [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.briefImageView).offset(6);
        make.size.mas_equalTo(CGSizeMake(26, 13));
    }];
    
    [self.briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView).offset(22);
        make.left.mas_equalTo(self.briefImageView.mas_right).offset(15);
        make.right.mas_equalTo(self.containerView).offset(-20);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.containerView).offset(-13);
        make.left.mas_equalTo(self.briefImageView.mas_right).offset(10);
    }];
    
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeLabel);
        make.bottom.mas_equalTo(self.typeLabel.mas_top).offset(10);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.containerView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
}

- (void)mockData{
    self.briefImageView.backgroundColor = [UIColor greenColor];
    self.briefLabel.text = @"音乐制作第一课 简介与讲解";
    self.typeLabel.text = @"#演示";
}

- (void)configModel:(id)model{
    
    if (![model isKindOfClass:[CSTutorMasterCourse class]]) {
        return;
    }
    
    self.course = model;
    
    if (![NSString isNilOrEmpty:self.course.image]) {
        [self.briefImageView sd_setImageWithURL:[NSURL URLWithString:self.course.image] placeholderImage:LoadImage(@"")];
    }else{
        self.briefImageView.image = LoadImage(@"");
    }
    
    self.briefLabel.text = self.course.task_name;
    if (![NSString isNilOrEmpty:self.course.name]) {
        self.typeLabel.text = [@"#" stringByAppendingString:self.course.name];
    }
    
    self.payLabel.hidden = YES;
    
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
        _briefImageView.backgroundColor = LoadColor(@"#E7E8EA");
    }
    return _briefImageView;
}

- (UIImageView*)hotImageView{
    if (!_hotImageView) {
        _hotImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _hotImageView.image = LoadImage(@"cs_tutor_new_course_hot");
    }
    return _hotImageView;
}

- (UILabel*)briefLabel{
    if (!_briefLabel) {
        _briefLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _briefLabel.numberOfLines = 2;
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

- (YYLabel*)payLabel{
    if (!_payLabel) {
        _payLabel = [[YYLabel alloc]initWithFrame:CGRectZero];
        _payLabel.layer.masksToBounds = YES;
        _payLabel.layer.cornerRadius = 2.0f;
        _payLabel.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        _payLabel.layer.borderColor = LoadColor(@"#979797").CGColor;
        _payLabel.textContainerInset = UIEdgeInsetsMake(1, 5, 1, 5);
        _payLabel.textColor = LoadColor(@"#D7B393");
        _payLabel.font = LoadFont(9);
        _payLabel.text = csnation(@"付费观看");
    }
    return _payLabel;
}

- (UIButton*)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:LoadImage(@"cs_tutor_new_course_share") forState:UIControlStateNormal];
        [_shareBtn setTapActionWithBlock:^{
            [[CSShareManager shared] showShareView];
        }];
    }
    return _shareBtn;
}

@end
