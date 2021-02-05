//
//  CSVideoUnopenAlertView.m
//  ColorStar
//
//  Created by gavin on 2020/12/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSVideoUnopenAlertView.h"

@interface CSVideoUnopenAlertView ()

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)UILabel  * titleLabel;

@property (nonatomic, strong)UILabel  * detailLabel;

@property (nonatomic, strong)UIButton * confirmBtn;

@end

@implementation CSVideoUnopenAlertView

- (void)cs_loadView{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.detailLabel];
    [self.containerView addSubview:self.confirmBtn];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(280, 160));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(26);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(14);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.detailLabel);
        make.bottom.mas_equalTo(-26);
        make.size.mas_equalTo(CGSizeMake(150, 32));
    }];
    
}

- (void)confirnClick{
    [self cs_doDismiss];
    if (self.alertBlock) {
        self.alertBlock();
    }
}

- (void)show{
    
    self.getMaskConfig.maskColor = [UIColor colorWithWhite:0.0 alpha:0.64];
    [super show];
}

#pragma mark - Ac

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 5.0f;
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _titleLabel.textColor = LoadColor(@"#D7B393");
        _titleLabel.text = csnation(@"本视频暂未开放");
    }
    return _titleLabel;
}

- (UILabel*)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _detailLabel.font = LoadFont(14.0f);
        _detailLabel.textColor = LoadColor(@"#B6B6B6");
        _detailLabel.text = csnation(@"请耐性等待，如若开放，会给您通知");
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UIButton*)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.cornerRadius = 16.0f;
        [_confirmBtn addTarget:self action:@selector(confirnClick) forControlEvents:UIControlEventTouchUpInside];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)LoadColor(@"#EDCAA1").CGColor, (__bridge id)LoadColor(@"#DD9E69").CGColor];
        gradientLayer.locations = @[@0.0,@1.0];
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        gradientLayer.frame = CGRectMake(0, 0, 150, 33);
        [_confirmBtn.layer addSublayer:gradientLayer];
        [_confirmBtn setTitle:csnation(@"确认") forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    }
    return _confirmBtn;
}

@end
