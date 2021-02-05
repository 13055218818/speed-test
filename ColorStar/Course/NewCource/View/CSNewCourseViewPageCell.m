//
//  CSNewCourseViewPageCell.m
//  ColorStar
//
//  Created by apple on 2020/11/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewCourseViewPageCell.h"
#import "CSNewHomeNetManager.h"
@interface CSNewCourseViewPageCell()
@property (nonatomic ,strong)UIView               *bgImageView;
@property (nonatomic ,strong)UILabel                *nameLabel;
@property (nonatomic ,strong)UILabel                *tagLabel;
@property (nonatomic ,strong)UIButton               *attentionButton;
@property (nonatomic ,strong)UIView                 *centerView;
@property (nonatomic ,strong)UILabel                *listLabel;

@property (nonatomic ,strong)UIView                 *listView;
@property (nonatomic ,strong)CSNewCourseModel       *currentModel;
@end
@implementation CSNewCourseViewPageCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.currentModel = [[CSNewCourseModel  alloc] init];
        self.backgroundColor = [UIColor whiteColor];//[UIColor colorWithHexString:@"#181F30"];
        ViewRadius(self, 5);
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.bgImageView = [[UIView alloc] init];
      self.bgImageView.frame = CGRectMake(0, 0, ScreenW- 80*widthScale, 95*heightScale);
//    CAGradientLayer *gradientLayer = [[CSTotalTool sharedInstance] makeCAGradientLayerFrame:CGRectMake(0, 0, ScreenW- 80*widthScale, 95*heightScale) withStartColor:[UIColor colorWithHexString:@"#A387FB"] withEndColor:[UIColor colorWithHexString:@"#552AD1"]];
//    [self.bgImageView.layer addSublayer:gradientLayer];
    ViewRadius(self.bgImageView, 5);
    [self.contentView addSubview:self.bgImageView];
    
    UIView  *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    ViewRadius(whiteView, 10);
    [self.contentView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).offset(70*heightScale);
    }];
    
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.clipsToBounds = YES;
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    //self.headImageView.image = [UIImage imageNamed:@"about"];
    ViewRadius(self.headImageView, 40*heightScale);
    [self.contentView addSubview:self.headImageView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(80*heightScale));
        make.left.mas_equalTo(self.contentView.mas_left).offset(15*widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(40*widthScale);
    }];
    
    self.statuImageView = [UIImageView new];
    //self.statuImageView.image = [UIImage imageNamed:@"CSNewCourseViewListTOP1.png"];
    [self.contentView addSubview:self.statuImageView];
    [self.statuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.headImageView);
        make.width.mas_offset(@(35));
        make.height.mas_offset(@(17));
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    //self.nameLabel.text = @"魏巡";
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#181F30"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10*widthScale);
        make.top.mas_equalTo(self.contentView.mas_top).offset(80*heightScale);
    }];
    
    
    self.tagLabel = [[UILabel alloc] init];
    //self.tagLabel.text = @"歌手 | 演唱";
    self.tagLabel.font = kFont(12);
    self.tagLabel.textColor = [UIColor colorWithHexString:@"#181F30"];
    self.tagLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10*widthScale);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
        make.width.mas_offset(@(110*widthScale));
    }];
    
    self.attentionButton = [[UIButton alloc] init];
    self.attentionButton.titleLabel.font = kFont(12);
    ViewRadius(self.attentionButton, 11);
    [self.attentionButton addTarget:self action:@selector(attentionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.attentionButton];
   
    [self.attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16*widthScale);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
        make.width.mas_offset(@(widthScale *55));
        make.height.mas_offset(@(22));
    }];
    
    
    
    self.centerView = [[UIView alloc] init];
    ViewRadius(self.centerView, 3.5);
    self.centerView.backgroundColor = [UIColor colorWithHexString:@"#181F30" alpha:0.06];
    [self.contentView addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(15*heightScale);
        make.height.mas_offset(@(47*heightScale));
    }];
    NSArray  *numNameArray = @[csnation(@"课程数量"),csnation(@"关注者"),csnation(@"播放次数")];
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel  *numLabel = [[UILabel alloc] init];
        numLabel.tag = 100 +i;
        numLabel.text = @"0";
        numLabel.font = [UIFont boldSystemFontOfSize:13];
        numLabel.textColor = [UIColor colorWithHexString:@"#181F30"];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.frame = CGRectMake(i *(ScreenW - 110*widthScale)/3, 10*heightScale,(ScreenW - 110*widthScale)/3, 11);
        [self.centerView addSubview:numLabel];
        
        UILabel  *numNameLabel = [[UILabel alloc] init];
        numNameLabel.text = numNameArray[i];
        numNameLabel.font = kFont(10);
        numNameLabel.textColor = [UIColor colorWithHexString:@"#181F30"];
        numNameLabel.textAlignment = NSTextAlignmentCenter;
        numNameLabel.frame = CGRectMake(i *(ScreenW - 110*widthScale)/3, 28*heightScale,(ScreenW - 110*widthScale)/3, 11);
        [self.centerView addSubview:numNameLabel];
    }
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#181F30" alpha:0.1];
    lineView1.frame = CGRectMake((ScreenW - 110*widthScale)/3, 14*heightScale, 1, 20*heightScale);
    [self.centerView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#181F30" alpha:0.1];
    lineView2.frame = CGRectMake(2*(ScreenW - 110*widthScale)/3, 14*heightScale, 1, 20*heightScale);
    [self.centerView addSubview:lineView2];
    
    
    self.listLabel = [[UILabel alloc] init];
    self.listLabel.text = csnation(@"导师课程");
    self.listLabel.font = [UIFont boldSystemFontOfSize:13];
    self.listLabel.textColor = [UIColor colorWithHexString:@"#181F30"];
    self.listLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.listLabel];
    [self.listLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20*widthScale);
        make.top.mas_equalTo(self.centerView.mas_bottom).offset(14*heightScale);
    }];
    
    self.moreLabel = [[UILabel alloc] init];
//    [self.moreLabel setTapActionWithBlock:^{
//        CSTutorDetailViewController *vc = [CSTutorDetailViewController new];
//        vc.tutorId = self.currentModel.subject_id;
//        [[CSTotalTool getCurrentShowViewController].navigationController pushViewController:vc animated:YES];
//    }];
    self.moreLabel.text = csnation(@"查看更多他的视频");
    self.moreLabel.font = kFont(10);
    self.moreLabel.textColor = [UIColor colorWithHexString:@"#181F30"];
    self.moreLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.moreLabel];
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10*heightScale);
    }];
    
    self.listView  = [[UIView alloc] init];
    ViewRadius(self.listView, 5);
    [self.contentView addSubview:self.listView];
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15*widthScale);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15*widthScale);
        make.top.mas_equalTo(self.listLabel.mas_bottom).offset(13*heightScale);
        make.bottom.mas_equalTo(self.moreLabel.mas_top).offset(-10*heightScale);
    }];

    
}

- (CGFloat)getButtonWidth:(NSString *)str WithFont:(CGFloat)font{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}];
    CGSize statuseStrSize = CGSizeMake(ceilf(size.width), ceilf(size.height));

    CGFloat labWith =statuseStrSize.width +30;
    return labWith;
}



- (void)setModel:(CSNewCourseModel *)model{
    _model = model;
    self.currentModel = model;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.info.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
    //self.bgImageView.backgroundColor = [UIColor colorWithPatternImage:self.headImageView.image];
    UIColor  *mainColor =  [[CSTotalTool sharedInstance] mainColorOfImage:self.headImageView.image with:YES];
    UIColor  *nextColor =  [[CSTotalTool sharedInstance] mainColorOfImage:self.headImageView.image with:NO];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)mainColor.CGColor,(__bridge id)nextColor.CGColor];
        gradientLayer.locations = @[@0.5,@1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, ScreenW- 80*widthScale,  95*heightScale);
    //CGRectMake(0, 0, ScreenW- 80*widthScale, 95*heightScale);
        [self.bgImageView.layer addSublayer:gradientLayer];
    self.nameLabel.text = model.info.title;
    self.tagLabel.text = [NSString stringWithFormat:@"%@|%@",model.subject_name,model.info.label.firstObject];
    if ([model.info.is_follow isEqual:@"0"]) {
        self.attentionButton.selected = NO;
        [self.attentionButton setTitle:NSLocalizedString(@"关注",nil) forState:UIControlStateNormal];
        ViewBorder(self.attentionButton, [UIColor colorWithHexString:@"#D7B393"], 1);
        [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#D7B393"] forState:UIControlStateNormal];
       CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"关注",nil) WithFont:12 WithLefAndeRightMargin:16];
        [self.attentionButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(@(width));
        }];
    }else{
        self.attentionButton.selected = YES;
        [self.attentionButton setTitle:NSLocalizedString(@"已关注",nil)  forState:UIControlStateNormal];
        [self.attentionButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        CGFloat width= [[CSTotalTool sharedInstance] getButtonWidth:NSLocalizedString(@"已关注",nil) WithFont:12 WithLefAndeRightMargin:16];
         [self.attentionButton mas_updateConstraints:^(MASConstraintMaker *make) {
             make.width.mas_offset(@(width));
         }];
        [self.attentionButton setBackgroundColor:[UIColor colorWithHexString:@"#D7B393"]];
        
    }
    
    UILabel  *numLabel1 = (UILabel *)[self.centerView viewWithTag:100];
    numLabel1.text = model.info.task_count;
    UILabel  *numLabel2 = (UILabel *)[self.centerView viewWithTag:101];
    numLabel2.text = model.info.follow_count;
    UILabel  *numLabel3 = (UILabel *)[self.centerView viewWithTag:102];
    numLabel3.text = model.info.play_count;
    [self makeListViewWith:model];
}

- (void)makeListViewWith:(CSNewCourseModel *)modl{
    [self.listView layoutIfNeeded];
    [self.listView removeAllSubviews];
    if (modl.info.task_list.count < 4) {
        self.moreLabel.hidden = YES;
    }else{
        self.moreLabel.hidden = NO;
    }
    CGFloat listHWidth = (self.listView.frame.size.width - 15*widthScale)/2;
    CGFloat listHeight = (self.listView.frame.size.height - 15*widthScale)/2;
    
    for (NSInteger i = 0; i < modl.info.task_list.count; i ++) {
        CSNewCourseListInfoTaskListModel *videoModel = [CSNewCourseListInfoTaskListModel yy_modelWithDictionary:modl.info.task_list[i]];
        UIView  *view = [[UIView alloc] init];
        ViewRadius(view, 5);
        view.frame = CGRectMake(i %2*(listHWidth+15*widthScale), i /2*(listHeight+15*heightScale), listHWidth, listHeight);
        [self.listView addSubview:view];
        
        UIImageView *image = [[UIImageView  alloc] init];
        [image setTapActionWithBlock:^{
            if (self.clickBlock) {
                self.clickBlock(videoModel);
            }
        }];
        ViewRadius(image, 5);
        image.clipsToBounds = YES;
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.frame = CGRectMake(0, 0, listHWidth, listHWidth);
        [image sd_setImageWithURL:[NSURL URLWithString:videoModel.image] placeholderImage:[UIImage imageNamed:@"CSNewListBgDefaault.png"]];
        //image.image = [UIImage imageNamed:@"cs_home_banner.png"];
        [view addSubview:image];
        
       UILabel *nameLabel= [[UILabel alloc] init];
        nameLabel.text = videoModel.title;
        nameLabel.font = [UIFont boldSystemFontOfSize:10];
        nameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.frame = CGRectMake(4, listHeight-25*heightScale, 70*widthScale, 14*heightScale);
        [view addSubview:nameLabel];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.4];
        timeLabel.text = videoModel.play_count;//NSLocalizedString(@"08:10",nil);
        timeLabel.font = kFont(9);
        timeLabel.textColor = [UIColor colorWithHexString:@"#181F30"];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(view.mas_right).offset(-4*widthScale);
            make.centerY.mas_equalTo(nameLabel.mas_centerY);
            make.width.mas_offset(@(40));
            make.height.mas_offset(@(15));
        }];
        [timeLabel layoutIfNeeded];
        [[CSTotalTool sharedInstance] setPartRoundWithView:timeLabel corners:UIRectCornerTopRight cornerRadius:8.0];
    }
}

- (void)attentionButtonClick:(UIButton *)btn{
    if (![[CSNewLoginUserInfoManager sharedManager] isLogin]) {
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
    }else{
    if (btn.selected) {
        [[CSTotalTool sharedInstance] showHudInView:[CSTotalTool getCurrentShowViewController].view hint:@""];
        [[CSNewHomeNetManager sharedManager] getHomeaddFollowSuccessId:self.currentModel.courseId Complete:^(CSNetResponseModel * _Nonnull response) {
            [[CSTotalTool sharedInstance] hidHudInView:[CSTotalTool getCurrentShowViewController].view];
            if (response.code == 200) {
        [self.attentionButton setTitle:NSLocalizedString(@"关注",nil) forState:UIControlStateNormal];
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
        [[CSNewHomeNetManager sharedManager] getHomeaddFollowSuccessId:self.currentModel.courseId Complete:^(CSNetResponseModel * _Nonnull response) {
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
@end
