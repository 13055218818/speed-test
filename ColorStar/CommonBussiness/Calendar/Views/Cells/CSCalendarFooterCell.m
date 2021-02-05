//
//  CSCalendarFooterCell.m
//  ColorStar
//
//  Created by gavin on 2020/12/2.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCalendarFooterCell.h"

@interface CSCalendarFooterCell ()

@property (nonatomic, strong)UILabel      * titleLabel;

@end

@implementation CSCalendarFooterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    self.titleLabel.textColor = LoadColor(@"#B4B6B7");
    self.titleLabel.text = csnation(@"已经到底了哟～");
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
    }];
    
    
    
}

@end
