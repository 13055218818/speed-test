//
//  CSMineConfigCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/10.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMineConfigCell.h"
#import <Masonry.h>

@interface CSMineConfigCell ()

@property (nonatomic, strong)CSMineConfigModel * configModel;

@property (nonatomic, strong)UIImageView  * iconImageView;

@property (nonatomic, strong)UILabel      * titleLabel;

@property (nonatomic, strong)UIImageView  * arrowImageView;

@end

@implementation CSMineConfigCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor blackColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrowImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.mas_equalTo(self.contentView).offset(18);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.contentView).offset(-18);
    }];
    
}

- (void)configModel:(CSMineConfigModel*)model{
    self.configModel = model;
    self.iconImageView.image = [UIImage imageNamed:model.image];
    self.titleLabel.text = NSLocalizedString(model.name, nil);
}


#pragma mark - Properties Method

- (UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _iconImageView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _titleLabel;
}

- (UIImageView*)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _arrowImageView.image = [UIImage imageNamed:@"cs_home_checkmore"];
    }
    return _arrowImageView;
}

@end
