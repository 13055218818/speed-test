
//
//  CSMemberInterestItemView.m
//  ColorStar
//
//  Created by 陶涛 on 2020/9/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMemberInterestItemView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+CS.h"
#import <Masonry.h>

@interface CSMemberInterestItemView ()

@property (nonatomic, strong)UIImageView  * iconImageView;

@property (nonatomic, strong)UILabel  * titleLabel;

@property (nonatomic, strong)UILabel  * detailLabel;


@end

@implementation CSMemberInterestItemView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 5;
    [self addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.font = [UIFont systemFontOfSize:10.0f];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.detailLabel];
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.centerX.mas_equalTo(self);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
    }];
}

- (void)setInterestModel:(CSMemberInterestModel *)interestModel{
    _interestModel = interestModel;
    
    if ([NSString isNilOrEmpty:_interestModel.pic]) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_interestModel.pic] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    self.titleLabel.text = _interestModel.name;
    self.detailLabel.text = _interestModel.explain;
    
}

@end
