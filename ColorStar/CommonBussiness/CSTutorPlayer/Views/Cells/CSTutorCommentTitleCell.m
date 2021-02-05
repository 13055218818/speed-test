//
//  CSTutorCommentTitleCell.m
//  ColorStar
//
//  Created by gavin on 2020/12/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorCommentTitleCell.h"

@interface CSTutorCommentTitleCell ()

@property (nonatomic, strong)UILabel * titleLabel;


@end

@implementation CSTutorCommentTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = LoadColor(@"#213D53");
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        self.contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = csnation(@"最新评论");
    [self.contentView addSubview:self.titleLabel];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(12);
    }];
}

@end
