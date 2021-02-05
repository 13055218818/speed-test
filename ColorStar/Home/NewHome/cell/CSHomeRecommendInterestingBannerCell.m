



//
//  MyCell.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "CSHomeRecommendInterestingBannerCell.h"
@interface CSHomeRecommendInterestingBannerCell()
@property (nonatomic, strong)CSNewHomeRecommendInterstingModel    *currentModel;

@end
@implementation CSHomeRecommendInterestingBannerCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        ViewRadius(self, 6);
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    self.deleteButton = [[UIButton alloc] init];
    [self.deleteButton setImage:[UIImage imageNamed:@"CSHomeRecommendInterestingBannerDelete.png"] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(15));
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
    }];
    
    self.headImage = [[UIImageView alloc] init];
    self.headImage.clipsToBounds = YES;
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    ViewRadius(self.headImage, 23*heightScale);
    self.headImage.image = [UIImage imageNamed:@"cs_home_banner.png"];
    [self.contentView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.width.mas_offset(@(46*heightScale));
        make.top.mas_equalTo(self.contentView.mas_top).offset(24*heightScale);
    }];
    self.headRaiduImage = [[UIImageView alloc] init];
    self.headRaiduImage.image = [UIImage imageNamed:@"CS_home_recomendArtisheadRaiduImage.png"];
    [self.contentView addSubview:self.headRaiduImage];
    [self.headRaiduImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.self.headImage);
        make.height.width.mas_offset(@(48*heightScale));
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    //self.nameLabel.text = NSLocalizedString(@"吴牧野",nil);
    self.nameLabel.font = kFont(12);
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headImage.mas_centerX);
        make.top.mas_equalTo(self.headImage.mas_bottom).offset(8);
        
    }];
    
    //
    
    self.tagButton = [[UIButton alloc] init];
//    [self.tagButton setTitle:@"时尚达人" forState:UIControlStateNormal];
    [self.tagButton setTitleColor:[UIColor colorWithHexString:@"#202020"] forState:UIControlStateNormal];
    self.tagButton.titleLabel.font = kFont(8);
    [self.tagButton setImage:[UIImage imageNamed:@"CSHomeRecommendInterestingBannerTag.png"] forState:UIControlStateNormal];
    ViewRadius(self.tagButton, 9);
    ViewBorder(self.tagButton, [UIColor colorWithHexString:@"#D7B393"], 1);
    [self.contentView addSubview:self.tagButton];
    [self.tagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(60));
        make.height.mas_offset(@(18));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(4);
        make.centerX.mas_equalTo(self.nameLabel.mas_centerX);
    }];
    
    self.attentionButton = [[UIButton alloc] init];
    self.attentionButton.titleLabel.font = kFont(12);
    [self.attentionButton setTitle:NSLocalizedString(@"关注",nil) forState:UIControlStateNormal];
    ViewRadius(self.attentionButton, 11);
    [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#202020"] forState:UIControlStateNormal];
    [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#D7B393"]];
    [self.attentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.attentionButton];
    [self.attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(widthScale *55));
        make.height.mas_offset(@(22));
        make.top.mas_equalTo(self.tagButton.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.headRaiduImage.mas_centerX);
    }];
}

- (void)deleteButtonClick{
    if ([self.delegate respondsToSelector:@selector(deleteCellWith:)]) {
        [self.delegate deleteCellWith:self.currentModel];
    }
}

- (void)setModel:(CSNewHomeRecommendInterstingModel *)model
{
    _model = model;
    self.currentModel = model;
    self.nameLabel.text = model.title;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"CSNewHeadplaceholderImage.png"]];
    [self.tagButton setTitle:model.subject_name forState:UIControlStateNormal];
    CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:model.subject_name WithFont:8 WithLefAndeRightMargin:12];
     [self.tagButton mas_updateConstraints:^(MASConstraintMaker *make) {
         make.width.mas_offset(@(width));
     }];
    
    if (![model.is_follow isEqual:@"0"]) {
        self.attentionButton.selected = NO;
        [self.attentionButton setTitle:NSLocalizedString(@"已关注",nil) forState:UIControlStateNormal];
        ViewBorder(self.attentionButton, [UIColor colorWithHexString:@"#D7B393"], 1);
        [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#D7B393"] forState:UIControlStateNormal];
       CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"关注",nil) WithFont:12 WithLefAndeRightMargin:16];
        [self.attentionButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(@(width));
        }];
    }else{
        self.attentionButton.selected = YES;
        [self.attentionButton setTitle:NSLocalizedString(@"关注",nil)  forState:UIControlStateNormal];
        [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"关注",nil) WithFont:12 WithLefAndeRightMargin:16];
         [self.attentionButton mas_updateConstraints:^(MASConstraintMaker *make) {
             make.width.mas_offset(@(width));
         }];
        [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#D7B393"]];
        
    }
}

- (void)attentionButtonClick:(UIButton *)btn{
    if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
    if (btn.selected) {
        [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
        [[CSNewHomeNetManager sharedManager] getHomeaddFollowSuccessId:self.currentModel.subject_id Complete:^(CSNetResponseModel * _Nonnull response) {
            [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
            if (response.code == 200) {
                [self.attentionButton setTitle:NSLocalizedString(@"已关注",nil) forState:UIControlStateNormal];
                ViewBorder(self.attentionButton, [UIColor colorWithHexString:@"#D7B393"], 1);
                [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
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
        [[CSNewHomeNetManager sharedManager] getHomeaddFollowSuccessId:self.currentModel.subject_id Complete:^(CSNetResponseModel * _Nonnull response) {
            [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
            if (response.code == 200) {
                [self.attentionButton setTitle:NSLocalizedString(@"关注",nil)  forState:UIControlStateNormal];
                [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
                CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"关注",nil) WithFont:12 WithLefAndeRightMargin:16];
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
        
        
    }else{
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
    }

}
@end
