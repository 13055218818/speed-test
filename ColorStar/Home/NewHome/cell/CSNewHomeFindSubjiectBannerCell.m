//
//  CSNewHomeFindSubjiectBannerCell.m
//  ColorStar
//
//  Created by apple on 2020/11/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeFindSubjiectBannerCell.h"

@implementation CSNewHomeFindSubjiectBannerCell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self makeUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
        ViewRadius(self.contentView, 6);
    }
    return self;
}

- (void)makeUI{

    
    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.clipsToBounds = YES;
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.topImageView];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_offset(@(88*heightScale));
    }];
    
   self.nameLabel= [[UILabel alloc] init];
//    nameLabel.text = model.title;
    self.nameLabel.numberOfLines = 1;
    self.nameLabel.text = NSLocalizedString(@"Mike McLaughlin",nil);
    self.nameLabel.font = kFont(10);
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(5);
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(6*heightScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
    }];
    

    

    
   self.colorView= [[UIView alloc] init];
    self.colorView.backgroundColor = [UIColor colorWithHexString:@"#FFC549"];
    [self.contentView addSubview:self.colorView];
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(2*heightScale);
        make.width.mas_offset(@(13));
        make.height.mas_offset(@(2));
    }];
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.numberOfLines = 1;
    self.detailLabel.text = NSLocalizedString(@"wwwwaaaaaddddaa",nil);
    self.detailLabel.font = kFont(12);
    self.detailLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.top.mas_equalTo(self.colorView.mas_bottom).offset(2*heightScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-30*widthScale);
    }];
    
    self.rightTimeLabel = [[UILabel alloc] init];
    self.rightTimeLabel.numberOfLines = 1;
//        rightTimeLabel.te
    //rightTimeLabel.text = NSLocalizedString(@"10月-12日",nil);
    self.rightTimeLabel.font = kFont(7);
    self.rightTimeLabel.textColor = [UIColor colorWithHexString:@"#B3B3B3"];
    self.rightTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.rightTimeLabel];
    [self.rightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-4);
        make.centerY.mas_equalTo(self.detailLabel.mas_centerY);
    }];
}

- (void)setModel:(CSNewHomeRecommendModel *)model{
    _model = model;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    self.nameLabel.text = model.title;
    self.rightTimeLabel.text = model.add_time;
    self.detailLabel.text = model.label.firstObject;
}
@end
