//
//  CSNewArtorIntroCell.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorAvtorCell.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import <Masonry/Masonry.h>
#import "CSTutorDetailModel.h"
#import "CSFollowButton.h"

@interface CSTutorAvtorCell ()

@property (nonatomic, strong)UIView  * containerView;

@property (nonatomic, strong)UIImageView * portraitImageView;//头像

@property (nonatomic, strong)UILabel     * nameLabel;//姓名

@property (nonatomic, strong)UILabel     * titleLabel;//头衔

@property (nonatomic, strong)CSFollowButton    * followBtn;//关注按钮

@property (nonatomic, strong)UIView      * bottomView;//底部页面

@property (nonatomic, strong)UILabel     * courseNumLabel;//课程数量

@property (nonatomic, strong)UILabel     * courseTitleLabel;//课程

@property (nonatomic, strong)UILabel     * collectNumLabel;//关注者数量

@property (nonatomic, strong)UILabel     * collectTitleLabel;//关注者

@property (nonatomic, strong)UILabel     * playNumLabel;//播放数量

@property (nonatomic, strong)UILabel     * playTitleLabel;//播放

@property (nonatomic, strong)NSMutableArray * topItems;

@property (nonatomic, strong)NSMutableArray * bottomItems;

@property (nonatomic, strong)CSTutorDetailModel * detail;

@end

@implementation CSTutorAvtorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LoadColor(@"#181F30");
        [self setupView];
        [self updateUIConstraints];
    }
    return self;
}

- (void)setupView{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.portraitImageView];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)LoadColor(@"#181F30").CGColor];
    gradientLayer.locations = @[@0.0,@1.0];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    gradientLayer.frame = CGRectMake(0, ScreenW*(400.0/375.0) - 150, ScreenW, 150);
    [self.containerView.layer addSublayer:gradientLayer];
    
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.nameLabel];
    [self.containerView addSubview:self.followBtn];
    [self.containerView addSubview:self.bottomView];
    
    self.topItems = [NSMutableArray arrayWithCapacity:0];
    self.bottomItems = [NSMutableArray arrayWithCapacity:0];
    
    [self.bottomView addSubview:self.courseNumLabel];
    [self.bottomView addSubview:self.courseTitleLabel];
    [self.bottomView addSubview:self.collectNumLabel];
    [self.bottomView addSubview:self.collectTitleLabel];
    [self.bottomView addSubview:self.playNumLabel];
    [self.bottomView addSubview:self.playTitleLabel];
    
    [self.topItems addObject:self.courseNumLabel];
    [self.topItems addObject:self.collectNumLabel];
    [self.topItems addObject:self.playNumLabel];
    
    [self.bottomItems addObject:self.courseTitleLabel];
    [self.bottomItems addObject:self.collectTitleLabel];
    [self.bottomItems addObject:self.playTitleLabel];
    
   
    
}

- (void)updateUIConstraints{
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.containerView);
        make.height.mas_equalTo(ScreenW*(400.0/375.0));
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.mas_equalTo(self.portraitImageView);
        make.size.mas_equalTo(CGSizeMake(65, 25));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.followBtn.mas_top).mas_equalTo(-15);
        make.centerX.mas_equalTo(self.followBtn);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.nameLabel.mas_top).offset(-10);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.portraitImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.containerView).offset(15);
        make.right.mas_equalTo(self.containerView).offset(-15);
        make.height.mas_equalTo(62);
    }];
    
    [self.topItems mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.bottomItems mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [self.topItems mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView).offset(10);
    }];
    
    [self.bottomItems mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomView).offset(-10);
    }];
    
}


- (CGSize)collectionCellSize{
    CGFloat height = ScreenW*(400.0/375.0) + 65;
    return CGSizeMake(ScreenW, height);
}

- (void)mockData{
    self.portraitImageView.backgroundColor = [UIColor redColor];
    self.titleLabel.text = @"导演/制片人";
    self.nameLabel.text = @"BOBBY ROTH";
    self.courseNumLabel.text = @"36";
    self.courseTitleLabel.text = csnation(@"课程数量");
    self.collectNumLabel.text = @"6802";
    self.collectTitleLabel.text = csnation(@"关注者");
    self.playNumLabel.text = @"37";
    self.playTitleLabel.text = csnation(@"播放次数");
    
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSTutorDetailModel class]]) {
        return;
    }
    self.detail = (CSTutorDetailModel*)model;
    
    
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:self.detail.image] placeholderImage:LoadImage(@"")];
    
    self.titleLabel.text = [self.detail.label componentsJoinedByString:@"/"];
    self.nameLabel.text = self.detail.title;
    
    self.courseNumLabel.text = self.detail.task_count;
    self.collectNumLabel.text = self.detail.follow_count;
    self.playNumLabel.text = self.detail.play_count;
    
    self.followBtn.isFollow = self.detail.is_follow;
}

#pragma mark action

- (void)followClick{
    
    if (self.avtorBlock) {
        self.avtorBlock();
    }
}

#pragma mark - properties

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        
        
    }
    return _containerView;
}

- (UIImageView*)portraitImageView{
    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _portraitImageView.contentMode = UIViewContentModeScaleAspectFill;
        _portraitImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _portraitImageView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    return _nameLabel;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:30.0f];
    }
    return _titleLabel;
}

- (CSFollowButton*)followBtn{
    if (!_followBtn) {
        _followBtn = [CSFollowButton creatButton];
        _followBtn.viewHeight = 25;
        _followBtn.fontSize = 12;
        _followBtn.sideMargin = 20;
        _followBtn.type = CSFollowButtonNormal;
        [_followBtn setup];
        [_followBtn addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followBtn;
}

- (UIView*)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.06];
        _bottomView.layer.masksToBounds = YES;
        _bottomView.layer.cornerRadius = 3.5;
    }
    return _bottomView;
}

- (UILabel*)courseTitleLabel{
    if (!_courseTitleLabel) {
        _courseTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _courseTitleLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE" alpha:0.5];
        _courseTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        _courseTitleLabel.textAlignment = NSTextAlignmentCenter;
        _courseTitleLabel.text = csnation(@"课程数量");
    }
    return _courseTitleLabel;
}

- (UILabel*)courseNumLabel{
    if (!_courseNumLabel) {
        _courseNumLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _courseNumLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE"];
        _courseNumLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _courseNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _courseNumLabel;
}

- (UILabel*)collectTitleLabel{
    if (!_collectTitleLabel) {
        _collectTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _collectTitleLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE" alpha:0.5];
        _collectTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        _collectTitleLabel.textAlignment = NSTextAlignmentCenter;
        _collectTitleLabel.text = csnation(@"关注者");
    }
    return _collectTitleLabel;
}

- (UILabel*)collectNumLabel{
    if (!_collectNumLabel) {
        _collectNumLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _collectNumLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE"];
        _collectNumLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _collectNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _collectNumLabel;
}

- (UILabel*)playTitleLabel{
    if (!_playTitleLabel) {
        _playTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _playTitleLabel.text = csnation(@"播放次数");
        _playTitleLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE" alpha:0.5];
        _playTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        _playTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _playTitleLabel;
}

- (UILabel*)playNumLabel{
    if (!_playNumLabel) {
        _playNumLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _playNumLabel.textColor = [UIColor colorWithHexString:@"#FEFEFE"];
        _playNumLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _playNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _playNumLabel;
}

@end
