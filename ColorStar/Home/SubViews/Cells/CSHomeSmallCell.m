//
//  CSHomeRecentInfoCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeSmallCell.h"
#import <Masonry.h>

@interface CSHomeSmallCell ()



@end

@implementation CSHomeSmallCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self setupConstraint];
    }
    return self;
}


- (void)setupConstraint{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(14);
        make.top.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).offset(-14);
        make.height.mas_equalTo(106);
    }];
    
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView).mas_equalTo(8);
        make.top.mas_equalTo(self.containerView).offset(8);
        make.bottom.mas_equalTo(self.containerView).offset(-8);
        make.width.mas_equalTo(120);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thumbnailImageView.mas_right).offset(12);
        make.top.mas_equalTo(self.containerView).offset(24);
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(6);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.authorLabel);
        make.bottom.mas_equalTo(self.containerView).offset(-20);
    }];
    
    [self.separtLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.priceLabel);
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(6);
        make.width.mas_equalTo(1);
    }];
    
    [self.courceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.separtLine.mas_right).offset(6);
        make.centerY.mas_equalTo(self.priceLabel);
    }];
    
    [self.studyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.courceLabel);
        make.right.mas_equalTo(self.containerView).offset(-10);
    }];
    
    [self.typeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
    }];
    
    [self.typeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.typeLabel1.mas_right).offset(10);
    }];
}


- (void)configurModel:(CSHomeTopicBaseModel *)model{
    [super configurModel:model];
}

@end
