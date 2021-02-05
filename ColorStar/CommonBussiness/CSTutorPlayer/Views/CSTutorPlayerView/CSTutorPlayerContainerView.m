//
//  CSTutorPlayerView.m
//  ColorStar
//
//  Created by gavin on 2020/12/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorPlayerContainerView.h"

@interface CSTutorPlayerContainerView ()

@property (nonatomic, strong)UIButton  * backBtn;

@property (nonatomic, strong)UILabel   * titleLabel;

@property (nonatomic, strong)UIButton  * chargeBtn;

@end

@implementation CSTutorPlayerContainerView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = LoadColor(@"#181F30");
    }
    return self;
}


- (void)showBackView{
    
    [self addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(6);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
}

- (void)showRechargeView{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.chargeBtn];
    [self addSubview:self.vipBtn];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(30);
    }];

    [self.chargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.titleLabel.mas_centerX).offset(-12);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(140, 30));
    }];

    [self.vipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_centerX).offset(12);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(140, 30));
    }];
}

- (void)setMoneyDes:(NSString *)moneyDes{
    [self.chargeBtn setTitle:moneyDes forState:UIControlStateNormal];
    
}

- (void)setTitleDes:(NSString *)titleDes{
    _titleDes = titleDes;
    self.titleLabel.text = titleDes;
}

#pragma mark - Action Method

- (void)backClick{
    
    if (self.containerBlock) {
        self.containerBlock(CSTutorPlayerContainerBlockTypeBack);
    }
    
}

- (void)chargeClick{
    
    if (self.containerBlock) {
        self.containerBlock(CSTutorPlayerContainerBlockTypeRecharge);
    }
    
}

- (void)vipClick{
    if (self.containerBlock) {
        self.containerBlock(CSTutorPlayerContainerBlockTypeVip);
    }
}

#pragma mark - Properties Method

- (UIButton*)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:LoadImage(@"cs_tutor_player_icon_back") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = kFont(16.0f);
        _titleLabel.text = csnation(@"本视频需要付费，VIP可免费观看");
    }
    return _titleLabel;
}

- (UIButton*)chargeBtn{
    if (!_chargeBtn) {
        _chargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chargeBtn.layer.masksToBounds = YES;
        _chargeBtn.layer.cornerRadius = 16.5;
        _chargeBtn.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        _chargeBtn.layer.borderColor = LoadColor(@"#D7B393").CGColor;
        [_chargeBtn setTitleColor:LoadColor(@"#D7B393") forState:UIControlStateNormal];
        _chargeBtn.titleLabel.font = kFont(12.0f);
        [_chargeBtn addTarget:self action:@selector(chargeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chargeBtn;
}

- (UIButton*)vipBtn{
    if (!_vipBtn) {
        _vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_vipBtn setTitle:csnation(@"开通VIP免费") forState:UIControlStateNormal];
        [_vipBtn setTitleColor:LoadColor(@"#202020") forState:UIControlStateNormal];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)LoadColor(@"#ECC69C").CGColor, (__bridge id)LoadColor(@"#DDA06A").CGColor];
        gradientLayer.locations = @[@0.0,@1.0];
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        gradientLayer.frame = CGRectMake(0, 0, 140, 30);
        [_vipBtn.layer addSublayer:gradientLayer];
        _vipBtn.layer.masksToBounds = YES;
        _vipBtn.layer.cornerRadius = 15;
        _vipBtn.titleLabel.font = kFont(12.0f);
        [_vipBtn addTarget:self action:@selector(vipClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vipBtn;
}


@end
