//
//  CSNewSettingViewController.m
//  ColorStar
//
//  Created by apple on 2020/12/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewSettingViewController.h"

@interface CSNewSettingViewController ()
@property(nonatomic, strong)UIView                      *navView;
@property(nonatomic, strong)UILabel                     *outLabel;
@end

@implementation CSNewSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
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
    titleLabel.text = NSLocalizedString(@"设置",nil);
    titleLabel.font = kFont(18);
    titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navView.mas_centerX);
        make.centerY.mas_equalTo(backButton.mas_centerY);
    }];
    
    self.outLabel = [[UILabel alloc] init];
    [self.outLabel setTapActionWithBlock:^{
        [[CSNewLoginUserInfoManager sharedManager] outLogin];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.outLabel.text = NSLocalizedString(@"退出登陆",nil);
    self.outLabel.font = kFont(18);
    ViewRadius(self.outLabel, 20*heightScale);
    self.outLabel.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.outLabel.textColor = [UIColor blackColor];
    self.outLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.outLabel];
    [self.outLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(50*widthScale);
        make.left.mas_equalTo(self.view.mas_left).offset(50*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-50*widthScale);
        make.height.mas_offset(@(40*heightScale));
    }];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
