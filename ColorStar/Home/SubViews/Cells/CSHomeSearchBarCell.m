//
//  CSHomeSearchBarCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/4.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeSearchBarCell.h"
#import <Masonry.h>

@interface CSHomeSearchBarCell ()

@property (nonatomic, strong)UIView      * searchBar;

@property (nonatomic, strong)UILabel     * titleLabel;

@property (nonatomic, strong)UIImageView * iconImageView;

@end

@implementation CSHomeSearchBarCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self.contentView addSubview:self.searchBar];
    [self.searchBar addSubview:self.titleLabel];
    [self.searchBar addSubview:self.iconImageView];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(14);
        make.right.mas_equalTo(self.contentView).offset(-14);
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.searchBar);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.searchBar);
        make.right.mas_equalTo(self.titleLabel.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
}


#pragma mark - Properties

- (UIView*)searchBar{
    if (!_searchBar) {
        _searchBar = [[UIView alloc]initWithFrame:CGRectZero];
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.cornerRadius = 15.0f;
        _searchBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.12];
    }
    return _searchBar;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel.text = NSLocalizedString(@"探索你的演绎之路", nil);
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _iconImageView.image = [UIImage imageNamed:@"cs_home_search"];
    }
    return _iconImageView;
}

@end
