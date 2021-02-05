//
//  CSNewArtorCourseDetaiHeaderlCell.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorCourseDetaiHeaderCell.h"

@interface CSTutorCourseDetaiHeaderCell ()

@property (nonatomic, strong)UIView   * iconView;

@property (nonatomic, strong)UILabel  * courseLabel;

@end

@implementation CSTutorCourseDetaiHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.courseLabel];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(3, 15));
    }];
    
    [self.courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
    }];
    
}



- (UIView*)iconView{
    if (!_iconView) {
        _iconView = [[UIView alloc]initWithFrame:CGRectZero];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)LoadColor(@"#A890FF").CGColor, (__bridge id)LoadColor(@"#EC0FE9").CGColor];
        gradientLayer.locations = @[@0.0,@1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        gradientLayer.frame = CGRectMake(0, 0, 3, 15);
        [_iconView.layer addSublayer:gradientLayer];
    }
    return _iconView;
}

- (UILabel*)courseLabel{
    if (!_courseLabel) {
        _courseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _courseLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _courseLabel.textColor = [UIColor whiteColor];
        _courseLabel.text = csnation(@"相关课程");
    }
    return _courseLabel;
}

@end
