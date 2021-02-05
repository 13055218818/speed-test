//
//  CSHomeRecommandCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeSquareCell.h"
#import <Masonry.h>

@interface CSHomeSquareCell ()


@end

@implementation CSHomeSquareCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews];
        [self setupConstraint];
    }
    return self;
}

- (void)setupViews{
    [super setupViews];
    self.studyLabel.hidden = YES;
}

- (void)setupConstraint{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.containerView);
        make.height.mas_equalTo(self.thumbnailImageView.mas_width).multipliedBy(3.0/4.0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.thumbnailImageView);
        make.top.mas_equalTo(self.thumbnailImageView.mas_bottom).offset(12);
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(6);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.authorLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.authorLabel.mas_centerX).offset(-6);
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
}

@end
