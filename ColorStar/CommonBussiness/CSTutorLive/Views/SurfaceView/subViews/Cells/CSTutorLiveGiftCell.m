//
//  CSTutorLiveGiftCell.m
//  ColorStar
//
//  Created by gavin on 2020/11/21.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTutorLiveGiftCell.h"
#import "CSAvtorImageView.h"
#import "CSTutorLiveGiftModel.h"

@interface CSTutorLiveGiftCell ()

@property (nonatomic, strong)UIView      * containerView;

@property (nonatomic, strong)CSAvtorImageView * avtorImageView;

@property (nonatomic, strong)UILabel     * nameLabel;

@property (nonatomic, strong)UILabel     * giftLabel;

@property (nonatomic, strong)UILabel     * numberLabel;

@property (nonatomic, strong)CSTutorLiveGiftModel  *model;

@end

@implementation CSTutorLiveGiftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.avtorImageView];
    [self.containerView addSubview:self.nameLabel];
    [self.containerView addSubview:self.giftLabel];
    
    [self.contentView addSubview:self.numberLabel];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(12);
        make.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(42*heightScale);
        make.width.mas_equalTo(160);
    }];
    
    [self.avtorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.containerView);
        make.width.mas_equalTo(42*heightScale);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avtorImageView).offset(6*heightScale);
        make.left.mas_equalTo(self.avtorImageView.mas_right).offset(6*heightScale);
    }];
    
    [self.giftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(-6*heightScale);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.containerView.mas_right).offset(20);
    }];
}

- (void)mockData{
    self.nameLabel.text = @"小蚂蚁～";
    self.giftLabel.text = @"送出一个魔法棒";
    self.numberLabel.text = @"x2";
}

- (void)configModel:(id)model{
    
    if (![model isKindOfClass:[CSTutorLiveGiftModel class]]) {
        return;
    }
    
    self.model = model;
    
    self.nameLabel.text = self.model.sender;
    self.giftLabel.text = [NSString stringWithFormat:@"送出%@",self.model.giftName];
    self.numberLabel.text = [NSString stringWithFormat:@"X%@",self.model.giftCount];
    
    
    [self.avtorImageView sd_setImage:self.model.avtorURL];
    
}

#pragma mark -  Prperties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 21 * heightScale;
        _containerView.backgroundColor = [UIColor colorWithHexString:@"#7C7F82" alpha:0.5];
    }
    return _containerView;
}

- (CSAvtorImageView*)avtorImageView{
    if (!_avtorImageView) {
        _avtorImageView = [[CSAvtorImageView alloc]initWithFrame:CGRectZero];
        _avtorImageView.innerWH = 42*heightScale;
    }
    return _avtorImageView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = kFont(12);
    }
    return _nameLabel;
}


- (UILabel*)giftLabel{
    if (!_giftLabel) {
        _giftLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _giftLabel.textColor = [UIColor whiteColor];
        _giftLabel.font = kFont(8);
    }
    return _giftLabel;
}

- (UILabel*)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.font = kFont(14);
        CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-15 * (CGFloat)M_PI/ 180), 1, 0, 0);
        _numberLabel.transform = matrix;
    }
    return _numberLabel;
}

@end
