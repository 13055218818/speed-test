//
//  CSCalendarTitleCell.m
//  ColorStar
//
//  Created by gavin on 2020/12/2.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCalendarTitleCell.h"

@implementation CSCalendarTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.iconImageView.image = LoadImage(@"cs_calendar_day_head_special");
    [self.contentView addSubview:self.iconImageView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(12);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(8);
        make.size.mas_equalTo(CGSizeMake(18, 11));
    }];
    
}

@end
