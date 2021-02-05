//
//  CSHomeBaseTopiceCell.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeBaseTopiceCell.h"
#import <Masonry.h>
#import "UIColor+CS.h"
#import "NSString+CS.h"
#import <SDWebImage/UIImageView+WebCache.h>



@implementation CSHomeBaseTopiceCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
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
    [self.containerView addSubview:self.typeLabel1];
    [self.containerView addSubview:self.typeLabel2];
    
}

- (void)setupConstraint{
    
    
}

- (void)configurModel:(CSHomeTopicBaseModel*)model{
    self.baseModel = model;
    if (![NSString isNilOrEmpty:model.thumbnail]) {
        [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"cs_home_course"]];
    }
    
    self.titleLabel.text = model.title;
    self.authorLabel.text = model.author;
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
        _containerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    }
    return _containerView;
}

- (UIImageView*)thumbnailImageView{
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _thumbnailImageView.layer.masksToBounds = YES;
        _thumbnailImageView.layer.cornerRadius = 6;
        _thumbnailImageView.image = [UIImage imageNamed:@"cs_home_course"];
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
        _authorLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];;
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

- (YYLabel*)typeLabel1{
    if (!_typeLabel1) {
        _typeLabel1 = [[YYLabel alloc]initWithFrame:CGRectZero];
        _typeLabel1.textContainerInset = UIEdgeInsetsMake(4, 4, 4, 4);
        _typeLabel1.layer.masksToBounds = YES;
        _typeLabel1.layer.cornerRadius = 2.0f;
        _typeLabel1.layer.borderWidth = 1;
        _typeLabel1.layer.borderColor = [UIColor colorWithHexString:@"#FF584C" alpha:0.6].CGColor;
        _typeLabel1.textColor = [UIColor colorWithHexString:@"#FF584C" alpha:0.6];
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
        _typeLabel2.layer.borderColor = [UIColor colorWithHexString:@"#BC86FC" alpha:0.6].CGColor;
        _typeLabel2.textColor = [UIColor colorWithHexString:@"#BC86FC" alpha:0.6];
        _typeLabel2.font = [UIFont systemFontOfSize:9.0f];
    }
    return _typeLabel2;
}

@end
