//
//  CSLiveRankCell.m
//  ColorStar
//
//  Created by gavin on 2020/10/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLiveRankCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+CS.h"
#import "CSColorStar.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+CS.h"

@interface CSLiveRankCell ()

@property (nonatomic, strong)UIView      * containerView;

@property (nonatomic, strong)UIImageView * rankImageView;

@property (nonatomic, strong)UILabel     * rankLabel;

@property (nonatomic, strong)UIImageView * avatarImageView;

@property (nonatomic, strong)UILabel     * nickNameLabel;

@property (nonatomic, strong)UILabel     * phoneLabel;

@property (nonatomic, strong)UILabel     * dateLabel;

@end

@implementation CSLiveRankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#121212"];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.rankImageView];
    [self.containerView addSubview:self.rankLabel];
    [self.containerView addSubview:self.avatarImageView];
    [self.containerView addSubview:self.nickNameLabel];
    [self.containerView addSubview:self.phoneLabel];
    [self.containerView addSubview:self.dateLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(15);
    }];
    
    [self.rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.containerView).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.rankImageView);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rankImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.rankImageView);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(10);
        make.bottom.mas_equalTo(self.containerView.mas_centerY);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickNameLabel);
        make.top.mas_equalTo(self.nickNameLabel.mas_bottom).offset(4);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneLabel);
        make.right.mas_equalTo(self.containerView).offset(-10);
    }];
    
}

- (void)setDetailModel:(CSLiveRewardDetailModel *)detailModel{
    _detailModel = detailModel;
    
    if (detailModel.rank < 4) {
        self.rankLabel.hidden = YES;
        self.rankImageView.hidden = NO;
        
        if (detailModel.rank == 1) {
            self.rankImageView.image = LoadImage(@"cs_live_rank_one");
        }else if (detailModel.rank == 2){
            self.rankImageView.image = LoadImage(@"cs_live_rank_two");
        }else if (detailModel.rank == 3){
            self.rankImageView.image = LoadImage(@"cs_live_rank_three");
        }
    }else{
        self.rankLabel.hidden = NO;
        self.rankImageView.hidden = YES;
        self.rankLabel.text = [NSString stringWithFormat:@"%ld",(long)detailModel.rank];
    }
    
    if (![NSString isNilOrEmpty:detailModel.avatar]) {
        
    }
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.avatar] placeholderImage:LoadImage(@"cs_avatar_empty_placeholder")];
    self.nickNameLabel.text = detailModel.nickname;
    
    
    
}

#pragma mark - Properties Method

- (UIView*)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];

    }
    return _containerView;
}

- (UIImageView*)rankImageView{
    if (!_rankImageView) {
        _rankImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _rankImageView;
}

- (UILabel*)rankLabel{
    if (!_rankLabel) {
        _rankLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _rankLabel.textColor = [UIColor colorWithHexString:@"#85624B"];
        _rankLabel.font = [UIFont systemFontOfSize:11.0f];
    }
    return _rankLabel;
}

- (UIImageView*)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _avatarImageView.image = LoadImage(@"cs_avatar_empty_placeholder");
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 22.5;
    }
    return _avatarImageView;
}

- (UILabel*)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _nickNameLabel;
}

- (UILabel*)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _phoneLabel.textColor = [UIColor colorWithHexString:@"#B3B3B3"];
        _phoneLabel.font = [UIFont systemFontOfSize:11.0f];
    }
    return _phoneLabel;
}

- (UILabel*)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _dateLabel;
}

@end
