//
//  CSLiveGiftCell.m
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveGiftCell.h"
#import "UIColor+CS.h"
#import "CSColorStar.h"
#import <Masonry/Masonry.h>
#import "NSString+CS.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CSLiveGiftCell ()

@property (nonatomic, strong)UIImageView  * giftImageView;

@property (nonatomic, strong)UILabel      * giftNameLabel;

@property (nonatomic, strong)UILabel      * giftPriceLabel;

@property (nonatomic, strong)UIImageView  * giftPriceUnitImageView;

@end

@implementation CSLiveGiftCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.giftImageView];
    [self.containerView addSubview:self.giftNameLabel];
    [self.containerView addSubview:self.giftPriceLabel];
    [self.containerView addSubview:self.giftPriceUnitImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(self.containerView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.giftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.giftImageView.mas_bottom).offset(1);
        make.centerX.mas_equalTo(self.containerView);
    }];
    
    [self.giftPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView.mas_centerX).offset(-1);
        make.top.mas_equalTo(self.giftNameLabel.mas_bottom).offset(10);
    }];
    
    [self.giftPriceUnitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.giftPriceLabel);
        make.left.mas_equalTo(self.containerView.mas_centerX).offset(2);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
}

- (void)setGiftModel:(CSLiveGiftModel *)giftModel{
    _giftModel = giftModel;
    
    if (![NSString isNilOrEmpty:_giftModel.live_gift_show_img]) {
        [self.giftImageView sd_setImageWithURL:[NSURL URLWithString:_giftModel.live_gift_show_img] placeholderImage:LoadImage(@"cs_live_gitft_icon_placeholder")];
    }
    self.giftNameLabel.text = _giftModel.live_gift_name;
    self.giftPriceLabel.text = _giftModel.live_gift_price;
    
}


#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 5;
    }
    return _containerView;
}

- (UIImageView*)giftImageView{
    if (!_giftImageView) {
        _giftImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _giftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _giftImageView.image = LoadImage(@"cs_live_gitft_icon_placeholder");
    }
    return _giftImageView;
}

- (UILabel*)giftNameLabel{
    if (!_giftNameLabel) {
        _giftNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _giftNameLabel.font = [UIFont systemFontOfSize:12.0f];
        _giftNameLabel.textColor = [UIColor blackColor];
    }
    return _giftNameLabel;
}

- (UILabel*)giftPriceLabel{
    if (!_giftPriceLabel) {
        _giftPriceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _giftPriceLabel.textAlignment = NSTextAlignmentRight;
        _giftPriceLabel.font = [UIFont systemFontOfSize:11.0f];
        _giftPriceLabel.textColor = [UIColor colorWithHexString:@"#989898"];
    }
    return _giftPriceLabel;
}

- (UIImageView*)giftPriceUnitImageView{
    if (!_giftPriceUnitImageView) {
        _giftPriceUnitImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _giftPriceUnitImageView.contentMode = UIViewContentModeScaleAspectFit;
        _giftPriceUnitImageView.image = LoadImage(@"cs_live_gift_gold");
    }
    return _giftPriceUnitImageView;
}

@end
