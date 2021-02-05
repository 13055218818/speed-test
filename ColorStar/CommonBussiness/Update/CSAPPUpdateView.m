//
//  CSAPPUpdateView.m
//  ColorStar
//
//  Created by gavin on 2020/10/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSAPPUpdateView.h"
#import "UIView+CS.h"
#import "CSColorStar.h"
#import <Masonry/Masonry.h>
#import "UIColor+CS.h"

@interface CSAPPUpdateView ()

@property (nonatomic, strong)UIView   * bgView;

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)UIImageView   * topImageView;

@property (nonatomic, strong)UILabel  * titleLabel;

@property (nonatomic, strong)UILabel  * updateLabel;

@property (nonatomic, strong)UIButton * updateBtn;

@property (nonatomic, strong)UIButton * cancelBtn;

@property (nonatomic, strong)NSString * updateNote;

@end

@implementation CSAPPUpdateView

- (instancetype)initWithFrame:(CGRect)frame updateNote:(NSString*)updateNote{
    if (self = [super initWithFrame:frame]) {
        _updateNote = updateNote;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.bgView = [[UIView alloc]initWithFrame:self.bounds];
    self.bgView.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    [self addSubview:self.bgView];
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectZero];
    self.containerView.center = CGPointMake(self.width/2, self.height/2);
    self.containerView.bounds = CGRectMake(0, 0, 300, 310);
    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.cornerRadius = 10;
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.containerView];
    
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.topImageView.image = LoadImage(@"cs_update_bg_icon");
    [self.bgView addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView);
        make.centerY.mas_equalTo(self.containerView.mas_top);
        make.size.mas_equalTo(CGSizeMake(186, 135));
    }];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#CBA769"];
    self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    self.titleLabel.text = csnation(@"发现新版本!");
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.topImageView);
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(20);
    }];
    
    self.updateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.updateLabel.numberOfLines = 0;
    self.updateLabel.text = self.updateNote;
    self.updateLabel.font = [UIFont systemFontOfSize:15.0f];
    self.updateLabel.textAlignment = NSTextAlignmentCenter;
    self.updateLabel.textColor = [UIColor blackColor];
    [self.containerView addSubview:self.updateLabel];
    [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(150);
        make.height.mas_lessThanOrEqualTo(150);
    }];
    
    self.updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.updateBtn setTitle:csnation(@"立即更新") forState:UIControlStateNormal];
    [self.updateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.updateBtn.backgroundColor = [UIColor colorWithHexString:@"#CBA769"];
    [self.updateBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.updateBtn.layer.masksToBounds = YES;
    self.updateBtn.layer.cornerRadius = 20;
    [self.containerView addSubview:self.updateBtn];
    
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.containerView).offset(-20);
        make.width.mas_equalTo(250);
    }];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setImage:LoadImage(@"cs_update_cancel") forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.cancelBtn];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.containerView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(30, 54));
    }];
    
}

- (void)setIsUpdate:(BOOL)isUpdate
{
    _isUpdate = isUpdate;
    self.cancelBtn.hidden = isUpdate;
}

- (void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)btnClick:(UIButton*)sender{
    
    [self dismiss];
    if ([[UIApplication sharedApplication] canOpenURL:self.downURL]) {
        [[UIApplication sharedApplication] openURL:self.downURL options:nil completionHandler:nil];;
    }
    
}

- (void)cancelClick{
    [self dismiss];
}

@end
