//
//  CSNewMineViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/11.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewMineViewController.h"
#import "CsLoginEnglishViewController.h"
#import "CSNewMyCollectViewController.h"
#import "CSNewMyOrderViewController.h"
#import "CSNewSettingViewController.h"
#import "CSPersonModifyViewController.h"
#import "CSNewMinePunchViewController.h"
#import "CSNewMediaLiveViewController.h"
#import "CSNewMYshareViewController.h"

@interface CSNewMineViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView           *mainScrollerView;
@property (nonatomic, strong)UIImageView            *bgImage;
@property (nonatomic, strong)UIButton               *topRightButton;
@property (nonatomic, strong)UIImageView            *headImage;
@property (nonatomic, strong)UIImageView            *headVipImage;
@property (nonatomic, strong)UILabel                *namettLabel;
@property (nonatomic, strong)UIButton               *wxButton;
@property (nonatomic, strong)UIButton               *phoneButton;
@property (nonatomic, strong)UILabel                *goldLabel;
@property (nonatomic, strong)UILabel                *moneyLabel;
@property (nonatomic, strong)UILabel                *frendsLabel;
@property (nonatomic, strong)UILabel                *attenionLabel;
@property (nonatomic, strong)UIImageView            *centerVipImage;
@property (nonatomic, strong)UIButton               *vipButton;
@property (nonatomic, strong)UILabel                *vipLabel;

@property (nonatomic, strong)UIButton               *loginButton;
@property (nonatomic, strong)CSNewLoginModel        *currentUserInfo;
@end

@implementation CSNewMineViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadRefreshUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
}
-(void)loginSuccess{
    [self loadRefreshUI];
}
- (void)loadRefreshUI{
    if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
        [[CSNewLoginNetManager sharedManager] getUserInfoWithTokenComplete:^(CSNetResponseModel * _Nonnull response) {
            if (response.code == 200) {
                NSDictionary  *dict = response.data;
                CSNewLoginModel *model= [CSNewLoginModel yy_modelWithDictionary:dict];
                [CSNewLoginUserInfoManager sharedManager].userInfo = model;
                [self loadRefreshData];
            }
        } failureComplete:^(NSError * _Nonnull error) {
            
        }];
        
    }else{
        self.namettLabel.hidden = YES;
        self.wxButton.hidden = YES;
        self.phoneButton.hidden = YES;
        self.headVipImage.hidden = YES;
        self.loginButton.hidden = NO;
        self.vipButton.hidden = YES;
        self.goldLabel.text = @"0";
        self.attenionLabel.text = @"0";
        self.moneyLabel.text = @"0";
        self.bgImage.image =[UIImage imageNamed:@"CSNewMyDefultImage.png"];
    }
    if ([[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide) {
        self.vipLabel.hidden = YES;
        self.vipButton.hidden = YES;
        self.centerVipImage.hidden = YES;
        self.headVipImage.hidden = YES;
        self.goldLabel.hidden = YES;
        self.attenionLabel.hidden = YES;
        self.moneyLabel.hidden = YES;
    }
}

- (void)loadRefreshData{
    self.currentUserInfo =[CSNewLoginUserInfoManager sharedManager].userInfo;
    self.namettLabel.hidden = NO;
    self.wxButton.hidden = NO;
    self.phoneButton.hidden = NO;
    self.headVipImage.hidden = NO;
    self.loginButton.hidden = YES;
    self.vipButton.hidden = NO;
    self.namettLabel.text = self.currentUserInfo.nickname;
    
    NSString * headImage = self.currentUserInfo.avatar;
    if (![self.currentUserInfo.avatar hasPrefix:@"http"]) {
        headImage = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,self.currentUserInfo.avatar];
    }
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:[UIImage imageNamed:@"CSNewMyDefultImage.png"]];
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:nil];
    if ([self.currentUserInfo.is_vip isEqualToString:@"0"]) {
        self.headVipImage.hidden = YES;
    }else{
        self.headVipImage.hidden = NO;
    }
    if (self.currentUserInfo.wx_name.length > 0) {
        [self.wxButton setTitle:[NSString stringWithFormat:@" : %@",self.currentUserInfo.wx_name] forState:UIControlStateNormal];
    }else{
        self.wxButton.hidden = YES;
    }
    
    if (self.currentUserInfo.phone.length > 0) {
        [self.phoneButton setTitle:[NSString stringWithFormat:@" : %@",self.currentUserInfo.phone] forState:UIControlStateNormal];
    }else{
        self.phoneButton.hidden = YES;
    }
    
    
    self.goldLabel.text = self.currentUserInfo.now_money;
    self.moneyLabel.text = self.currentUserInfo.rechargeMoney;
    self.attenionLabel.text = self.currentUserInfo.collectionNumber;
    if ([self.currentUserInfo.is_vip isEqualToString:@"1"]) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        
        NSDate* date = [NSDate dateWithTimeIntervalSince1970: [self.currentUserInfo.overdue_time integerValue]];
        
        NSString* dateString = [formatter stringFromDate:date];
        
        self.vipLabel.text = [NSString stringWithFormat:@"%@%@",dateString,csnation(@"到期")];
        [self.vipButton setTitle:@"立即续费" forState:UIControlStateNormal];
        CGFloat widthvip = [[CSTotalTool sharedInstance] getButtonWidth:@"立即续费" WithFont:12 WithLefAndeRightMargin:19];
        [self.vipButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.centerVipImage.mas_centerY);
            make.right.mas_equalTo(self.view.mas_right).offset(-20*widthScale);
            make.height.mas_offset(30*heightScale);
            make.width.mas_offset(widthvip);
        }];
    }else{
        self.vipLabel.text = csnation(@"您有新的权益待领取");
        [self.vipButton setTitle:csnation(@"立即领取") forState:UIControlStateNormal];
        CGFloat widthvip = [[CSTotalTool sharedInstance] getButtonWidth:csnation(@"立即领取") WithFont:12 WithLefAndeRightMargin:19];
        [self.vipButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.centerVipImage.mas_centerY);
            make.right.mas_equalTo(self.view.mas_right).offset(-20*widthScale);
            make.height.mas_offset(30*heightScale);
            make.width.mas_offset(widthvip);
        }];
    }
    
    if ([[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide) {
        self.vipLabel.hidden = YES;
        self.vipButton.hidden = YES;
        self.centerVipImage.hidden = YES;
        self.headVipImage.hidden = YES;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self makeUI];
    
}

- (void)makeUI{
    
    self.mainScrollerView = [[UIScrollView alloc] init];
    self.mainScrollerView.showsHorizontalScrollIndicator=NO;
    self.mainScrollerView.showsVerticalScrollIndicator=NO;
    self.mainScrollerView.scrollEnabled=YES;
    self.mainScrollerView.pagingEnabled = NO;
    self.mainScrollerView.delegate = self;
    self.mainScrollerView.contentSize=CGSizeMake(ScreenW, heightScale *900);
    self.mainScrollerView.backgroundColor =[UIColor colorWithHexString:@"#181F30"];
    [self.view addSubview:self.mainScrollerView];
    [self.mainScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(-kStatusBarHeight);
    }];
    
    self.bgImage =[[UIImageView alloc]initWithFrame:CGRectZero];
    
    self.bgImage.contentMode =UIViewContentModeScaleToFill;
    [self.mainScrollerView addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainScrollerView);
        make.height.mas_offset(@(250*heightScale +kStatusBarHeight));
        make.width.mas_offset(@(ScreenW));
    }];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.9;
    effectView.backgroundColor = [UIColor clearColor];
    effectView.frame = CGRectMake(0, 0, ScreenW, 252*heightScale +kStatusBarHeight);
    [self.mainScrollerView addSubview:effectView];
    
    self.bgImage.image =[UIImage imageNamed:@"CSNewMyDefultImage.png"];
    
    self.topRightButton = [[UIButton alloc] init];
    [self.topRightButton setTapActionWithBlock:^{
        if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
            [self.navigationController pushViewController:[CSPersonModifyViewController new] animated:YES];
        }else{
            [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                
            }];
        }
        
    }];
    [self.topRightButton setImage:[UIImage imageNamed:@"CSNewMineTopRight.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.topRightButton];
    [self.topRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(25*heightScale));
        make.top.mas_equalTo(self.mainScrollerView.mas_top).offset(37*heightScale +kStatusBarHeight);
        make.right.mas_equalTo(self.mainScrollerView.mas_right).offset(-15*widthScale);
    }];
    
    self.headImage = [[UIImageView alloc] init];
    self.headImage.image = [UIImage imageNamed:@"CSNewMyDefultImage.png"];
    ViewRadius(self.headImage, 60*heightScale);
    self.headImage.layer.masksToBounds = YES;
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.mainScrollerView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(@(120*heightScale));
        make.top.mas_equalTo(self.mainScrollerView.mas_top).offset(47*heightScale +kStatusBarHeight);
        make.left.mas_equalTo(self.mainScrollerView.mas_left).offset(15*widthScale);
    }];
    
    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setTapActionWithBlock:^{
        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
            
        }];
    }];
    [self.loginButton setTitle:csnation(@"请登陆") forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor colorWithHexString:@"#C8AE99"] forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = kFont(12);
    [self.loginButton setBackgroundColor:[UIColor colorWithHexString:@"#181F30" alpha:0.5]];
    ViewRadius(self.loginButton, 14*heightScale);
    ViewBorder(self.loginButton, [UIColor colorWithHexString:@"#C8AE99"], 1.0);
    CGFloat  loginWidth = [[CSTotalTool sharedInstance] getButtonWidth:csnation(@"请登陆") WithFont:12 WithLefAndeRightMargin:15];
    [self.mainScrollerView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(loginWidth));
        make.height.mas_offset(@(28*heightScale));
        make.centerY.mas_equalTo(self.headImage.mas_centerY);
        make.left.mas_equalTo(self.headImage.mas_right).offset(15*widthScale);
    }];
    
    self.namettLabel = [[UILabel alloc] init];
    //self.namettLabel.text = @"半夏";
    self.namettLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.namettLabel.font = [UIFont boldSystemFontOfSize:18];
    self.namettLabel.textAlignment = NSTextAlignmentLeft;
    [self.mainScrollerView addSubview:self.namettLabel];
    [self.namettLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImage.mas_top).offset(30*heightScale);
        make.left.mas_equalTo(self.headImage.mas_right).offset(11*widthScale);
    }];
    
    self.wxButton = [[UIButton alloc] init];
    // [self.wxButton setTitle:@": 34567892" forState:UIControlStateNormal];
    [self.wxButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.wxButton.titleLabel.font = kFont(12);
    [self.wxButton setImage:[UIImage imageNamed:@"CSNewMineTopwx.png"] forState:UIControlStateNormal];
    [self.wxButton setBackgroundColor:[UIColor colorWithHexString:@"#28C445" alpha:0.3]];
    ViewRadius(self.wxButton, 14*heightScale);
    [self.mainScrollerView addSubview:self.wxButton];
    [self.wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(130*widthScale));
        make.height.mas_offset(@(28*heightScale));
        make.top.mas_equalTo(self.namettLabel.mas_bottom).offset(14*heightScale);
        make.left.mas_equalTo(self.headImage.mas_right).offset(11*widthScale);
    }];
    
    self.phoneButton = [[UIButton alloc] init];
    //[self.phoneButton setTitle:@": 34567892" forState:UIControlStateNormal];
    [self.phoneButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.phoneButton.titleLabel.font = kFont(12);
    [self.phoneButton setImage:[UIImage imageNamed:@"CSNewMineTopPhone.png"] forState:UIControlStateNormal];
    [self.phoneButton setBackgroundColor:[UIColor colorWithHexString:@"#255AFF" alpha:0.3]];
    ViewRadius(self.phoneButton, 14*heightScale);
    [self.mainScrollerView addSubview:self.phoneButton];
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(@(130*widthScale));
        make.height.mas_offset(@(28*heightScale));
        make.top.mas_equalTo(self.wxButton.mas_bottom).offset(5*heightScale);
        make.left.mas_equalTo(self.headImage.mas_right).offset(11*widthScale);
    }];
    
    //    CSNewMineTopHeadImageVip
    self.headVipImage =[[UIImageView alloc]initWithFrame:CGRectZero];
    self.headVipImage.image = [UIImage imageNamed:@"CSNewMineTopHeadImageVip.png"];
    [self.mainScrollerView addSubview:self.headVipImage];
    [self.headVipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImage.mas_top).offset(105*heightScale);
        make.height.mas_offset(@(30*heightScale));
        make.centerX.mas_equalTo(self.headImage);
    }];
    
    
    self.goldLabel = [[UILabel alloc] init];
    //self.goldLabel.text = @"111";
    self.goldLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.goldLabel.font = [UIFont boldSystemFontOfSize:18];
    self.goldLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollerView addSubview:self.goldLabel];
    [self.goldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headVipImage.mas_bottom).offset(23*heightScale);
        make.left.mas_equalTo(self.mainScrollerView.mas_left);
        make.width.mas_offset(@(ScreenW/3));
    }];
    
    
    self.moneyLabel = [[UILabel alloc] init];
    //self.moneyLabel.text = @"111";
    self.moneyLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.moneyLabel.font = [UIFont boldSystemFontOfSize:18];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollerView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headVipImage.mas_bottom).offset(23*heightScale);
        make.left.mas_equalTo(self.mainScrollerView.mas_left).offset(ScreenW/3);
        make.width.mas_offset(@(ScreenW/3));
    }];
    
    self.attenionLabel = [[UILabel alloc] init];
    //self.attenionLabel.text = @"111";
    self.attenionLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.attenionLabel.font = [UIFont boldSystemFontOfSize:18];
    self.attenionLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollerView addSubview:self.attenionLabel];
    [self.attenionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headVipImage.mas_bottom).offset(23*heightScale);
        make.left.mas_equalTo(self.mainScrollerView.mas_left).offset(2*ScreenW/3);
        make.width.mas_offset(@(ScreenW/3));
    }];
    //        if([[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide){
    //
    //        }else{
    //            label.hidden = NO;
    //        }
    NSArray  *ayyay = @[csnation(@"我的金币"),csnation(@"充值"),csnation(@"我的关注")];//@[@"我的金币",@"充值",@"我的关注"];
    for (NSInteger i=0; i < 3; i ++) {
        UILabel  *label= [[UILabel alloc] init];
        if([[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide){
            label.hidden = YES;
        }else{
            label.hidden = NO;
        }
        label.text = ayyay[i];
        label.textColor = [UIColor colorWithHexString:@"#FEFEFE" alpha:0.5];
        label.font = kFont(12);
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(ScreenW/3*i, 250*heightScale + kStatusBarHeight -17*heightScale, ScreenW/3, 11);
        if (i == 1) {
            if(![[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide){
                [label setTapActionWithBlock:^{
                    if([[CSNewLoginUserInfoManager sharedManager] isLogin]){
                        [[CSNewPayManage sharedManager] gotoGoldPayWithPay:^(BOOL success) {
                            if (success) {
                                [[CSTotalTool sharedInstance] showHudInView:self.view hint:@""];
                                [[CSNewLoginNetManager  sharedManager] getUserInfoWithTokenComplete:^(CSNetResponseModel * _Nonnull response) {
                                    [[CSTotalTool sharedInstance] hidHudInView:self.view];
                                    if (response.code == 200) {
                                        NSDictionary  *dict = response.data;
                                        CSNewLoginModel *model= [CSNewLoginModel yy_modelWithDictionary:dict];
                                        [CSNewLoginUserInfoManager sharedManager].userInfo = model;
                                        [self loadRefreshData];
                                    }
                                    
                                } failureComplete:^(NSError * _Nonnull error) {
                                    
                                }];
                            };
                        }];
                        
                    }else{
                        [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                            
                        }];
                    }
                    
                }];
            }
            
        }
        [self.mainScrollerView addSubview:label];
    }
    for (NSInteger i=0; i < 2; i ++) {
        UIView  *lineView= [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.1];
        lineView.frame = CGRectMake(ScreenW/3*(i+1), 250*heightScale + kStatusBarHeight -38*heightScale, 1/[UIScreen mainScreen].scale, 20*heightScale);
        [self.mainScrollerView addSubview:lineView];
    }
    
    
    self.centerVipImage = [[UIImageView alloc] init];
    self.centerVipImage.image = [UIImage imageNamed:@"CSNewMineVIPCard.png"];
    [self.mainScrollerView addSubview:self.centerVipImage];
    [self.centerVipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainScrollerView);
        make.top.mas_equalTo(self.bgImage.mas_bottom);
        make.height.mas_offset(@(100*heightScale));
        make.width.mas_offset(@(ScreenW));
    }];
    
    self.vipLabel = [[UILabel alloc] init];
    //self.vipLabel.text = @"2021年-11-04到期";
    self.vipLabel.textColor = [UIColor colorWithHexString:@"#181F30"];
    self.vipLabel.font = [UIFont boldSystemFontOfSize:12];
    self.vipLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollerView addSubview:self.vipLabel];
    [self.vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.centerVipImage.mas_top).offset(65*heightScale);
        make.left.mas_equalTo(self.mainScrollerView.mas_left).offset(88*widthScale);
    }];
    
    self.vipButton = [[UIButton alloc] init];
    [self.vipButton setTapActionWithBlock:^{
        [[CSNewPayManage sharedManager] gotoVipPayWithPay:^(BOOL success) {
            if (success) {
                [WHToast showMessage:csnation(@"成功") duration:1 finishHandler:nil];
            }else{
                [WHToast showMessage:csnation(@"失败") duration:1 finishHandler:nil];
            }
        }];
        
    }];
    // [self.vipButton setTitle:@": 34567892" forState:UIControlStateNormal];
    [self.vipButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:0.3] forState:UIControlStateNormal];
    self.vipButton.titleLabel.font = kFont(12);
    //    [self.vipButton setImage:[UIImage imageNamed:@"CSNewMineTopPhone.png"] forState:UIControlStateNormal];
    [self.vipButton setBackgroundColor:[UIColor colorWithHexString:@"#181F30"]];
    ViewRadius(self.vipButton, 15*heightScale);
    [self.mainScrollerView addSubview:self.vipButton];
    [self.vipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerVipImage.mas_centerY);
        //make.height.mas_equalTo(@(40*widthScale));
    }];
    
    UIView  *shareView = [[UIView alloc] init];
    shareView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    ViewRadius(shareView, 4);
    [self.mainScrollerView addSubview:shareView];
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.centerVipImage.mas_bottom);
        make.height.mas_offset(@(100*heightScale));
        make.width.mas_offset(@(ScreenW-30*heightScale));
        make.centerX.mas_equalTo(self.mainScrollerView.mas_centerX);
    }];
    if ([[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide) {
        shareView.hidden = YES;
    }else{
        shareView.hidden = NO;
    }
    NSArray  *shareArray = @[@"CSNewMineMakeCard",@"CSNewMineSale",@"CSNewMineInviald",@"CSNewMineSC",@"CSNewMineOrder"];
    NSArray  *shareTitleArray = @[csnation(@"打卡"),csnation(@"我的售后"),csnation(@"我的邀请"),csnation(@"我的收藏"),csnation(@"我的订单")];
    for (NSInteger i=0; i < 5; i ++) {
        UIButton  *button= [[UIButton alloc] init];
        button.tag = 100+i;
        [button addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:shareArray[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake((ScreenW-30*heightScale)/5 *i, 20*heightScale, (ScreenW-30*heightScale)/5, 36);
        [shareView addSubview:button];
        
        UILabel  *label= [[UILabel alloc] init];
        label.text = shareTitleArray[i];
        label.textColor = [UIColor colorWithHexString:@"#FEFEFE" alpha:0.5];
        label.font = kFont(12);
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake((ScreenW-30*heightScale)/5*i, 70*heightScale, (ScreenW-30*heightScale)/5, 12);
        [shareView addSubview:label];
        
    }
    NSArray  *setArray =[NSArray array];
    NSArray  *setTitleArray =[NSArray array];
    if ([[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide) {
        setArray= @[@"CSNewMineVersion",@"CSNewMineProctolPeople",@"CSNewMineProctolSelf",@"CSNewMineContentUs",@"CSNewMineSetting"];
        setTitleArray= @[csnation(@"版本信息"),csnation(@"用户协议"),csnation(@"隐私协议"),csnation(@"联系我们"),csnation(@"设置")];
    }else{
        setArray = @[@"CSNewMineVersion",@"CSNewMineProctolPeople",@"CSNewMineProctolSelf",@"CSNewMineContentUs",@"CSNewMineSetting",@"CSNewMineVersion",];
        setTitleArray = @[csnation(@"版本信息"),csnation(@"用户协议"),csnation(@"隐私协议"),csnation(@"联系我们"),csnation(@"设置"),csnation(@"直播")];
    }
    
    
    UIView  *setView = [[UIView alloc] init];
    setView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.06];
    ViewRadius(setView, 4);
    [self.mainScrollerView addSubview:setView];
    if ([[CSNewLoginUserInfoManager sharedManager] currentAppVersionInfo].ios_hide) {
        [setView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgImage.mas_bottom).offset(11*heightScale);
            make.height.mas_offset(@(275*heightScale));
            make.width.mas_offset(@(ScreenW-30*heightScale));
            make.centerX.mas_equalTo(self.mainScrollerView.mas_centerX);
        }];
    }else{
        [setView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(shareView.mas_bottom).offset(11*heightScale);
            make.height.mas_offset(@(330*heightScale));
            make.width.mas_offset(@(ScreenW-30*heightScale));
            make.centerX.mas_equalTo(self.mainScrollerView.mas_centerX);
        }];
    }
    
    
    
    for (NSInteger i=0; i<setArray.count; i++) {
        UIView  *bgView = [[UIView alloc] init];
        [bgView setTapActionWithBlock:^{
            
        }];
        bgView.backgroundColor = [UIColor clearColor];
        bgView.frame = CGRectMake(0, 55*heightScale *i, ScreenW-30*heightScale, 55*heightScale);
        [setView addSubview:bgView];
        
        UIImageView *leftImage = [[UIImageView alloc] init];
        leftImage.image = [UIImage imageNamed:setArray[i]];
        //leftImage.frame = CGRectMake(15*widthScale, 14*heightScale, 28*heightScale, 28*heightScale);
        [bgView addSubview:leftImage];
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bgView.mas_left).offset(15*heightScale);
            make.centerY.mas_equalTo(bgView.mas_centerY);
            make.width.height.mas_offset(@(28*heightScale));
        }];
        
        UILabel  *label= [[UILabel alloc] init];
        label.text = setTitleArray[i];
        label.textColor = [UIColor colorWithHexString:@"#FEFEFE" alpha:0.5];
        label.font = kFont(15);
        label.textAlignment = NSTextAlignmentLeft;
        //label.frame = CGRectMake((ScreenW-30*heightScale)/4*i, 48*heightScale, (ScreenW-30*heightScale)/4, 12);
        [bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(16*heightScale);
            make.centerY.mas_equalTo(leftImage.mas_centerY);
        }];
        
        UIView  *lineView= [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.1];
        //lineView.frame = CGRectMake(ScreenW/3*(i+1), heightScale *(110/2-20), 1, 40*heightScale);
        [bgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(16*heightScale);
            make.right.mas_equalTo(bgView.mas_right).offset(-16*heightScale);
            make.top.mas_equalTo(bgView.mas_bottom).offset(-1);
            make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
        }];
        
        UIButton  *butoon = [[UIButton alloc] init];
        butoon.tag = 200 +i;
        [butoon setImage:[UIImage imageNamed:@"CSNewMineBottomRight"] forState:UIControlStateNormal];
        [butoon addTarget:self action:@selector(listButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:butoon];
        [butoon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(leftImage.mas_centerY);
            make.right.mas_equalTo(bgView.mas_right).offset(-15*heightScale);
            make.width.height.mas_offset(@(20));
        }];
    }
    
    
    
}
-(void)selectButtonClick:(UIButton *)btn{
    switch (btn.tag) {
        case 100:
        {
            if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
                CSNewMinePunchViewController *vc = [[CSNewMinePunchViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                    
                }];
            }
        }
            break;
        case 101:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:csnation(@"提示") message:csnation(@"售后问题请联系客服") preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:csnation(@"确定") style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        case 102:
        {
            if ([[CSNewLoginUserInfoManager sharedManager] isLogin]) {
                CSNewMYshareViewController *vc = [[CSNewMYshareViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                    
                }];
            }
        }
            break;
        case 103:
        {
            [self.navigationController pushViewController:[CSNewMyCollectViewController new] animated:YES];
        }
            break;
        case 104:
        {
            [self.navigationController pushViewController:[CSNewMyOrderViewController new] animated:YES];
        }
            break;

            
            
        default:
            break;
    }
}

- (void)listButtonClick:(UIButton *)btn{
    switch (btn.tag) {
        case 200:
        {
            NSString *string = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@：%@",csnation(@"当前版本"),string] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:csnation(@"确定") style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        case 201:
        {
            NSString  *url = [NSString stringWithFormat:@"%@/wap/index/agreement?agree=agreement_user",[CSAPPConfigManager sharedConfig].baseURL];
            [[CSWebManager sharedManager] enterWebVCWithURL:url title:csnation(@"用户协议") withSupVC:[CSTotalTool getCurrentShowViewController]];
        }
            break;
        case 202:
        {
            NSString  *url = [NSString stringWithFormat:@"%@/wap/index/agreement?agree=agreement_conceal",[CSAPPConfigManager sharedConfig].baseURL];
            [[CSWebManager sharedManager] enterWebVCWithURL:url title:csnation(@"隐私协议") withSupVC:[CSTotalTool getCurrentShowViewController]];
        }
            break;
        case 203:
        {
            NSString  *url = [NSString stringWithFormat:@"%@/wap/index/agreement?agree=about_us",[CSAPPConfigManager sharedConfig].baseURL];
            [[CSWebManager sharedManager] enterWebVCWithURL:url title:csnation(@"联系我们") withSupVC:[CSTotalTool getCurrentShowViewController]];
        }
            break;
        case 204:
        {
            if([[CSNewLoginUserInfoManager sharedManager] isLogin]){
                [self.navigationController pushViewController:[CSNewSettingViewController new] animated:YES];
            }else{
                [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                    
                }];
            }
            
            
            //[[CSNewLoginUserInfoManager sharedManager] outLogin];
        }
            break;
        case 205:
        {
            if([[CSNewLoginUserInfoManager sharedManager] isLogin]){
                if ([self.currentUserInfo.is_live isEqualToString:@"1"]) {
                    CSNewMediaLiveViewController *mediaCaptureVC = [[CSNewMediaLiveViewController alloc] init];
                                                                    
                    mediaCaptureVC.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:mediaCaptureVC animated:YES completion:nil];
                }else{
                    [WHToast showMessage:csnation(@"该账号暂未开通直播") duration:1.0 finishHandler:nil];
                }
                
            }else{
                [[CSNewLoginUserInfoManager sharedManager] goToLogin:^(BOOL success) {
                    
                }];
            }

            
        }
            break;
            
        default:
            break;
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSuccess" object:self];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //在这里设置一下 不然滚动不了
    self.mainScrollerView.contentSize = CGSizeMake(ScreenW, heightScale *900);
    
}

@end
