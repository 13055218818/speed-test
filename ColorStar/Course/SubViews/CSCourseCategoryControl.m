//
//  CSCourseCategoryControl.m
//  ColorStar
//
//  Created by gavin on 2020/8/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseCategoryControl.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+CS.h"

@interface CSCourseCategoryControl ()

@property (nonatomic, strong)UILabel     * titleLabel;

@property (nonatomic, strong)UIImageView * imageView;

@end

@implementation CSCourseCategoryControl

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}


- (void)setupViews{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    
}

- (void)setTitleColor:(UIColor *)titleColor{
    self.titleLabel.textColor = titleColor;
}

- (void)setImageURL:(NSString *)imageURL{
    if (![NSString isNilOrEmpty:imageURL]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"cs_home_category"]];
    }
}

- (void)setFont:(UIFont *)font{
    self.titleLabel.font = font;
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

#pragma mark - Properties Method

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 15;
        _imageView.image = [UIImage imageNamed:@"cs_home_category"];
    }
    return _imageView;
}

@end
