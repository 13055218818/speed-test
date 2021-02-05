//
//  CSTopCalendarView.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/24.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTopCalendarView.h"
#import "CSCustomCalendarView.h"
@interface CSTopCalendarView ()

@property (nonatomic, strong)UIView     * topView;

@property (nonatomic, strong)UIView     * iconView;

@property (nonatomic, strong)UILabel    * titleLabel;

@property (nonatomic, strong)UIButton   * expandBtn;

@property (nonatomic, strong)CSCustomCalendarView     * calendarView;

@property (nonatomic, strong)UIView     * bottomLine;

@property (nonatomic, assign)BOOL         expand;

@end

@implementation CSTopCalendarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LoadColor(@"#181F30");
        self.layer.masksToBounds = YES;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.topView];
    [self.topView addSubview:self.iconView];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.expandBtn];
    self.topView.frame = CGRectMake(0, 0, self.width, 48);

    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.topView);
        make.left.mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(4, 15));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).offset(12);
    }];
    
    
    [self.expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.topView);
        make.right.mas_equalTo(-12);
        make.width.height.mas_equalTo(26);
    }];
    
    self.calendarView = [[CSCustomCalendarView alloc]initWithFrame:CGRectMake(0, self.topView.bottom, self.width, self.height - self.topView.bottom)];
    CS_Weakify(self, weakSelf);
    self.calendarView.calendarBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
        if (weakSelf.calendarBlock) {
            weakSelf.calendarBlock(year, month, day);
        }
    };
    [self addSubview:self.calendarView];
    
    self.bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
    self.bottomLine.backgroundColor = LoadColor(@"#858585");
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-23);
    }];
    
    
    
}

- (void)expandClick{
    
    self.expand = !self.expand;
}

- (void)setExpand:(BOOL)expand{
    _expand = expand;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.height = self.expand ? 48 : 312;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)reloadRedInfo:(NSArray*)redInfo{
    [self.calendarView reloadRedInfo:redInfo];
}

#pragma mark - Properties Method

- (UIView*)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _topView;
}

- (UIView*)iconView{
    if (!_iconView) {
        _iconView = [[UIView alloc]initWithFrame:CGRectZero];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)LoadColor(@"#A692FF").CGColor, (__bridge id)LoadColor(@"#FF00F6").CGColor];
        gradientLayer.locations = @[@0.0,@1.0];
        gradientLayer.startPoint = CGPointMake(0.5, 0);
        gradientLayer.endPoint = CGPointMake(0.5, 1.0);
        gradientLayer.frame = CGRectMake(0, 0, 4, 15);
        [_iconView.layer addSublayer:gradientLayer];
    }
    return _iconView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = csnation(@"日程安排");
    }
    return _titleLabel;
}

- (UIButton*)expandBtn{
    if (!_expandBtn) {
        _expandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_expandBtn setImage:LoadImage(@"cs_calendar_expand") forState:UIControlStateNormal];
        [_expandBtn addTarget:self action:@selector(expandClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandBtn;
}

- (UIView*)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _bottomLine;
}

@end
