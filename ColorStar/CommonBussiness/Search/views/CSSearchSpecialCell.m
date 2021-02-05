//
//  CSSearchSpecialCell.m
//  ColorStar
//
//  Created by gavin on 2020/11/27.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSSearchSpecialCell.h"
#import "CSTouchLabel.h"
#import "UILabel+CS.h"
#import "CSSearchReultModel.h"
#import "CSFollowButton.h"

@interface CSSearchSpecialCell ()

@property (nonatomic, strong)UIView * containerView;

@property (nonatomic, strong)UIImageView * coverImageView;

@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, strong)UILabel * briefLabel;

@property (nonatomic, strong)UIImageView  * hotImage;

@property (nonatomic, strong)UILabel * hotLabel;

@property (nonatomic, strong)CSFollowButton * followBtn;

@property (nonatomic, strong)CSSearchReultModel * model;

@end

@implementation CSSearchSpecialCell

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
    [self.containerView addSubview:self.coverImageView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.briefLabel];
    [self.containerView addSubview:self.hotImage];
    [self.containerView addSubview:self.hotLabel];
    [self.containerView addSubview:self.followBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(self.containerView);
        make.width.height.mas_equalTo(100);
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView).offset(-12);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(14);
        make.centerY.mas_equalTo(self.followBtn);
        make.right.mas_equalTo(-80);
    }];
    
    [self.briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(4);
        make.right.mas_equalTo(self.containerView).offset(-12);
    }];
    
    [self.hotImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.containerView).offset(-20);
        make.left.mas_equalTo(self.briefLabel);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.hotImage);
        make.left.mas_equalTo(self.hotImage.mas_right).offset(10);
    }];
}

- (void)mockData{
    
    self.coverImageView.backgroundColor = [UIColor redColor];
    self.titleLabel.text = @"Mike McLaughlin";
    self.briefLabel.text = @"对歌手的介绍对歌手的介绍对歌手的介绍对歌手的介绍对歌手的介绍";
    self.hotLabel.text = @"123";
    
    int y =100 +  (arc4random() % 101);
    self.followBtn.selected = (y%2) == 1;
    
}

- (void)configModel:(id)model{
    
    if (![model isKindOfClass:[CSSearchReultModel class]]) {
        return;
    }
    
    self.model = model;
    
    if (![NSString isNilOrEmpty:self.model.image]) {
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    }
    self.titleLabel.text = self.model.title;
    self.briefLabel.text = self.model.abstract;
    
    self.hotLabel.text = [NSString stringWithFormat:@"%ld",self.model.browse_count];
    
    self.followBtn.isFollow = self.model.is_follow;
    
}

- (void)followClick{
    
    if (self.specialBlock) {
        self.specialBlock(self.followBtn.isFollow);
    }
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _containerView;
}

- (UIImageView*)coverImageView{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _coverImageView.layer.masksToBounds = YES;
        _coverImageView.layer.cornerRadius = 4.0f;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _coverImageView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = LoadColor(@"#9B9B9B");
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    }
    return _titleLabel;
}

- (UILabel*)briefLabel{
    if (!_briefLabel) {
        _briefLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _briefLabel.numberOfLines = 2;
        _briefLabel.textColor = [UIColor whiteColor];
        _briefLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    }
    return _briefLabel;
}

- (UIImageView*)hotImage{
    if (!_hotImage) {
        _hotImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        _hotImage.image = LoadImage(@"CS_home_recomendArtisStatu");
    }
    return _hotImage;
}

- (UILabel*)hotLabel{
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _hotLabel.numberOfLines = 0;
        _hotLabel.textColor = LoadColor(@"#FF5D5B");
        _hotLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    }
    return _hotLabel;
}

- (CSFollowButton*)followBtn{
    if (!_followBtn) {
        _followBtn = [CSFollowButton creatButton];
        _followBtn.viewHeight = 20;
        _followBtn.fontSize = 10;
        _followBtn.sideMargin = 14;
        _followBtn.type = CSFollowButtonSearch;
        [_followBtn setup];
        [_followBtn addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _followBtn;
}

@end
