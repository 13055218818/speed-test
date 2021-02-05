//
//  CSHomeSpecialCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeBigCell.h"
#import <Masonry.h>


@interface CSHomeBigCell ()

@end

@implementation CSHomeBigCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self setupConstraint];
    }
    return self;
}

- (void)setupViews{
    [super setupViews];
    self.thumbnailImageView.userInteractionEnabled = YES;
    self.thumbnailImageView.tag = 100;
    self.studyLabel.hidden = YES;
    [self.thumbnailImageView addSubview:self.playBtn];
}

- (void)configurModel:(CSHomeTopicBaseModel *)model{
    [super configurModel:model];
    self.playBtn.hidden = !model.showVideo;
}


- (void)setupConstraint{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.containerView).offset(14);
        make.right.mas_equalTo(self.containerView).offset(-14);
        make.height.mas_equalTo(self.thumbnailImageView.mas_width).multipliedBy(215.0/347.0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thumbnailImageView).offset(10);
        make.top.mas_equalTo(self.thumbnailImageView.mas_bottom).offset(10);
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(6);
    }];
    
    [self.courceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.thumbnailImageView.mas_right).offset(-6);
        make.bottom.mas_equalTo(self.authorLabel);
    }];
    
    [self.separtLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.courceLabel);
        make.right.mas_equalTo(self.courceLabel.mas_left).offset(-6);
        make.width.mas_equalTo(1);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.separtLine.mas_left).offset(-6);
        make.centerY.mas_equalTo(self.separtLine);
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
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.thumbnailImageView);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
}

- (void)playBtnClick:(UIButton *)sender {
    if (self.playBlock) {
        self.playBlock(sender);
    }
}

- (UIButton*)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"cs_video_play_icon"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

@end
