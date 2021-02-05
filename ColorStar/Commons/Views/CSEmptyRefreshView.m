//
//  CSEmptyRefreshView.m
//  ColorStar
//
//  Created by gavin on 2020/8/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSEmptyRefreshView.h"
#import <Masonry.h>
#import "UIView+CS.h"
#import "UIColor+CS.h"
#import "CSColorStar.h"

@interface CSEmptyRefreshView ()

@property (nonatomic, strong)UIImageView   * emptyImageView;

@property (nonatomic, strong)UILabel       * emptyTitleLabel;

@property (nonatomic, strong)UILabel       * emptySubTitleLabel;

@property (nonatomic, strong)UIButton      * refreshBtn;

@end

@implementation CSEmptyRefreshView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    CGFloat topMargin = 70.0*(self.height/657.0);
    CGFloat wh = 230*(self.width/375.0);
    CGFloat bottomMargin = 120.0*(self.height/657.0);
    
    [self addSubview:self.emptyImageView];
    [self addSubview:self.emptyTitleLabel];
    [self addSubview:self.emptySubTitleLabel];
    [self addSubview:self.refreshBtn];
    
    [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(topMargin);
        make.size.mas_equalTo(CGSizeMake(wh, wh));
    }];
    
    [self.emptyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.emptyImageView);
        make.top.mas_equalTo(self.emptyImageView.mas_bottom).offset(20);
    }];
    
    [self.emptySubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.emptyTitleLabel);
        make.top.mas_equalTo(self.emptyTitleLabel.mas_bottom).offset(15);
    }];
    
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.emptyImageView);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.emptySubTitleLabel.mas_bottom).offset(bottomMargin);
    }];
}

- (void)refreshClick{
    
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

#pragma mark - Properties Method

- (UIImageView*)emptyImageView{
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _emptyImageView.image = [UIImage imageNamed:@"cs_empty_refresh"];
    }
    return _emptyImageView;
}

- (UILabel*)emptyTitleLabel{
    if (!_emptyTitleLabel) {
        _emptyTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _emptyTitleLabel.textColor = [UIColor whiteColor];
        _emptyTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _emptyTitleLabel.text = NSLocalizedString(@"网络连接失败", nil);
    }
    return _emptyTitleLabel;
}

- (UILabel*)emptySubTitleLabel{
    if (!_emptySubTitleLabel) {
        _emptySubTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _emptySubTitleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.38];
        _emptySubTitleLabel.font = [UIFont systemFontOfSize:14.0];
        _emptySubTitleLabel.text = NSLocalizedString(@"请检查网络连接后重试", nil);
    }
    return _emptySubTitleLabel;
}

- (UIButton*)refreshBtn{
    if (!_refreshBtn) {
        _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refreshBtn setTitle:NSLocalizedString(@"重新加载", nil) forState:UIControlStateNormal];
        [_refreshBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _refreshBtn.layer.masksToBounds = YES;
        _refreshBtn.layer.cornerRadius = 20;
        _refreshBtn.backgroundColor = [UIColor colorWithHexString:@"#F8FBFE" alpha:0.12];
        [_refreshBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}

@end
