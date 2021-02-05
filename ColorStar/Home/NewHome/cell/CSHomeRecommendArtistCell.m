//
//  CSHomeRecommendArtistCell.m
//  ColorStar
//
//  Created by apple on 2020/11/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSHomeRecommendArtistCell.h"
@interface CSHomeRecommendArtistCell()
@property (nonatomic, strong)UIImageView                *headImage;
@property (nonatomic, strong)UIImageView                *headRaiduImage;
@property (nonatomic, strong)UILabel                    *nameLabel;
@property (nonatomic, strong)UIImageView                *statuImage;
@property (nonatomic, strong)UILabel                    *typeLabel;
@property (nonatomic, strong)UILabel                    *readNumLabel;
@property (nonatomic, strong)UILabel                    *introduceLabel;
@property (nonatomic, strong)UIButton                   *attentionButton;
@property (nonatomic, strong)UIImageView                *videoView;
@property (nonatomic, strong)UIButton                   *playButton;
@property (nonatomic, strong)CSNewHomeRecommendModel    *currentModel;

@end

@implementation CSHomeRecommendArtistCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
        self.currentModel = [[CSNewHomeRecommendModel alloc] init];
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.headImage = [[UIImageView alloc] init];
    ViewRadius(self.headImage, 19*heightScale);
    self.headImage.clipsToBounds = YES;
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.height.width.mas_offset(@(38*heightScale));
        make.top.mas_equalTo(self.contentView.mas_top).offset(16*heightScale);
    }];
    self.headRaiduImage = [[UIImageView alloc] init];
    self.headRaiduImage.image = [UIImage imageNamed:@"CS_home_recomendArtisheadRaiduImage.png"];
    [self.contentView addSubview:self.headRaiduImage];
    [self.headRaiduImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.self.headImage);
        make.height.width.mas_offset(@(40*heightScale));
    }];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = kFont(15);
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(10);
        make.top.mas_equalTo(self.headImage.mas_top);
        
    }];
    
    self.statuImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.statuImage];
    [self.statuImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(7);
        make.height.width.mas_offset(@(14*heightScale));
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
    }];
    
    
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.font = kFont(12);
    self.typeLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.typeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImage.mas_right).offset(10);
        make.bottom.mas_equalTo(self.headImage.mas_bottom);
        
    }];
    
    self.introduceLabel = [[UILabel alloc] init];
    self.introduceLabel.font = kFont(12);
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"#D7B393"];
    self.introduceLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.introduceLabel];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeLabel.mas_right).offset(6);
        make.centerY.mas_equalTo(self.typeLabel.mas_centerY);
    }];
    
    self.attentionButton = [[UIButton alloc] init];
    self.attentionButton.titleLabel.font = kFont(12);
    ViewRadius(self.attentionButton, 11);
    [self.attentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.attentionButton];
    [self.attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(widthScale *55));
        make.height.mas_offset(@(22));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.centerY.mas_equalTo(self.headRaiduImage.mas_centerY);
    }];
    
    self.videoView = [[UIImageView alloc] init];
    self.videoView.clipsToBounds = YES;
    self.videoView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.videoView];
    
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.top.mas_equalTo(self.headRaiduImage.mas_bottom).offset(7*heightScale);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
    self.playButton = [[UIButton alloc] init];
    self.playButton.hidden = YES;
    [self.playButton setImage:[UIImage imageNamed:@"CSNewHomeRecommendPlay.png"] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.top.mas_equalTo(self.headRaiduImage.mas_bottom).offset(7*heightScale);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
    self.readNumLabel = [[UILabel alloc] init];
    self.readNumLabel.font = kFont(12);
    self.readNumLabel.textColor = [UIColor colorWithHexString:@"#2C2C2C"];
    self.readNumLabel.textAlignment = NSTextAlignmentCenter;
    ViewRadius(self.readNumLabel, 3);
    self.readNumLabel.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF" alpha:0.8];
    [self.contentView addSubview:self.readNumLabel];
    [self.readNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-24*widthScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10*heightScale);
        make.width.mas_offset(@(50));
    }];
}

- (void)setModel:(CSNewHomeRecommendModel *)model
{
    _model = model;
    self.currentModel = model;
    [self resetUIModel];
}

- (void)resetUIModel{
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.currentModel.head_img] placeholderImage:[UIImage imageNamed:@"CSNewHeadplaceholderImage.png"]];
    self.nameLabel.text = self.currentModel.title;
    self.typeLabel.text = self.currentModel.subject_name;
    self.videoView.userInteractionEnabled =YES;
    [self.videoView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    self.introduceLabel.text =[NSString stringWithFormat:@"#%@",self.currentModel.label.firstObject];
    self.readNumLabel.text = self.currentModel.browse_count;
    if ([self.currentModel.is_follow isEqual:@"0"]) {
        self.attentionButton.selected = NO;
        [self.attentionButton setTitle:NSLocalizedString(@"关注",nil) forState:UIControlStateNormal];
        ViewBorder(self.attentionButton, [UIColor colorWithHexString:@"#D7B393"], 1);
        [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#181F30"]];
        [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#D7B393"] forState:UIControlStateNormal];
       CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"关注",nil) WithFont:12 WithLefAndeRightMargin:16];
        [self.attentionButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(@(width));
        }];
    }else{
        self.attentionButton.selected = YES;
        [self.attentionButton setTitle:NSLocalizedString(@"已关注",nil)  forState:UIControlStateNormal];
        [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"关注",nil) WithFont:12 WithLefAndeRightMargin:16];
         [self.attentionButton mas_updateConstraints:^(MASConstraintMaker *make) {
             make.width.mas_offset(@(width));
         }];
        [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#D7B393"]];
        
    }
}


- (void)attentionButtonClick:(UIButton *)btn{
    if (![[CSNewLoginUserInfoManager sharedManager] isLogin]) {
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
    }else{
        if (btn.selected) {
            [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
            [[CSNewHomeNetManager sharedManager] getHomeaddFollowSuccessId:self.currentModel.specialId Complete:^(CSNetResponseModel * _Nonnull response) {
                [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
                if (response.code == 200) {
                    [self.attentionButton setTitle:NSLocalizedString(@"关注",nil) forState:UIControlStateNormal];
                    ViewBorder(self.attentionButton, [UIColor colorWithHexString:@"#D7B393"], 1);
                    [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#181F30"]];
                    [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#D7B393"] forState:UIControlStateNormal];
                   CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"关注",nil) WithFont:12 WithLefAndeRightMargin:16];
                    [self.attentionButton mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_offset(@(width));
                    }];
                    btn.selected = NO;
                }else{
                    [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
                }
            } failureComplete:^(NSError * _Nonnull error) {
                [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
            }];
            
        }else{
            [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
            [[CSNewHomeNetManager sharedManager] getHomeaddFollowSuccessId:self.currentModel.specialId Complete:^(CSNetResponseModel * _Nonnull response) {
                [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
                if (response.code == 200) {
                    [self.attentionButton setTitle:NSLocalizedString(@"已关注",nil)  forState:UIControlStateNormal];
                    [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
                    CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"已关注",nil) WithFont:12 WithLefAndeRightMargin:16];
                     [self.attentionButton mas_updateConstraints:^(MASConstraintMaker *make) {
                         make.width.mas_offset(@(width));
                     }];
                    [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#D7B393"]];
              
                    btn.selected = YES;
                }else{
                    [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
                }
            } failureComplete:^(NSError * _Nonnull error) {
                [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
            }];
            
        }
    }
  
}

- (void)playClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(CSHomeRecommendArtistCellPlayButton:)]) {
        [self.delegate CSHomeRecommendArtistCellPlayButton:self.currentModel];
    }
}


@end
