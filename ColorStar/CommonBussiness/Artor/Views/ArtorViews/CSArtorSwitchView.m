//
//  CSArtorSwitchView.m
//  ColorStar
//
//  Created by gavin on 2020/8/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSArtorSwitchView.h"
#import <Masonry.h>
#import "UIColor+CS.h"
#import "CSColorStar.h"
#import "UIView+CS.h"

@interface CSArtorSwitchView ()

@property (nonatomic, strong)UIView     * containerView;

@property (nonatomic, strong)UIButton   * detailBtn;

@property (nonatomic, strong)UIButton   * courseListBtn;

@property (nonatomic, strong)UIView     * bottonLine;

@property (nonatomic, strong)UIButton   * selecteBtn;

@end

@implementation CSArtorSwitchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.containerView  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.containerView];
    
    
    
    
    self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.detailBtn setTitleColor:[UIColor colorWithHexString:@"#3953F9"] forState:UIControlStateNormal];
    [self.detailBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.detailBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.containerView addSubview:self.detailBtn];
    
    self.courseListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.courseListBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.courseListBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.courseListBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.containerView addSubview:self.courseListBtn];
    
    self.selecteBtn = self.detailBtn;
    
    self.bottonLine = [[UIView alloc]initWithFrame:CGRectZero];
    self.bottonLine.backgroundColor = [UIColor colorWithHexString:@"#3953F9"];
    [self.containerView addSubview:self.bottonLine];
    
}

- (void)setIsLive:(BOOL)isLive{
    _isLive = isLive;
    
    NSString * text = @"艺人详情";
    NSString * text2 = @"专题目录";
    if (self.isLive) {
        text = @"直播详情";
        text2 = @"直播目录";
    }
    
    [self.detailBtn setTitle:text forState:UIControlStateNormal];
    [self.courseListBtn setTitle:text2 forState:UIControlStateNormal];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.containerView.frame = self.bounds;
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.containerView);
        make.centerX.mas_equalTo(self.containerView.mas_left).offset(ScreenW/4);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    [self.courseListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(self.containerView);
         make.centerX.mas_equalTo(self.containerView.mas_right).offset(-ScreenW/4);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(80);
    }];
    
    [self.bottonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.detailBtn);
        make.bottom.mas_equalTo(self.containerView);
        make.height.mas_equalTo(3);
        make.width.mas_equalTo(40);
    }];
    
    CGFloat cententX = self.selecteBtn == self.detailBtn ? ScreenW/4 : ScreenW*3/4;

    self.bottonLine.bounds = CGRectMake(0, 0, 40, 3);
    self.bottonLine.center = CGPointMake(cententX, self.height - 1.5);
}

- (void)btnClick:(UIButton*)sender{
    
    if (sender == self.selecteBtn) {
        return;
    }
    
    [self.selecteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor colorWithHexString:@"#3953F9"] forState:UIControlStateNormal];
    self.selecteBtn = sender;
    
   
    
    
    NSInteger index = self.selecteBtn == self.detailBtn ? 0 : 1;
    if (self.switchBlock) {
        self.switchBlock(index);
    }
    
}

@end
