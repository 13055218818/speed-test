//
//  CSArtorDetailNavView.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorDetailNavView.h"
#import "CSColorStar.h"
#import <Masonry/Masonry.h>

@interface CSTutorDetailNavView ()

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)UIButton * backBtn;

@property (nonatomic, strong)UIButton * shareBtn;

@end

@implementation CSTutorDetailNavView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self updateUIConstraints];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.backBtn];
    [self.containerView addSubview:self.shareBtn];
    [self.containerView addSubview:self.followBtn];
    [self.containerView addSubview:self.titleLabel];
    
}

- (void)updateUIConstraints{

    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.containerView);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.containerView);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(33, 33));
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backBtn);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.shareBtn);
        make.right.mas_equalTo(self.shareBtn.mas_left).offset(-15);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(50);
    }];
    
}

- (void)backClick{
    
    if (self.navBlock) {
        self.navBlock(CSTutorDetailNavBlockTypeBack);
    }
    
}

- (void)shareClick{
    
    if (self.navBlock) {
        self.navBlock(CSTutorDetailNavBlockTypeShare);
    }
    
}

- (void)followClick{
    
    if (self.navBlock) {
        self.navBlock(CSTutorDetailNavBlockTypeFollow);
    }
}

#pragma mark - Properties

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UIButton*)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:LoadImage(@"cs_artor_new_back") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton*)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:LoadImage(@"cs_artor_new_share") forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}



- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (CSFollowButton*)followBtn{
    if (!_followBtn) {
        _followBtn = [CSFollowButton creatButton];
        _followBtn.viewHeight = 22;
        _followBtn.fontSize = 11;
        _followBtn.sideMargin = 14;
        _followBtn.type = CSFollowButtonNormal;
        [_followBtn setup];
        [_followBtn addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _followBtn;
}

@end
