//
//  CSCheckMoreView.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCheckMoreView.h"
#import <Masonry.h>

@interface CSCheckMoreView ()

@property (nonatomic, strong)UILabel      * titleLabel;

@property (nonatomic, strong)UIImageView  * imageView;

@end

@implementation CSCheckMoreView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self.imageView.mas_left).offset(-5);
    }];
    
}


#pragma mark - Properties Method

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel.text = NSLocalizedString(@"查看更多", nil);
    }
    return _titleLabel;
}

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.image = [UIImage imageNamed:@"cs_home_arrow_right"];
    }
    return _imageView;
}

@end
