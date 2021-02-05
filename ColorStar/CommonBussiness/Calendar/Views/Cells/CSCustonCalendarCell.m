//
//  CSCustonCalendarCell.m
//  LXCalendarDemo
//
//  Created by gavin on 2020/11/26.
//  Copyright © 2020 https://github.com/nick8brown. All rights reserved.
//

#import "CSCustonCalendarCell.h"

@interface CSCustonCalendarCell ()

@property (nonatomic, strong)UIView   * containerView;


@end

@implementation CSCustonCalendarCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.dataLabel];
    [self.contentView addSubview:self.redPoint];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(24);
    }];
    
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.containerView);
    }];
    
    [self.redPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dataLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.dataLabel);
        make.width.height.mas_equalTo(4);
    }];
}

- (void)setCurrentType:(CSCustonCalendarType)currentType{
    _currentType = currentType;
    
    if (_currentType == CSCustonCalendarTypeIgnore) {
        
        self.containerView.hidden = YES;
        self.dataLabel.hidden = YES;
        
    }else{
        self.containerView.hidden = NO;
        self.dataLabel.hidden = NO;
        self.containerView.backgroundColor = _currentType == CSCustonCalendarTypeNormal ? [UIColor clearColor] : LoadColor(@"#00FFEB");
        self.dataLabel.textColor = _currentType == CSCustonCalendarTypeNormal ? [UIColor whiteColor] : [UIColor blackColor];
    }
    
    
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 12.0f;
    }
    return _containerView;
}

- (UILabel*)dataLabel{
    if (!_dataLabel) {
        _dataLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _dataLabel.font = kFont(14.0f);
        _dataLabel.textColor = [UIColor whiteColor];
    }
    return _dataLabel;
}

- (UIView*)redPoint{
    
    if (!_redPoint) {
        _redPoint = [[UIView alloc]initWithFrame:CGRectZero];
        _redPoint.layer.masksToBounds = YES;
        _redPoint.layer.cornerRadius = 2;
        _redPoint.backgroundColor = LoadColor(@"#E90003");
    }
    return _redPoint;
}

@end
