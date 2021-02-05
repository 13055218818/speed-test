//
//  CSNewMinePunchViewController.m
//  ColorStar
//
//  Created by apple on 2021/1/6.
//  Copyright © 2021 gavin. All rights reserved.
//

#import "CSNewMinePunchViewController.h"
#import "CSNewMineModel.h"
#import "CSNewMineNetManage.h"
#import "CSNewPunchView.h"
#import "CSNewPunchListViewController.h"
@interface CSNewMinePunchViewController ()
@property(nonatomic, strong)UIView                      *navView;
@property(nonatomic, strong)UIImageView                 *bgView;
@property(nonatomic, strong)UIImageView                 *headBgView;
@property(nonatomic, strong)UIImageView                 *headView;
@property(nonatomic, strong)UILabel                     *nameLabel;
@property(nonatomic, strong)UILabel                     *nameBottomLabel;
@property(nonatomic, strong)UIView                      *centerView;
@property(nonatomic, strong)UIView                      *bottomView;
@property(nonatomic, strong)UIButton                    *thirdButton;
@property(nonatomic, strong)UIButton                    *sevenButton;
@property(nonatomic, strong)NSMutableArray              *actionList;
@property(nonatomic, strong)CSNewMinePunchModel         *currentModel;
@property(nonatomic, assign) BOOL  isMyselfSing;
@property(nonatomic, strong)CSNewPunchView              *punchView;
@end

@implementation CSNewMinePunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F5FF"];
    self.currentModel = [[CSNewMinePunchModel alloc] init];
    self.actionList = [NSMutableArray array];
    self.isMyselfSing =NO;
    CS_Weakify(self, weakSlef);
    [[CSNewMineNetManage sharedManager] getSiginInfoComplete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            NSDictionary *dict = response.data;
            CSNewMinePunchModel  *model = [CSNewMinePunchModel yy_modelWithDictionary:dict];
            weakSlef.currentModel = model;
            weakSlef.isMyselfSing = weakSlef.currentModel.is_sign;
            [weakSlef makeUI];
        }
    } failureComplete:^(NSError * _Nonnull error) {
            
        
    }];
    [self makeNavUI];

    
}
#pragma mark--UI--
-(void)makeNavUI{
    self.navView = [[UIView alloc] init];
    self.navView.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_offset(@(kStatusBarHeight + 44.0*heightScale));
    }];
    //
    UIButton  *backButton = [[UIButton alloc] init];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"CSNewShopListBack"] forState:UIControlStateNormal];
    [self.navView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navView);
        make.bottom.mas_equalTo(self.navView);
        make.width.mas_offset(@(55*heightScale));
        make.height.mas_offset(@(44*heightScale));
    }];
    UILabel  *titleLabel = [[UILabel alloc] init];
   // titleLabel.text = NSLocalizedString(@"我的订单",nil);
    titleLabel.font = kFont(18);
    titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navView.mas_centerX);
        make.centerY.mas_equalTo(backButton.mas_centerY);
    }];
    
}

- (void)makeUI{
    
    self.bgView = [[UIImageView alloc] init];
    self.bgView.image = [UIImage imageNamed:@"punchBg.png"];
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.height.mas_offset(@(220*heightScale));
    }];

    self.headBgView = [[UIImageView alloc] init];
    self.headBgView.image = [UIImage imageNamed:@"CS_home_recomendArtisheadRaiduImage.png"];
    [self.view addSubview:self.headBgView];
    [self.headBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(12*widthScale);
        make.top.mas_equalTo(self.bgView.mas_top).offset(32*heightScale);
        make.width.height.mas_offset(@(60*heightScale));
    }];
    self.headView = [[UIImageView alloc] init];
    ViewRadius(self.headView, 28*heightScale);
    [self.headView sd_setImageWithURL:[NSURL URLWithString:[CSNewLoginUserInfoManager sharedManager].userInfo.avatar] placeholderImage:nil];
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.headBgView);
        make.width.height.mas_offset(@(56*heightScale));
    }];
    CSNewLoginModel *currentUserInfo =[CSNewLoginUserInfoManager sharedManager].userInfo;
    NSString * headImage = currentUserInfo.avatar;
    if (![currentUserInfo.avatar hasPrefix:@"http"]) {
        headImage = [NSString stringWithFormat:@"%@%@",[CSAPPConfigManager sharedConfig].baseURL,currentUserInfo.avatar];
    }
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:[UIImage imageNamed:@"CSNewMyDefultImage.png"]];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text =[CSNewLoginUserInfoManager sharedManager].userInfo.nickname;
    self.nameLabel.font = kFont(16);
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headBgView.mas_right).offset(14);
        make.top.mas_equalTo(self.headBgView.mas_top).offset(7*heightScale);
    }];
    
    self.nameBottomLabel = [[UILabel alloc] init];
    self.nameBottomLabel.text =[NSString stringWithFormat:@"%@ %@ %@",csnation(@"明日签到可获取"),self.currentModel.coin,csnation(@"金币")];
    self.nameBottomLabel.font = kFont(12);
    self.nameBottomLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.nameBottomLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.nameBottomLabel];
    [self.nameBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headBgView.mas_right).offset(14);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5*heightScale);
    }];
    
    UILabel  *label1 = [[UILabel alloc] init];
    label1.text = csnation(@"打卡明细");
    label1.font = kFont(13);
    label1.textColor = [UIColor colorWithHexString:@"#D7B393"];
    label1.textAlignment = NSTextAlignmentLeft;
    [label1 setTapActionWithBlock:^{
        CSNewPunchListViewController *vc = [CSNewPunchListViewController new];
        
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
    }];
    [label1 layoutIfNeeded];
    UILabel  *label2 = [[UILabel alloc] init];
    ViewRadius(label2, 13*heightScale);
    ViewBorder(label2, [UIColor colorWithHexString:@"#D7B393"], 1);
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
        make.height.mas_offset(@(26*heightScale));
        make.centerX.mas_equalTo(label1.mas_centerX);
        make.width.mas_offset(@(30 + label1.width));
    }];
    
    self.centerView = [[UIView alloc] init];
    ViewRadius(self.centerView, 5);
    self.centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headBgView.mas_bottom).offset(32*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(12*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-12*widthScale);
        make.height.mas_offset(234*heightScale);
    }];
    
    UILabel  *label3 = [[UILabel alloc] init];
    label3.text = csnation(@"每日签到领好礼");
    label3.font = kFont(14);
    label3.textColor = [UIColor colorWithHexString:@"#202020"];
    [self.centerView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(46*heightScale));
        make.top.mas_equalTo(self.centerView.mas_top);
        make.left.mas_equalTo(self.centerView.mas_left).offset(12*widthScale);
    }];
    
    UIImageView  *goldImage = [[UIImageView alloc] init];
    goldImage.image = [UIImage imageNamed:@"punchGold.png"];
    [self.centerView addSubview:goldImage];
    [goldImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label3);
        make.left.mas_equalTo(label3.mas_right).offset(5);
        make.width.height.mas_offset(@(22*widthScale));
    }];
    
    CGFloat  bagWidth = (ScreenW-2*12*widthScale-2*20*widthScale-3*12*widthScale)/4;
    CGFloat  bagHeight = (234*heightScale-46*heightScale-28*heightScale)/2;
    NSArray  *dayTitleArray = @[csnation(@"第一天"),csnation(@"第二天"),csnation(@"第三天"),csnation(@"第四天"),csnation(@"第五天"),csnation(@"第六天"),csnation(@"第七天")];
    for (NSInteger i =0; i<7; i++) {
        UIView *view = [[UIView alloc] init];
        ViewRadius(view, 3);
//        view.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
        [self.centerView addSubview:view];
        UILabel  *titleLabel = [[UILabel alloc] init];
        titleLabel.text = dayTitleArray[i];
        titleLabel.font = kFont(11);
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(view);
            make.top.mas_equalTo(view.mas_top).offset(8);
        }];
        
        UIImageView  *goldImage = [[UIImageView alloc] init];
        goldImage.image = [UIImage imageNamed:@"punchGold.png"];
        [view addSubview:goldImage];
        [goldImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view.centerX);
            make.centerY.mas_equalTo(view.centerY);
            make.width.height.mas_offset(@(22*widthScale));
        }];
        UILabel  *bottomLabel = [[UILabel alloc] init];
        bottomLabel.text = self.currentModel.coin;
        bottomLabel.font = kFont(10);
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:bottomLabel];
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(view);
            make.bottom.mas_equalTo(view.mas_bottom).offset(-8);
        }];
        
        if (i == 6) {
            view.frame = CGRectMake(20*widthScale +i%4 *(12*widthScale + bagWidth), 46*heightScale +i/4 * (10*heightScale + bagHeight), 2*bagWidth + 12*widthScale, bagHeight);
        }else{
            view.frame = CGRectMake(20*widthScale +i%4 *(12*widthScale + bagWidth), 46*heightScale +i/4 * (10*heightScale + bagHeight), bagWidth, bagHeight);
        }
        
        if (self.currentModel.is_sign) {
            if ((i -[self.currentModel.days intValue]) > 0) {
                view.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
                titleLabel.textColor = [UIColor colorWithHexString:@"#202020"];
                bottomLabel.textColor = [UIColor colorWithHexString:@"#B6B6B6"];
                
            }else{
                view.backgroundColor = [UIColor redColor];
                titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                bottomLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                bottomLabel.text = csnation(@"已领取");
            }
        }else{
            if (i <[self.currentModel.days intValue] ) {
                view.backgroundColor = [UIColor redColor];
                titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                bottomLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                bottomLabel.text = csnation(@"已领取");
            }else{
                if (i == [self.currentModel.days intValue] ) {
                    view.backgroundColor = [UIColor redColor];
                    titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                    bottomLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
                        [view setTapActionWithBlock:^{
                            if (!self.isMyselfSing) {
                                [[CSNewMineNetManage sharedManager] getSiginComplete:^(CSNetResponseModel * _Nonnull response) {
                                    if (response.code == 200) {
                                        NSDictionary *dict = response.data;
                                        NSInteger  count = [dict[@"coin"] intValue];
                                        self.isMyselfSing = YES;
                                        bottomLabel.text = csnation(@"已领取");
                                        self.punchView = [[CSNewPunchView alloc]init];
                                        [self.punchView getMaskConfig].tapToDismiss = YES;
                                        self.punchView.count = count;
                                        [self.punchView show];
                                        NSLog(@"签到qqqqqqqqqqq");
                                    }
                                } failureComplete:^(NSError * _Nonnull error) {
                                    
                                }];
                            
                            }
                        }];
                    
                }else{
                    view.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
                    titleLabel.textColor = [UIColor colorWithHexString:@"#202020"];
                    bottomLabel.textColor = [UIColor colorWithHexString:@"#B6B6B6"];
                    
                }
                
            }
        }
        
    }
    
    self.bottomView = [[UIView alloc] init];
    ViewRadius(self.centerView, 5);
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.centerView.mas_bottom).offset(12*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(12*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-12*widthScale);
        make.height.mas_offset(200*heightScale);
    }];
    
    UILabel  *label4 = [[UILabel alloc] init];
    label4.text = csnation(@"累计天数赚取金币");
    label4.font = kFont(14);
    label4.textColor = [UIColor colorWithHexString:@"#202020"];
    [self.bottomView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(@(46*heightScale));
        make.top.mas_equalTo(self.bottomView.mas_top);
        make.left.mas_equalTo(self.bottomView.mas_left).offset(12*widthScale);
    }];
    
    UIImageView  *bottomFirstLeftImage = [[UIImageView alloc] init];
    bottomFirstLeftImage.image = [UIImage imageNamed:@"punchDateBg.png"];
    [self.bottomView addSubview:bottomFirstLeftImage];
    [bottomFirstLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label4);
        make.top.mas_equalTo(label4.mas_bottom).offset(10*heightScale);
        make.width.height.mas_offset(@(27*heightScale));
    }];
    
    UILabel  *bottomFirstLeftLabel = [[UILabel alloc] init];
    bottomFirstLeftLabel.text = @"3";
    bottomFirstLeftLabel.font = kFont(14);
    bottomFirstLeftLabel.textColor = [UIColor colorWithHexString:@"#3BAAFF"];
    bottomFirstLeftLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:bottomFirstLeftLabel];
    [bottomFirstLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label4);
        make.top.mas_equalTo(label4.mas_bottom).offset(14*heightScale);
        make.width.height.mas_offset(@(27*heightScale));
    }];
    
    UILabel  *bottomFirstTopLabel = [[UILabel alloc] init];
    bottomFirstTopLabel.text = csnation(@"累计签到3天");
    bottomFirstTopLabel.font = kFont(14);
    bottomFirstTopLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    bottomFirstTopLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomView addSubview:bottomFirstTopLabel];
    [bottomFirstTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomFirstLeftImage.mas_right).offset(7);
        make.top.mas_equalTo(bottomFirstLeftImage.mas_top);
    }];
    
    UIImageView  *bottomSecondLeftImage = [[UIImageView alloc] init];
    bottomSecondLeftImage.image = [UIImage imageNamed:@"punchDateBg.png"];
    [self.bottomView addSubview:bottomSecondLeftImage];
    [bottomSecondLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label4);
        make.top.mas_equalTo(bottomFirstLeftImage.mas_bottom).offset(30*heightScale);
        make.width.height.mas_offset(@(27*heightScale));
    }];
    
    UILabel  *bottomSecondLeftLabel = [[UILabel alloc] init];
    bottomSecondLeftLabel.text = @"7";
    bottomSecondLeftLabel.font = kFont(14);
    bottomSecondLeftLabel.textColor = [UIColor colorWithHexString:@"#3BAAFF"];
    bottomSecondLeftLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:bottomSecondLeftLabel];
    [bottomSecondLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label4);
        make.top.mas_equalTo(bottomFirstLeftImage.mas_bottom).offset(34*heightScale);
        make.width.height.mas_offset(@(27*heightScale));
    }];
    UILabel  *bottomSecondTopLabel = [[UILabel alloc] init];
    bottomSecondTopLabel.text = csnation(@"累计签到7天");
    bottomSecondTopLabel.font = kFont(14);
    bottomSecondTopLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    bottomSecondTopLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomView addSubview:bottomSecondTopLabel];
    [bottomSecondTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomSecondLeftImage.mas_right).offset(7);
        make.top.mas_equalTo(bottomSecondLeftImage.mas_top);
    }];
    
    UILabel  *bottomSecondBottomLabel = [[UILabel alloc] init];
    bottomSecondBottomLabel.hidden = YES;
    bottomSecondBottomLabel.text = csnation(@"连续签到7天会领取额外奖励");
    bottomSecondBottomLabel.font = kFont(12);
    bottomSecondBottomLabel.textColor = [UIColor colorWithHexString:@"#B6B6B6"];
    bottomSecondBottomLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomView addSubview:bottomSecondBottomLabel];
    [bottomSecondBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomSecondLeftImage.mas_right).offset(7);
        make.bottom.mas_equalTo(bottomSecondLeftImage.mas_bottom);
    }];
    
    
    self.thirdButton = [[UIButton alloc] init];
    ViewRadius(self.thirdButton, 13*heightScale);
    NSDictionary *dict1 = self.currentModel.sign_config[0];
    CSNewMinePunchSign_configModel *model1 = [CSNewMinePunchSign_configModel yy_modelWithDictionary:dict1];
    if ([model1.is_reward isEqualToString:@"1"]) {
        [self.thirdButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [self.thirdButton setBackgroundColor:[UIColor colorWithHexString:@"#EBEBEB"]];
        [self.thirdButton setTitle:csnation(@"已领取") forState:UIControlStateNormal];
    }else{
        [self.thirdButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [self.thirdButton setBackgroundColor:[UIColor colorWithHexString:@"#FF5D5B"]];
    }
    self.thirdButton.titleLabel.font = kFont(14);
    
    [self.thirdButton setImage:[UIImage imageNamed:@"punchGold.png"] forState:UIControlStateNormal];
   
    [self.thirdButton setTitle:[NSString stringWithFormat:@"+%@",model1.coin] forState:UIControlStateNormal];
    [self.bottomView addSubview:self.thirdButton];
    
    [self.thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomView.mas_right).offset(-14);
        make.centerY.mas_equalTo(bottomFirstLeftImage.mas_centerY);
        make.width.mas_offset(@(66*widthScale));
        make.height.mas_offset(@(26*heightScale));
    }];
    
    
    self.sevenButton = [[UIButton alloc] init];
    ViewRadius(self.sevenButton, 13*heightScale);
    NSDictionary *dict2 = self.currentModel.sign_config[1];
    CSNewMinePunchSign_configModel *model2 = [CSNewMinePunchSign_configModel yy_modelWithDictionary:dict2];
    if ([model2.is_reward isEqualToString:@"1"]) {
        [self.sevenButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [self.sevenButton setBackgroundColor:[UIColor colorWithHexString:@"#EBEBEB"]];
        [self.sevenButton setTitle:csnation(@"已领取") forState:UIControlStateNormal];
    }else{
        [self.sevenButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [self.sevenButton setBackgroundColor:[UIColor colorWithHexString:@"#FF5D5B"]];
        [self.sevenButton setTitle:[NSString stringWithFormat:@"+%@",model2.coin] forState:UIControlStateNormal];
    }
    self.sevenButton.titleLabel.font = kFont(14);
    [self.sevenButton setImage:[UIImage imageNamed:@"punchGold.png"] forState:UIControlStateNormal];
    [self.bottomView addSubview:self.sevenButton];
    
    [self.sevenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomView.mas_right).offset(-14);
        make.centerY.mas_equalTo(bottomSecondLeftImage.mas_centerY);
        make.width.mas_offset(@(66*widthScale));
        make.height.mas_offset(@(26*heightScale));
    }];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
