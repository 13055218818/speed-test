//
//  CSVideoKeyBoardView.m
//  ColorStar
//
//  Created by gavin on 2020/11/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorPlayKeyBoardView.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import <Masonry/Masonry.h>

@interface CSTutorPlayKeyBoardView ()

@property (nonatomic, strong)UIView  * containerView;

@property (nonatomic, strong)UIView       * inputView;

@property (nonatomic, strong)UILabel      * inputLabel;

@property (nonatomic, strong)UIButton     * commonBtn;

@property (nonatomic, strong)UILabel      * commonLabel;


@end

@implementation CSTutorPlayKeyBoardView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.avtorImageView];
    [self.containerView addSubview:self.inputView];
    [self.containerView addSubview:self.inputLabel];
    [self.containerView addSubview:self.commonBtn];
    [self.commonBtn addSubview:self.commonLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
    }];
    
    [self.avtorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.containerView);
        make.left.mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avtorImageView.mas_right).offset(9);
        make.centerY.mas_equalTo(self.avtorImageView);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-50);
    }];
    
    [self.inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.inputView);
        make.left.mas_equalTo(self.inputView).offset(10);
    }];
    
    [self.commonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.inputView);
        make.right.mas_equalTo(-14);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    
}

- (void)commonClick{
    
    if (self.keyboardBlock) {
        self.keyboardBlock(CSTutorPlayKeyBoardBlockTypeScroll);
    }
    
}

#pragma mark Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.backgroundColor = LoadColor(@"#142A3C");
    }
    return _containerView;
}

- (UIImageView*)avtorImageView{
    if (!_avtorImageView) {
        _avtorImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _avtorImageView.layer.masksToBounds = YES;
        _avtorImageView.layer.cornerRadius = 18.0f;
        _avtorImageView.backgroundColor = LoadColor(@"#E7E8EA");
        _avtorImageView.image = LoadImage(@"CSNewMyDefultImage");
    }
    return _avtorImageView;
}

- (UIView*)inputView{
    if (!_inputView) {
        _inputView = [[UIView alloc]initWithFrame:CGRectZero];
        _inputView.backgroundColor = LoadColor(@"#2C4A62");
        _inputView.layer.masksToBounds = YES;
        _inputView.layer.cornerRadius = 2.0f;
    }
    return _inputView;
}

- (UILabel*)inputLabel{
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _inputLabel.textColor = LoadColor(@"#9B9B9B");
        _inputLabel.font = kFont(12.0f);
        _inputLabel.text = csnation(@"说点什么吧…");
        CS_Weakify(self, weakSelf);
        [_inputLabel setTapActionWithBlock:^{
                    if (weakSelf.keyboardBlock) {
                        weakSelf.keyboardBlock(CSTutorPlayKeyBoardBlockTypeComment);
                    }
                }];
    }
    return _inputLabel;
}

- (UIButton*)commonBtn{
    if (!_commonBtn) {
        _commonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commonBtn setImage:LoadImage(@"cs_tutor_video_play_common_icon") forState:UIControlStateNormal];
        [_commonBtn addTarget:self action:@selector(commonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commonBtn;
}

- (UILabel*)commonLabel{
    if (!_commonLabel) {
        _commonLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _commonLabel;
}

@end
