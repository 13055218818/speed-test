//
//  CSVideoPlayeRechargeAlertView.m
//  ColorStar
//
//  Created by gavin on 2020/12/7.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSVideoPlayeRechargeAlertView.h"

@interface CSVideoPlayeRechargeAlertView ()

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)UILabel  * titleLabel;

@property (nonatomic, strong)UILabel  * priceLeft;

@property (nonatomic, strong)UILabel  * priceRight;

@property (nonatomic, strong)UIButton * payBtn;

@end


@implementation CSVideoPlayeRechargeAlertView

- (void)cs_loadView{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.priceLeft];
    [self.containerView addSubview:self.priceRight];
    [self.containerView addSubview:self.payBtn];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(310, 210));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(40);
    }];
    
    [self.priceLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView.mas_centerX);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(24);
    }];
    
    [self.priceRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLeft);
        make.left.mas_equalTo(self.priceLeft.mas_right);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.bottom.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(136, 36));
    }];
    
}

- (void)payClick{
    [self cs_doDismiss];
    if (self.alertBlock) {
        self.alertBlock();
    }
}

- (void)setPrice:(NSString *)price{
    self.priceRight.text = price;
}

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
        _titleLabel.font = kFont(19.0f);
        _titleLabel.textColor = LoadColor(@"#181F30");
        _titleLabel.text = csnation(@"本视频需要付费观看");
    }
    return _titleLabel;
}

- (UILabel*)priceLeft{
    if (!_priceLeft) {
        _priceLeft = [[UILabel alloc]initWithFrame:CGRectZero];
        _priceLeft.font = kFont(16.0f);
        _priceLeft.textColor = LoadColor(@"#181F30");
        _priceLeft.text = csnation(@"价格：");
    }
    return _priceLeft;
}

- (UILabel*)priceRight{
    if (!_priceRight) {
        _priceRight = [[UILabel alloc]initWithFrame:CGRectZero];
        _priceRight.font = kFont(16.0f);
        _priceRight.textColor = LoadColor(@"#DEA06B");
    }
    return _priceRight;
}

- (UIButton*)payBtn{
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)LoadColor(@"#ECC69C").CGColor, (__bridge id)LoadColor(@"#DDA06A").CGColor];
        gradientLayer.locations = @[@0.0,@1.0];
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        gradientLayer.frame = CGRectMake(0, 0, 136, 36);
        [_payBtn.layer addSublayer:gradientLayer];
        [_payBtn setTitle:csnation(@"立即支付") forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _payBtn.layer.masksToBounds = YES;
        _payBtn.layer.cornerRadius = 18;
    }
    return _payBtn;
}

@end
