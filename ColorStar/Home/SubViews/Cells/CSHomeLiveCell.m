//
//  CSHomeLiveCell.m
//  ColorStar
//
//  Created by gavin on 2020/9/30.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeLiveCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+CS.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+CS.h"

@interface CSHomeLiveCell ()

@property (nonatomic, strong)CSHomeLiveModel * liveModel;

@property (nonatomic, strong)UIView       * container;//容器

@property (nonatomic, strong)UIImageView  * thumbnailImageView;//缩略图

@property (nonatomic, strong)UILabel      * titleLabel;//标题

@property (nonatomic, strong)UILabel      * priceLabel;//价格

@property (nonatomic, strong)UILabel      * browseLabel;//观看人数

@end

@implementation CSHomeLiveCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#111111"];
        [self setupViews];
    }
    return self;
}


- (void)setupViews{
    
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.thumbnailImageView];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.browseLabel];
    [self.container addSubview:self.priceLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(10);
        make.right.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
    
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.container).offset(10);
        make.centerY.mas_equalTo(self.container);
        make.height.mas_equalTo(95);
        make.width.mas_equalTo(190);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thumbnailImageView).offset(200);
        make.top.mas_equalTo(self.thumbnailImageView).offset(10);
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel).offset(10);
        make.bottom.mas_equalTo(self.thumbnailImageView).offset(-10);
    }];

    [self.browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLabel);
        make.right.mas_equalTo(self.container).offset(-10);
    }];
    
}

- (void)configModel:(CSHomeLiveModel*)liveModel{
    
    self.liveModel = liveModel;
    
    if (![NSString isNilOrEmpty:self.liveModel.image]) {
        [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:self.liveModel.image] placeholderImage:[UIImage imageNamed:@"cs_home_course"]];
    }
    self.titleLabel.text = self.liveModel.title;
    self.priceLabel.text = @"免费";
    self.browseLabel.text = [NSString stringWithFormat:@"%@人已学习",self.liveModel.browse_count];
    
}


#pragma mark - Properties Method

- (UIView*)container{
    if (!_container) {
        _container = [[UIView alloc]initWithFrame:CGRectZero];
        _container.backgroundColor = [UIColor colorWithHexString:@"#111111"];
    }
    return _container;
}

- (UIImageView*)thumbnailImageView{
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _thumbnailImageView.image = [UIImage imageNamed:@"cs_home_course"];
    }
    return _thumbnailImageView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return _titleLabel;
}

- (UILabel*)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _priceLabel.font = [UIFont systemFontOfSize:12.0f];
        _priceLabel.textColor = [UIColor colorWithHexString:@"#EDAB21"];
    }
    return _priceLabel;
}

- (UILabel*)browseLabel{
    if (!_browseLabel) {
        _browseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _browseLabel.font = [UIFont systemFontOfSize:11.0f];
        _browseLabel.textColor = [UIColor colorWithHexString:@"#B2B2B2"];
    }
    return _browseLabel;
}

@end
