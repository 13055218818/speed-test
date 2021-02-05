//
//  CSEmptyDataView.m
//  ColorStar
//
//  Created by gavin on 2020/8/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSEmptyDataView.h"
#import <Masonry.h>
#import "UIView+CS.h"

@interface CSEmptyDataView ()

@property (nonatomic, strong)UIImageView   * emptyImageView;

@property (nonatomic, strong)UILabel       * emptyTitleLabel;

@property (nonatomic, strong)UILabel       * emptySubTitleLabel;

@end

@implementation CSEmptyDataView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    
    
    [self addSubview:self.emptyImageView];
    [self addSubview:self.emptyTitleLabel];
    [self addSubview:self.emptySubTitleLabel];
    
   
    
}

- (void)layoutSubviews{
    
    CGFloat topMargin = 70.0*(self.height/657.0);
    CGFloat wh = 230*(self.width/375.0);
    
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
}

#pragma mark - Properties Method

- (UIImageView*)emptyImageView{
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _emptyImageView.image = [UIImage imageNamed:@"cs_empty_data"];
    }
    return _emptyImageView;
}

- (UILabel*)emptyTitleLabel{
    if (!_emptyTitleLabel) {
        _emptyTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _emptyTitleLabel.textColor = [UIColor whiteColor];
        _emptyTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _emptyTitleLabel.text = NSLocalizedString(@"暂无数据", nil);
    }
    return _emptyTitleLabel;
}

- (UILabel*)emptySubTitleLabel{
    if (!_emptySubTitleLabel) {
        _emptySubTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _emptySubTitleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.38];
        _emptySubTitleLabel.font = [UIFont systemFontOfSize:14.0];
        _emptySubTitleLabel.text = NSLocalizedString(@"暂无数据描述", nil);
    }
    return _emptySubTitleLabel;
}

@end
