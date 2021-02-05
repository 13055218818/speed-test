//
//  CSNewHomeFindWeekNewCell.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewHomeFindWeekNewCell.h"
@interface CSNewHomeFindWeekNewCell ()
@property(nonatomic,strong) UIImageView  *bgImage;
@property(nonatomic,strong) UIImageView  *headImage;
@property(nonatomic,strong) UILabel  *nameLabel;
@property(nonatomic,strong) UILabel  *titleLabel;
@property(nonatomic,strong) UILabel  *typeLabel;
@property(nonatomic,strong) UIButton  *playButton;


@end
@implementation CSNewHomeFindWeekNewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.leftImage = [[UIImageView alloc] init];
    self.leftImage.image = [UIImage imageNamed:@"CSHomeRecommendEveryDayLeftImage.png"];
    [self.contentView addSubview:self.leftImage];
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12*widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(14*heightScale);
        make.width.mas_offset(@(4*widthScale));
        make.height.mas_offset(@(15*heightScale));
    }];
    
    self.lefTitleLabel = [[UILabel alloc] init];
    self.lefTitleLabel.text = NSLocalizedString(@"本周上新",nil);
    self.lefTitleLabel.font = kFont(14);
    self.lefTitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.lefTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.lefTitleLabel];
    [self.lefTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImage.mas_right).offset(6*widthScale);
        make.centerY.mas_equalTo(self.leftImage.mas_centerY);
    }];
    
    self.bgImage = [[UIImageView alloc] init];
    //self.bgImage.image = [UIImage imageNamed:@"CSHomeRecommendEveryDayLeftImage.png"];
    [self.contentView addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12*widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(50*heightScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12*widthScale);
        make.height.mas_offset(@(143*heightScale));
    }];
    
    UIView  *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#181F30" alpha:0.7];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.bgImage);
    }];
    
    
    self.headImage = [[UIImageView alloc] init];
    //self.headImage.image = [UIImage imageNamed:@"cs_home_banner.png"];
    [self.contentView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(24*widthScale);
        make.top.mas_equalTo(self.bgImage.mas_top).offset(12*heightScale);
        make.width.mas_offset(@(103*heightScale));
        make.height.mas_offset(@(119*heightScale));
    }];
    
    
    
    self.nameLabel = [[UILabel alloc] init];
    //self.nameLabel.text = NSLocalizedString(@"吴牧业",nil);
    self.nameLabel.font = kFont(12);
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(20*widthScale);
        make.top.mas_equalTo(self.headImage.mas_top).offset(heightScale *13);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    //self.titleLabel.text = NSLocalizedString(@"2020线上钢琴演奏",nil);
    self.titleLabel.font = kFont(10);
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(20*widthScale);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(heightScale *3);
        make.right.mas_equalTo(self.bgImage.mas_right).offset(-20*widthScale);
    }];
    
    UIImageView  *centImage = [[UIImageView alloc] init];
    centImage.image = [UIImage imageNamed:@"CSNewHomeFindWeekNewCenter.png"];
    [self.contentView addSubview:centImage];
    [centImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(16*heightScale);
        make.height.mas_offset(@(24*heightScale));
        make.width.mas_offset(@(4));
    }];
    
    
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.font = kFont(7);
    self.typeLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.bottom.mas_equalTo(self.headImage.mas_bottom);
        make.width.mas_offset(@(35));
        make.height.mas_offset(@(15));
    }];
    ViewRadius(self.typeLabel, 3);
    self.typeLabel.backgroundColor = [UIColor colorWithHexString:@"#EDEDED" alpha:0.3];
    
    
    self.playButton = [[UIButton alloc] init];
    
    [self.playButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.playButton.titleLabel.font = kFont(7);
    [self.playButton setImage:[UIImage imageNamed:@"CSNewHomeFindWeekNewCenterPlay.png"] forState:UIControlStateNormal];
//    ViewRadius(playButton, 9);
//    ViewBorder(playButton, [UIColor colorWithHexString:@"#D7B393"], 1);
    [self.contentView addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(55));
        make.height.mas_offset(@(18));
        make.bottom.mas_equalTo(self.typeLabel.mas_bottom);
        make.right.mas_equalTo(bgView.mas_right).offset(-12);
    }];
    self.bgImage.clipsToBounds = YES;
    self.bgImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headImage.clipsToBounds = YES;
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
}


- (void)setModel:(CSNewHomeFindWeekModel *)model
{
    _model = model;
    
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    self.nameLabel.text = model.title;
    self.titleLabel.text = model.task_name;
    self.typeLabel.text = model.name;
    CGFloat typeWidth =[[CSTotalTool sharedInstance] getButtonWidth:model.name WithFont:7 WithLefAndeRightMargin:10];
    [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(typeWidth));
    }];
    NSString *playStr = [NSString stringWithFormat:@"%@%@",model.play_count,NSLocalizedString(@"次播放",nil)];
    [self.playButton setTitle:playStr forState:UIControlStateNormal];
    CGFloat playWidth =[[CSTotalTool sharedInstance] getButtonWidth:playStr WithFont:7 WithLefAndeRightMargin:20];
    [self.playButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(playWidth));
    }];
}
- (void)setIsFirst:(BOOL)isFirst{
    _isFirst = isFirst;
    if (isFirst) {
        [self.bgImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(12*widthScale);
            make.top.mas_equalTo(self.contentView.mas_top).offset(50*heightScale);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-12*widthScale);
            make.height.mas_offset(@(143*heightScale));
        }];
    }else{
        [self.bgImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(12*widthScale);
            make.top.mas_equalTo(self.contentView.mas_top).offset(10*heightScale);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-12*widthScale);
            make.height.mas_offset(@(143*heightScale));
        }];
    }
}

@end
