//
//  CSNewArtorCoursePreviewCell.m
//  ColorStar
//
//  Created by 陶涛 on 2020/11/19.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorCoursePreviewCell.h"
#import "CSColorStar.h"
#import <Masonry/Masonry.h>

@interface CSTutorCoursePreviewCell ()

@property (nonatomic, strong)UIView   * containerView;

@property (nonatomic, strong)UIView   * iconView;

@property (nonatomic, strong)UILabel  * courseLabel;

@property (nonatomic, strong)UIImageView * firstImageView;

@property (nonatomic, strong)UIImageView * secondImageView;

@property (nonatomic, strong)UIImageView * thirdImageView;

@property (nonatomic, strong)UIImageView * fourImageView;

@property (nonatomic, strong)UIImageView * fiveImageView;

@property (nonatomic, strong)UIButton    * packBtn;

@property (nonatomic, strong)UIView      * bottomLine;

@property (nonatomic, strong)NSArray     * banners;

@end

@implementation CSTutorCoursePreviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LoadColor(@"#181F30");
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    
    [self.containerView addSubview:self.iconView];
    [self.containerView addSubview:self.courseLabel];
    [self.containerView addSubview:self.firstImageView];
    [self.containerView addSubview:self.secondImageView];
    [self.containerView addSubview:self.thirdImageView];
    [self.containerView addSubview:self.fourImageView];
    [self.containerView addSubview:self.fiveImageView];
//    [self.containerView addSubview:self.packBtn];
    [self.containerView addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.containerView).offset(15);
        make.size.mas_equalTo(CGSizeMake(3, 15));
    }];
    
    [self.courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
    }];
    
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(widthScale*220, widthScale*280));
    }];
    
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.firstImageView);
        make.right.mas_equalTo(self.containerView).offset(-15);
        make.height.mas_equalTo(widthScale*160.0);
        make.left.mas_equalTo(self.firstImageView.mas_right).offset(10);
    }];
    
    [self.thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.secondImageView);
        make.top.mas_equalTo(self.secondImageView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.firstImageView);
    }];
    
    [self.fourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.firstImageView);
        make.top.mas_equalTo(self.firstImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(widthScale*115);
        make.height.mas_equalTo(widthScale*110);
    }];
    
    [self.fiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.fourImageView);
        make.left.mas_equalTo(self.fourImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.thirdImageView);
    }];
    
//    [self.packBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.fiveImageView);
//        make.top.mas_equalTo(self.fiveImageView.mas_bottom).offset(13);
//        make.size.mas_equalTo(CGSizeMake(13, 13));
//    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.containerView).offset(15);
        make.right.mas_equalTo(self.containerView).offset(-15);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
    }];
}

- (void)packClick{
    if (self.previewBlock) {
        self.previewBlock();
    }
}

- (void)mockData{
    
    self.courseLabel.text = @"课程预览";
    self.firstImageView.backgroundColor = [UIColor redColor];
    self.secondImageView.backgroundColor = [UIColor redColor];
    self.thirdImageView.backgroundColor = [UIColor redColor];
    self.fourImageView.backgroundColor = [UIColor redColor];
    self.fiveImageView.backgroundColor = [UIColor redColor];
    
}

- (void)configModel:(id)model{
    if (![model isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.banners = (NSArray*)model;
    if (self.banners.count < 5) {
        return;
    }
    
    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:self.banners[0]] placeholderImage:LoadImage(@"")];
    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:self.banners[1]] placeholderImage:LoadImage(@"")];
    [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:self.banners[2]] placeholderImage:LoadImage(@"")];
    [self.fourImageView sd_setImageWithURL:[NSURL URLWithString:self.banners[3]] placeholderImage:LoadImage(@"")];
    [self.fiveImageView sd_setImageWithURL:[NSURL URLWithString:self.banners[4]] placeholderImage:LoadImage(@"")];
    
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
    }
    return _containerView;
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
        _courseLabel.text = csnation(@"课程预览");
    }
    return _courseLabel;
}

- (UIButton*)packBtn{
    if (!_packBtn) {
        _packBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_packBtn setImage:LoadImage(@"cs_artor_new_expand") forState:UIControlStateNormal];
        [_packBtn addTarget:self action:@selector(packClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _packBtn;
}

- (UIImageView*)firstImageView{
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _firstImageView.layer.masksToBounds = YES;
        _firstImageView.layer.cornerRadius = 5.0f;
        _firstImageView.contentMode = UIViewContentModeScaleAspectFill;
        _firstImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _firstImageView;
}

- (UIImageView*)secondImageView{
    if (!_secondImageView) {
        _secondImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _secondImageView.layer.masksToBounds = YES;
        _secondImageView.layer.cornerRadius = 5.0f;
        _secondImageView.contentMode = UIViewContentModeScaleAspectFill;
        _secondImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _secondImageView;
}

- (UIImageView*)thirdImageView{
    if (!_thirdImageView) {
        _thirdImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _thirdImageView.layer.masksToBounds = YES;
        _thirdImageView.layer.cornerRadius = 5.0f;
        _thirdImageView.contentMode = UIViewContentModeScaleAspectFill;
        _thirdImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _thirdImageView;
}

- (UIImageView*)fourImageView{
    if (!_fourImageView) {
        _fourImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _fourImageView.layer.masksToBounds = YES;
        _fourImageView.layer.cornerRadius = 5.0f;
        _fourImageView.contentMode = UIViewContentModeScaleAspectFill;
        _fourImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _fourImageView;
}

- (UIImageView*)fiveImageView{
    if (!_fiveImageView) {
        _fiveImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _fiveImageView.layer.masksToBounds = YES;
        _fiveImageView.layer.cornerRadius = 5.0f;
        _fiveImageView.contentMode = UIViewContentModeScaleAspectFill;
        _fiveImageView.backgroundColor = LoadColor(@"#E7E8EA");

    }
    return _fiveImageView;
}

- (UIView*)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.06];
    }
    return _bottomLine;
}

@end
