//
//  CSCalendarMonthRecommandCell.m
//  LXCalendarDemo
//
//  Created by gavin on 2020/11/26.
//  Copyright © 2020 https://github.com/nick8brown. All rights reserved.
//

#import "CSCalendarDayRecommandCell.h"
#import "CSAvtorImageView.h"
#import "CSCalendarNewsInfoModel.h"
@interface CSCalendarDayRecommandCell ()

@property (nonatomic, strong)UIView       * containerView;

@property (nonatomic, strong)UIImageView  * backImageView;

@property (nonatomic, strong)UILabel      * titleLabel;

@property (nonatomic, strong)UILabel      * dateLabel;

@property (nonatomic, strong)UIView       * tipsContainerView;

@property (nonatomic, strong)CSAvtorImageView  * avtorImageView;

@property (nonatomic, strong)UILabel      * tipsLabel;

@property (nonatomic, strong)UILabel      * detailLabel;

@property (nonatomic, strong)UIImageView  * tipsArrowImageView;

@property (nonatomic, strong)CSCalendarNewsInfoModel * model;

@end

@implementation CSCalendarDayRecommandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.backImageView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.dateLabel];
    [self.containerView addSubview:self.tipsContainerView];
    [self.tipsContainerView addSubview:self.avtorImageView];
    [self.tipsContainerView addSubview:self.tipsLabel];
    [self.tipsContainerView addSubview:self.detailLabel];
    [self.tipsContainerView addSubview:self.tipsArrowImageView];
    self.tipsContainerView.hidden = YES;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.backImageView).offset(18);
        make.right.mas_equalTo(self.backImageView).offset(-18);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(2);
    }];
    
    [self.tipsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.right.mas_equalTo(self.backImageView).offset(-18);
        make.height.mas_equalTo(66);
    }];
    
    [self.avtorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.tipsContainerView);
        make.width.height.mas_equalTo(45);
    }];
    
    [self.tipsArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avtorImageView);
        make.right.mas_equalTo(-10);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avtorImageView.mas_right).offset(12);
        make.bottom.mas_equalTo(self.tipsContainerView.mas_centerY);
        make.right.mas_equalTo(self.tipsArrowImageView.mas_left).offset(-10);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipsLabel.mas_bottom).offset(2);
        make.left.right.mas_equalTo(self.tipsLabel);
    }];
    
}

- (void)mockData{
    
    self.backImageView.backgroundColor = [UIColor greenColor];
    self.titleLabel.text = @"吴牧野线上钢琴演奏";
    self.dateLabel.text = @"今天下午3:00～5:00";
    self.tipsLabel.text = @"如果你也喜欢钢琴演奏";
    self.detailLabel.text = @"快点进来预约属于你的位置吧～";
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSCalendarNewsInfoModel class]]) {
        return;
    }
    
    self.model = model;
    
    self.titleLabel.text = self.model.title;
    self.dateLabel.text = self.model.synopsis;
    
    if (![NSString isNilOrEmpty:self.model.image_input]) {
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:self.model.image_input]];
    }
    
    if (![NSString isNilOrEmpty:self.model.author]) {
        [self.avtorImageView sd_setImage:self.model.author];
    }
    
    self.tipsLabel.text = self.model.share_title;
    self.detailLabel.text = self.model.share_synopsis;
    
}

#pragma mark - Properties

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        
    }
    return _containerView;
}

- (UIImageView*)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _backImageView.layer.masksToBounds = YES;
        _backImageView.layer.cornerRadius = 8.0f;
    }
    return _backImageView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = kFont(16.0f);
    }
    return _titleLabel;
}

- (UILabel*)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _dateLabel.font = kFont(10.0f);
        _dateLabel.textColor = [UIColor whiteColor];
    }
    return _dateLabel;
}

- (UIView*)tipsContainerView{
    if (!_tipsContainerView) {
        _tipsContainerView = [[UIView alloc]initWithFrame:CGRectZero];
        _tipsContainerView.layer.masksToBounds = YES;
        _tipsContainerView.layer.cornerRadius = 8;
        _tipsContainerView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    return _tipsContainerView;
}

- (CSAvtorImageView*)avtorImageView{
    if (!_avtorImageView) {
        _avtorImageView = [[CSAvtorImageView alloc]initWithFrame:CGRectZero];
    }
    return _avtorImageView;
}

- (UILabel*)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _tipsLabel.textColor = LoadColor(@"#181F30");
        _tipsLabel.font = kFont(16.0f);
    }
    return _tipsLabel;
}

- (UILabel*)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _detailLabel.textColor = LoadColor(@"#181F30");
        _detailLabel.font = kFont(10.0f);
    }
    return _detailLabel;
}

- (UIImageView*)tipsArrowImageView{
    if (!_tipsArrowImageView) {
        _tipsArrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _tipsArrowImageView.image = LoadImage(@"CSHomeRecommendEveryDayRight");
        _tipsArrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _tipsArrowImageView;
}


@end
