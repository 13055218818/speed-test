//
//  CSVideoTutorBriefCell.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/13.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorVideoBriefCell.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import <Masonry/Masonry.h>
#import "CSTouchLabel.h"
#import "CSTutorVideoModel.h"
#import "UILabel+CS.h"
#import "CSFollowButton.h"

@interface CSTutorVideoBriefCell ()

@property (nonatomic, strong)UIView       * containerView;

@property (nonatomic, strong)UIImageView  * likeImageView;
@property (nonatomic, strong)UILabel      * likeLabel;

@property (nonatomic, strong)UIImageView  * shareImageView;
@property (nonatomic, strong)UILabel      * shareLabel;

@property (nonatomic, strong)UIImageView  * collectImageView;
@property (nonatomic, strong)UILabel      * collectLabel;

@property (nonatomic, strong)UIImageView  * avtorImageView;
@property (nonatomic, strong)UILabel      * nameLabel;
@property (nonatomic, strong)UILabel      * followLabel;
@property (nonatomic, strong)UILabel      * briefLabel;

@property (nonatomic, strong)CSFollowButton      * followBtn;
@property (nonatomic, strong)UIView       * bottomLine;

@property (nonatomic, strong)CSTutorVideoModel * model;


@end

@implementation CSTutorVideoBriefCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = LoadColor(@"#324C60");
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        self.contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        [self setupViews];
        [self updateUIConstraints];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.likeImageView];
    [self.containerView addSubview:self.likeLabel];
    [self.containerView addSubview:self.shareImageView];
    [self.containerView addSubview:self.shareLabel];
    [self.containerView addSubview:self.collectImageView];
    [self.containerView addSubview:self.collectLabel];
    [self.containerView addSubview:self.avtorImageView];
    [self.containerView addSubview:self.nameLabel];
    [self.containerView addSubview:self.followLabel];
    [self.containerView addSubview:self.briefLabel];
    [self.containerView addSubview:self.briefRightLabel];
    [self.containerView addSubview:self.followBtn];
    [self.containerView addSubview:self.bottomLine];
    
}

- (void)updateUIConstraints{
    
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView).offset(30);
        make.top.mas_equalTo(self.containerView).offset(9);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeImageView);
        make.left.mas_equalTo(self.likeImageView.mas_right).offset(5);
    }];
    
    [self.shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeLabel);
        make.right.mas_equalTo(self.containerView.mas_centerX).offset(-2);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeLabel);
        make.left.mas_equalTo(self.containerView.mas_centerX).offset(2);
    }];
    
    [self.collectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeLabel);
        make.right.mas_equalTo(self.collectLabel.mas_left).offset(-4);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    [self.collectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeLabel);
        make.right.mas_equalTo(self.containerView).offset(-30);
    }];
    
    [self.avtorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.top.mas_offset(56);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avtorImageView);
        make.left.mas_equalTo(self.avtorImageView.mas_right).offset(12);
    }];
    
    [self.followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avtorImageView);
        make.left.mas_equalTo(self.avtorImageView.mas_right).offset(12);
    }];
    
    [self.briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.followLabel);
        make.bottom.mas_offset(-13);
        make.top.mas_equalTo(self.followLabel.mas_bottom).offset(3);
        make.right.mas_equalTo(self.followBtn.mas_left).offset(-5);
    }];
    
    [self.briefRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.briefLabel.mas_right);
        make.bottom.mas_offset(-13);
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avtorImageView);
        make.right.mas_offset(-12);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.containerView);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
    
}

- (void)mockData{
    
    self.likeLabel.text = @"点赞";
    self.shareLabel.text = @"转发";
    self.collectLabel.text = @"收藏";
    
    self.nameLabel.text = @"";
    self.followLabel.text = @"";
    self.briefLabel.text = @"";
    
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSTutorVideoModel class]]) {
        return;
    }
    self.model = model;
    
    self.likeLabel.text = csnation(@"点赞");
    self.shareLabel.text = csnation(@"转发");
    self.collectLabel.text = csnation(@"收藏");
    
    if (![NSString isNilOrEmpty:self.model.specialInfo.image]) {
        [self.avtorImageView sd_setImageWithURL:[NSURL URLWithString:self.model.specialInfo.image] placeholderImage:LoadImage(@"")];
    }
    
    self.nameLabel.text = self.model.specialInfo.title;
    self.followLabel.text = [NSString stringWithFormat:@"%@%@",self.model.specialInfo.follow_count,csnation(@"关注")];
    self.briefLabel.text = self.model.specialInfo.abstract;
    
    self.followBtn.isFollow = self.model.specialInfo.is_follow;
    
    self.likeImageView.image = self.model.taskInfo.is_click ? LoadImage(@"cs_tutor_new_course_unlike") : LoadImage(@"cs_tutor_new_course_like");
    
    self.collectImageView.image = self.model.taskInfo.is_collect ? LoadImage(@"cs_tutor_new_course_uncollect") : LoadImage(@"cs_tutor_new_course_collect");
    
}

- (void)followClick{
    if (self.briefBlock) {
        self.briefBlock(CSTutorVideoBriefBlockTypeFollow);
    }
}

#pragma mark Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
//        _containerView.backgroundColor = LoadColor(@"#324C60");
    }
    return _containerView;
}

- (UIImageView*)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _likeImageView.image = LoadImage(@"cs_tutor_new_course_like");
        _likeImageView.userInteractionEnabled = YES;
        CS_Weakify(self, weakSelf);
        [_likeImageView setTapActionWithBlock:^{
            if (weakSelf.briefBlock) {
                weakSelf.briefBlock(CSTutorVideoBriefBlockTypeLike);
            }
        }];
    }
    return _likeImageView;
}

- (UILabel*)likeLabel{
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _likeLabel.textColor = [UIColor whiteColor];
        _likeLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _likeLabel;
}

- (UIImageView*)shareImageView{
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _shareImageView.image = LoadImage(@"cs_tutor_new_course_share");
        _shareImageView.userInteractionEnabled = YES;
        CS_Weakify(self, weakSelf);
        [_shareImageView setTapActionWithBlock:^{
            if (weakSelf.briefBlock) {
                weakSelf.briefBlock(CSTutorVideoBriefBlockTypeShare);
            }
        }];
    }
    return _shareImageView;
}

- (UILabel*)shareLabel{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _shareLabel.textColor = [UIColor whiteColor];
        _shareLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _shareLabel;
}

- (UIImageView*)collectImageView{
    if (!_collectImageView) {
        _collectImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _collectImageView.image = LoadImage(@"cs_tutor_new_course_collect");
        _collectImageView.userInteractionEnabled = YES;
        CS_Weakify(self, weakSelf);
        [_collectImageView setTapActionWithBlock:^{
            if (weakSelf.briefBlock) {
                weakSelf.briefBlock(CSTutorVideoBriefBlockTypeCollect);
            }
        }];
    }
    return _collectImageView;
}

- (UILabel*)collectLabel{
    if (!_collectLabel) {
        _collectLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _collectLabel.textColor = [UIColor whiteColor];
        _collectLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _collectLabel;
}

- (UIImageView*)avtorImageView{
    if (!_avtorImageView) {
        _avtorImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _avtorImageView.layer.masksToBounds = YES;
        _avtorImageView.layer.cornerRadius = 23.0f;
        _avtorImageView.backgroundColor = LoadColor(@"#E7E8EA");
        _avtorImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _avtorImageView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    }
    return _nameLabel;
}

- (UILabel*)followLabel{
    if (!_followLabel) {
        _followLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _followLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.8];
        _followLabel.font = [UIFont systemFontOfSize:8.0f];
    }
    return _followLabel;
}

- (UILabel*)briefLabel{
    if (!_briefLabel) {
        _briefLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _briefLabel.textColor = [UIColor whiteColor];
        _briefLabel.font = [UIFont systemFontOfSize:10.0f];
        _briefLabel.numberOfLines = 0;
    }
    return _briefLabel;
}

- (UILabel*)briefRightLabel{
    if (!_briefRightLabel) {
        _briefRightLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _briefRightLabel.textColor = [UIColor colorWithHexString:@"#D7B393"];
        _briefRightLabel.font = [UIFont systemFontOfSize:11.0f];
        _briefRightLabel.text = csnation(@"展开");
    }
    return _briefRightLabel;
}

- (CSFollowButton*)followBtn{
    if (!_followBtn) {
        _followBtn = [CSFollowButton creatButton];
        _followBtn.viewHeight = 22;
        _followBtn.fontSize = 12;
        _followBtn.sideMargin = 16;
        _followBtn.type = CSFollowButtonVideo;
        [_followBtn setup];
        [_followBtn addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followBtn;
}

- (UIView*)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = LoadColor(@"#4C6E88");
    }
    return _bottomLine;
}

@end
