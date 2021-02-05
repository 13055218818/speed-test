//
//  CSMineTopItemView.m
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMineTopItemView.h"
#import <Masonry.h>
#import "UIColor+CS.h"


@interface CSMineTopItemView ()

@property (nonatomic, strong)UIImageView  * iconImageView;

@property (nonatomic, strong)UILabel      * titleLabel;

@property (nonatomic, strong)UILabel      * subTitleLabel;

@end

@implementation CSMineTopItemView

- (instancetype)initWithConfigModel:(CSMineConfigModel*)model{
    if (self = [super init]) {
        _configModel = model;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    
    
    
    self.iconImageView.image = [UIImage imageNamed:self.configModel.image];
    self.titleLabel.text = self.configModel.name;
    self.subTitleLabel.text = self.configModel.subName;
    
}

- (void)reloadData{
    self.subTitleLabel.text = self.configModel.subName;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.iconImageView);
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(5);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.titleLabel);
    }];
}


#pragma mark - Properties Method

- (UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _iconImageView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.87];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel*)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _subTitleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.38];
        _subTitleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _subTitleLabel;
}

@end
