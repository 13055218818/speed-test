//
//  CSHomeTopicHeaderReusableView.m
//  ColorStar
//
//  Created by gavin on 2020/8/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeTopicHeaderReusableView.h"
#import "CSCheckMoreView.h"
#import <Masonry.h>

@interface CSHomeTopicHeaderReusableView ()

@property (nonatomic, strong)UILabel  * titleLabel;

@property (nonatomic, strong)CSCheckMoreView   * checkMoreView;

@end

@implementation CSHomeTopicHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.checkMoreView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(14);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.checkMoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-14);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
}


- (void)checkMoreClick{
    if (self.checkMore) {
        self.checkMore(self.sectionModel);
    }
}

- (void)setSectionModel:(CSHomeTopicSectionModel *)sectionModel{
    _sectionModel = sectionModel;
    self.titleLabel.text = sectionModel.title;
}

#pragma mark - Properties Method

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _titleLabel;
}

- (CSCheckMoreView*)checkMoreView{
    if (!_checkMoreView) {
        _checkMoreView = [[CSCheckMoreView alloc]initWithFrame:CGRectZero];
        [_checkMoreView addTarget:self action:@selector(checkMoreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkMoreView;
}

@end
