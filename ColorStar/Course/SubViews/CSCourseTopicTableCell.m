//
//  CSCourseTopicTableCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/5.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSCourseTopicTableCell.h"
#import "UIColor+CS.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+CS.h"
#import <Masonry.h>
#import "CSColorStar.h"
#import <YYLabel.h>

@interface CSCourseTopicTableCell ()

@property (nonatomic, strong)UIView      * containerView;

@property (nonatomic, strong)UIImageView * thumbnailImageView;

@property (nonatomic, strong)UILabel     * titleLabel;

@property (nonatomic, strong)UILabel     * authorLabel;

@property (nonatomic, strong)UILabel     * priceLabel;

@property (nonatomic, strong)UIView      * separtLine;

@property (nonatomic, strong)UILabel     * courceLabel;

@property (nonatomic, strong)UILabel     * studyLabel;

@property (nonatomic, strong)UIView      * bottomLine;

@property (nonatomic, strong)YYLabel     * typeLabel1;

@property (nonatomic, strong)YYLabel     * typeLabel2;

@end

@implementation CSCourseTopicTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#121212"];
        [self setupViews];
        [self setupConstraint];
    }
    return self;
}

- (void)setupViews{
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.thumbnailImageView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.authorLabel];
    [self.containerView addSubview:self.priceLabel];
    [self.containerView addSubview:self.separtLine];
    [self.containerView addSubview:self.courceLabel];
    [self.containerView addSubview:self.studyLabel];
    [self.containerView addSubview:self.bottomLine];
    [self.containerView addSubview:self.typeLabel1];
    [self.containerView addSubview:self.typeLabel2];
    
}

- (void)setupConstraint{
    //90 + 30;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView).offset(15);
        make.top.mas_equalTo(self.containerView).offset(15);
        make.bottom.mas_equalTo(self.containerView).offset(-15);
        make.width.mas_equalTo(120);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thumbnailImageView.mas_right).offset(14);
        make.top.mas_equalTo(self.thumbnailImageView).offset(5);
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(7.5);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.authorLabel);
        make.bottom.mas_equalTo(self.thumbnailImageView).offset(-6);
    }];
    
    [self.separtLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.priceLabel);
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(6);
        make.width.mas_equalTo(1);
    }];
    
    [self.courceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.separtLine.mas_right).offset(6);
        make.centerY.mas_equalTo(self.separtLine);
    }];
    
    [self.studyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView).offset(-14);
        make.centerY.mas_equalTo(self.courceLabel);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.containerView);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.left.mas_equalTo(self.thumbnailImageView);
    }];
    
    [self.typeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
    }];
    
    [self.typeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.typeLabel1.mas_right).offset(10);
    }];
    
}

- (void)configModel:(CSCourseTopicModel*)model{
    self.baseModel = model;
    if (![NSString isNilOrEmpty:model.thumbnail]) {
        [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"cs_home_course"]];
    }
    
    self.titleLabel.text = model.title;
    self.authorLabel.text = model.subject;
    self.priceLabel.text = [model.money getPrice];
    self.courceLabel.text = [model.count getCourse];
    self.studyLabel.text = [model.browse_count getStudyTimes];
    
    if (self.baseModel.label.count > 0) {
        self.typeLabel1.text = self.baseModel.label[0];
        self.typeLabel1.hidden = NO;
    }else{
        self.typeLabel1.hidden = YES;
    }
    if (self.baseModel.label.count > 1) {
        self.typeLabel2.text = self.baseModel.label[1];
        self.typeLabel2.hidden = NO;
    }else{
        self.typeLabel2.hidden = YES;
    }
    
}


#pragma mark - Properties

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _containerView;
}

- (UIImageView*)thumbnailImageView{
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _thumbnailImageView.layer.masksToBounds = YES;
        _thumbnailImageView.layer.cornerRadius = 6;
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _thumbnailImageView;
}


- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _titleLabel;
}

- (UILabel*)authorLabel{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _authorLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        _authorLabel.font = [UIFont systemFontOfSize:10.0f];
    }
    return _authorLabel;
}

- (UILabel*)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _priceLabel.textColor = [UIColor colorWithHexString:@"#FCB086"];
        _priceLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _priceLabel;
}

- (UIView*)separtLine{
    if (!_separtLine) {
        _separtLine = [[UIView alloc]initWithFrame:CGRectZero];
        _separtLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.38];
    }
    return _separtLine;
}

- (UILabel*)courceLabel{
    if (!_courceLabel) {
        _courceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _courceLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.38];
        _courceLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _courceLabel;
}

- (UILabel*)studyLabel{
    if (!_studyLabel) {
        _studyLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _studyLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.38];
        _studyLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _studyLabel;
}

- (UIView*)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.12];
    }
    return _bottomLine;
}

- (YYLabel*)typeLabel1{
    if (!_typeLabel1) {
        _typeLabel1 = [[YYLabel alloc]initWithFrame:CGRectZero];
        _typeLabel1.textContainerInset = UIEdgeInsetsMake(4, 4, 4, 4);
        _typeLabel1.layer.masksToBounds = YES;
        _typeLabel1.layer.cornerRadius = 2.0f;
        _typeLabel1.layer.borderWidth = 1;
        _typeLabel1.layer.borderColor = [UIColor colorWithHexString:@"#FF584C" alpha:0.38].CGColor;
        _typeLabel1.textColor = [UIColor colorWithHexString:@"#FF584C" alpha:0.38];
        _typeLabel1.font = [UIFont systemFontOfSize:9.0f];
    }
    return _typeLabel1;
}

- (YYLabel*)typeLabel2{
    if (!_typeLabel2) {
        _typeLabel2 = [[YYLabel alloc]initWithFrame:CGRectZero];
        _typeLabel2.textContainerInset = UIEdgeInsetsMake(4, 4, 4, 4);
        _typeLabel2.layer.masksToBounds = YES;
        _typeLabel2.layer.cornerRadius = 2.0f;
        _typeLabel2.layer.borderWidth = 1;
        _typeLabel2.layer.borderColor = [UIColor colorWithHexString:@"#BC86FC" alpha:0.38].CGColor;
        _typeLabel2.textColor = [UIColor colorWithHexString:@"#BC86FC" alpha:0.38];
        _typeLabel2.font = [UIFont systemFontOfSize:9.0f];
    }
    return _typeLabel2;
}

@end
