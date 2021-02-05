//
//  CSHomeCategoryCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeCategoryCell.h"
#import <Masonry.h>
#import "NSString+CS.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CSHomeCategoryCell ()

@property (nonatomic, strong)UIView       * containerView;

@property (nonatomic, strong)UIImageView  * iconImageView;

@property (nonatomic, strong)UILabel      * categoryName;

@end

@implementation CSHomeCategoryCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.iconImageView];
    [self.containerView addSubview:self.categoryName];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView);
        make.centerX.mas_equalTo(self.containerView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(6);
        make.left.right.mas_equalTo(self.containerView);
    }];
}

- (void)configModel:(CSHomeCategoryModel*)model{
    
    if (![NSString isNilOrEmpty:model.icon]) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"cs_home_category"]];
    }
    self.categoryName.text = model.title;
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _containerView;
}

- (UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _iconImageView.image = [UIImage imageNamed:@"cs_home_category"];
    }
    return _iconImageView;
}

- (UILabel*)categoryName{
    if (!_categoryName) {
        _categoryName = [[UILabel alloc]initWithFrame:CGRectZero];
        _categoryName.textColor = [UIColor whiteColor];
        _categoryName.font = [UIFont systemFontOfSize:12.0f];
        _categoryName.textAlignment = NSTextAlignmentCenter;
    }
    return _categoryName;
}

@end
