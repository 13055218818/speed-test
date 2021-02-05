//
//  CSSearchHeaderView.m
//  ColorStar
//
//  Created by gavin on 2020/11/28.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSSearchResultTopView.h"

@interface CSSearchResultTopView ()

@property (nonatomic, strong)UIButton * specialBtn;

@property (nonatomic, strong)UIButton * courseBtn;

@end

@implementation CSSearchResultTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.specialBtn];
    [self addSubview:self.courseBtn];
    
}

- (void)layoutSubviews{
    
    [self.specialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [self.courseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.mas_equalTo(self.specialBtn);
        make.left.mas_equalTo(self.specialBtn.mas_right).offset(10);
    }];
    
}

- (void)specialClick{
    self.courseBtn.selected = NO;
    self.specialBtn.selected = YES;
    
    self.specialBtn.titleLabel.font = kFont(18);
    self.courseBtn.titleLabel.font = kFont(14);
    
    if (self.headerClick) {
        self.headerClick(CSSearchHeaderClickTypeSpecial);
    }
    
}

- (void)courseClick{
    self.courseBtn.selected = YES;
    self.specialBtn.selected = NO;
    
    self.courseBtn.titleLabel.font = kFont(18);
    self.specialBtn.titleLabel.font = kFont(14);
    if (self.headerClick) {
        self.headerClick(CSSearchHeaderClickTypeCourse);
    }
}

#pragma mark - Properties Method

- (UIButton*)specialBtn{
    if (!_specialBtn) {
        _specialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_specialBtn setTitle:csnation(@"专题") forState:UIControlStateNormal];
        [_specialBtn setTitleColor:LoadColor(@"#9B9B9B") forState:UIControlStateNormal];
        [_specialBtn setTitleColor:LoadColor(@"#D7B393") forState:UIControlStateSelected];
        _specialBtn.titleLabel.font = kFont(14.0f);
        [_specialBtn addTarget:self action:@selector(specialClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _specialBtn;
}

- (UIButton*)courseBtn{
    if (!_courseBtn) {
        _courseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_courseBtn setTitle:csnation(@"课程") forState:UIControlStateNormal];
        [_courseBtn setTitleColor:LoadColor(@"#9B9B9B") forState:UIControlStateNormal];
        [_courseBtn setTitleColor:LoadColor(@"#D7B393") forState:UIControlStateSelected];
        _courseBtn.titleLabel.font = kFont(14.0f);
        [_courseBtn addTarget:self action:@selector(courseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _courseBtn;
}

@end
