//
//  CSCalendarMonthRecommandCell.m
//  LXCalendarDemo
//
//  Created by gavin on 2020/11/26.
//  Copyright © 2020 https://github.com/nick8brown. All rights reserved.
//

#import "CSCalendarMonthRecommandCell.h"
#import "UILabel+CS.h"
#import "CSCalendarNewsInfoModel.h"

@interface CSCalendarMonthRecommandCell ()

@property (nonatomic, strong)UIView       * containerView;

@property (nonatomic, strong)UIImageView  * backImageView;

@property (nonatomic, strong)UILabel      * titleLabel;

@property (nonatomic, strong)YYLabel      * typeLabel;

@property (nonatomic, strong)UILabel      * detailLabel;

@property (nonatomic, strong)UIButton     * markBtn;

@property (nonatomic, strong)CSCalendarNewsInfoModel * model;


@end

@implementation CSCalendarMonthRecommandCell

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
    [self.containerView addSubview:self.typeLabel];
    [self.containerView addSubview:self.markBtn];
    [self.containerView addSubview:self.detailLabel];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(188);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backImageView);
        make.top.mas_equalTo(self.backImageView.mas_bottom).offset(15);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
    }];
    
    [self.markBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.typeLabel);
        make.right.mas_equalTo(self.backImageView);
        make.width.height.mas_equalTo(26);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(-15);
    }];
    
}

- (void)mockData{
    
    [super layoutSubviews];
    
    self.backImageView.backgroundColor = [UIColor redColor];
    self.titleLabel.text = @"十一月二十号";
    self.typeLabel.text = @"吉他表演";
    self.detailLabel.text = @"关于这段表演的描述关于这段表演的描述关于这段表演的描述关于这段表演的描述关于这段表演的描述关于这段表演的描述关于这段表演的描述关于这段表演的描述关于这段表演的描述关于这段表演的描述～";
    
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[CSCalendarNewsInfoModel class]]) {
        return;
    }
    
    self.model = model;
    
    self.titleLabel.text = self.model.title;
    self.detailLabel.text = self.model.synopsis;
    
    if (![NSString isNilOrEmpty:self.model.image_input]) {
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:self.model.image_input]];
    }
    
    if (self.model.label.count > 0) {
        self.typeLabel.text = self.model.label.firstObject;
    }
    
}

- (void)markClick{
    
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
        _backImageView.layer.cornerRadius = 4;
    }
    return _backImageView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = kFont(14.0f);
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (YYLabel*)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[YYLabel alloc]initWithFrame:CGRectZero];
        _typeLabel.textColor = LoadColor(@"#00FFEB");
        _typeLabel.font = kFont(8.0f);
        _typeLabel.textContainerInset = UIEdgeInsetsMake(2, 8, 2, 8);
        _typeLabel.layer.masksToBounds = YES;
        _typeLabel.layer.cornerRadius = 2;
        _typeLabel.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        _typeLabel.layer.borderColor = LoadColor(@"#969696").CGColor;
    }
    return _typeLabel;
}

- (UILabel*)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _detailLabel.textColor = LoadColor(@"#C0C0C0");
        _detailLabel.font = kFont(10.0f);
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UIButton*)markBtn{
    if (!_markBtn) {
        _markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_markBtn setImage:LoadImage(@"cs_calendar_month_follow") forState:UIControlStateNormal];
        [_markBtn addTarget:self action:@selector(markClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _markBtn;
}

@end
