//
//  CSNewCourseCategoryViewCell.m
//  ColorStar
//
//  Created by apple on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewCourseCategoryViewCell.h"

@implementation CSNewCourseCategoryViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;;
}

- (void)makeUI{
    self.categoryLabel = [[UILabel alloc] init];
    self.categoryLabel .backgroundColor = [UIColor whiteColor];
    self.categoryLabel .textAlignment = NSTextAlignmentCenter;
    self.categoryLabel .font = kFont(12);
    [self.contentView addSubview:self.categoryLabel];
    [self.categoryLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self);
        
    }];
}

- (void)setModel:(CSNewCourseCategoryModel *)model
{
    _model = model;
    self.categoryLabel .text = model.name;
    if (model.isSelect) {
        self.categoryLabel .font = [UIFont boldSystemFontOfSize:12.0];
        self.categoryLabel .textColor = [UIColor colorWithHexString:@"#000000"];
    }else{
        self.categoryLabel .font = kFont(12);
        self.categoryLabel .textColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
    }
}
@end
