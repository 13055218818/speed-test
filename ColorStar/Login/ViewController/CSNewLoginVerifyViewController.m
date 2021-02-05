//
//  CSNewLoginVerifyViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewLoginVerifyViewController.h"
#import "CSMeVerifyButton.h"
@interface CSNewLoginVerifyViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UIButton               *backButton;
@property (nonatomic, strong)UILabel                *titleLabel;
@property (nonatomic, strong)UIButton               *sendButton;
@property (nonatomic, strong)UIButton               *checkButton;
@property (nonatomic, strong)YYLabel                *agressLabel;
@property (nonatomic, strong)UITextField           *verifyCodeNum;
@property (nonatomic, strong)CSMeVerifyButton       *verifyButton;

@end

@implementation CSNewLoginVerifyViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[CSNewLoginNetManager sharedManager] getSendPhoneCodeWithPhone:self.phoneStr Withprefix:self.prefixStr Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code==200) {
            [self.verifyButton timeFailBeginFrom:60];
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self makeUI];
}

- (void)makeUI{
    self.backButton = [[UIButton alloc] init];
    [self.backButton setImage:[UIImage imageNamed:@"CSNewShopListBack.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(12*widthScale);
        make.top.mas_equalTo(self.view.mas_top).offset(24*heightScale +kStatusBarHeight);
        make.width.height.mas_offset(@(26*widthScale));
    }];
    
    
    self.titleLabel= [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = @"输入验证码";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(45*widthScale);
        make.top.mas_equalTo(self.backButton.mas_bottom).offset(79*heightScale);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    
    UILabel  *detialLabelPhoneNum = [[UILabel alloc] init];
    detialLabelPhoneNum.numberOfLines = 0;
    detialLabelPhoneNum.text = [NSString stringWithFormat:@"%@+%@ %@",NSLocalizedString(@"短信验证码已发送至",nil),self.prefixStr,self.phoneStr];
    detialLabelPhoneNum.font = [UIFont boldSystemFontOfSize:10];
    detialLabelPhoneNum.textColor = [UIColor colorWithHexString:@"#ACACAC"];
    detialLabelPhoneNum.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:detialLabelPhoneNum];
    [detialLabelPhoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(6*heightScale);
    }];
    
    
    
    
    self.verifyCodeNum = [[UITextField alloc] init];
    self.verifyCodeNum.delegate = self;
    self.verifyCodeNum.font = kFont(14);
    self.verifyCodeNum.placeholder = @"验证码";
    self.verifyCodeNum.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.verifyCodeNum.keyboardType = UIKeyboardTypeNumberPad;
    NSAttributedString *attrStringCode = [[NSAttributedString alloc] initWithString:@"验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8A8A8A"],NSFontAttributeName:kFont(14)}];
    self.verifyCodeNum.attributedPlaceholder = attrStringCode;
    self.verifyCodeNum.borderStyle = UITextBorderStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.verifyCodeNum];
    [self.view addSubview:self.verifyCodeNum];
    [self.verifyCodeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(detialLabelPhoneNum.mas_bottom).offset(56*heightScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-120*widthScale);
        make.height.mas_offset(@(42*heightScale));
    }];
    
    UIView  *centerLineCode = [[UIView alloc] init];
    centerLineCode.backgroundColor = [UIColor colorWithHexString:@"#646870" alpha:0.06];
    [self.view addSubview:centerLineCode];
    [centerLineCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.top.mas_equalTo(self.verifyCodeNum.mas_bottom).offset(1*heightScale);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    
    
    
    
    self.verifyButton = [[CSMeVerifyButton alloc] init];
    self.verifyButton.state =CSMeVerifyButtonStateDisNormal;
    //[self.verifyButton timeFailBeginFrom:60];
    [self.verifyButton addTarget:self action:@selector(vertifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.verifyButton];
    [self.verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(centerLineCode.mas_right);
        make.centerY.mas_equalTo(self.verifyCodeNum.mas_centerY);
        make.width.mas_offset(@(60*widthScale));
        make.height.mas_offset(@(21*heightScale));
    }];
    
    
    
    
    self.sendButton = [[UIButton alloc] init];
    self.sendButton.enabled = NO;
    [self.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.sendButton, 5);
    self.sendButton.titleLabel.font = kFont(14);
    [self.sendButton setTitle:@"验证" forState:UIControlStateNormal];
    [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
    [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(centerLineCode.mas_bottom).offset(25*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(45*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(44*heightScale));
    }];
    
    UILabel  *detialLabelVerify = [[UILabel alloc] init];
    detialLabelVerify.numberOfLines = 0;
    detialLabelVerify.text = @"没有收到验证码？倒计时结束后可以重新获取";
    detialLabelVerify.font = [UIFont boldSystemFontOfSize:10];
    detialLabelVerify.textColor = [UIColor colorWithHexString:@"#ACACAC"];
    detialLabelVerify.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detialLabelVerify];
    [detialLabelVerify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.sendButton.mas_bottom).offset(12*heightScale);
    }];
    
    self.checkButton = [[UIButton alloc] init];
    [self.checkButton setImage:[UIImage imageNamed:@"CSLoginAgreeUnSelect.png"] forState:UIControlStateNormal];
    [self.checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkButton];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sendButton.mas_bottom).offset(190*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(42*widthScale);
        make.height.width.mas_offset(@(15*heightScale));
    }];
    
    self.agressLabel= [[YYLabel alloc] init];
    self.agressLabel.frame = CGRectMake(0, 200, ScreenW, 100);
    [self.view addSubview:self.agressLabel];
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"我已经阅读并且同意彩色星球的《用户协议》与《隐私政策》"];
    text.yy_lineSpacing = 5;
    text.yy_font = kFont(10);
    text.yy_color = [UIColor colorWithHexString:@"#8A8A8A"];
    __weak typeof(self) weakself = self;
    [text yy_setTextHighlightRange:NSMakeRange(14, 6) color:[UIColor colorWithHexString:@"#00FEFF"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSString  *url = [NSString stringWithFormat:@"%@/wap/index/agreement?agree=agreement_user",[CSAPPConfigManager sharedConfig].baseURL];
        [[CSWebManager sharedManager] enterLoginProtoclWebVCWithURL:url title:csnation(@"用户协议") withSupVC:[CSTotalTool getCurrentShowViewController]];
    }];
    [text yy_setTextHighlightRange:NSMakeRange(21, 6) color:[UIColor colorWithHexString:@"#00FEFF"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSString  *url = [NSString stringWithFormat:@"%@/wap/index/agreement?agree=agreement_conceal",[CSAPPConfigManager sharedConfig].baseURL];
        [[CSWebManager sharedManager] enterLoginProtoclWebVCWithURL:url title:csnation(@"隐私协议") withSupVC:[CSTotalTool getCurrentShowViewController]];
    }];
    self.agressLabel.numberOfLines = 0;
    self.agressLabel.preferredMaxLayoutWidth = ScreenW - 80*widthScale;
    self.agressLabel.attributedText = text;
    
    [self.agressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.checkButton.mas_right);
        make.centerY.mas_equalTo(self.checkButton.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-20*widthScale);
    }];
    
    
    
}
- (void)vertifyBtnClick:(UIButton*)sender{
        if (self.verifyButton.state == CSMeVerifyButtonStateNormal) {
           self.verifyButton.state =CSMeVerifyButtonStateDisNormal;
    [[CSNewLoginNetManager sharedManager] getSendPhoneCodeWithPhone:self.phoneStr Withprefix:self.prefixStr Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code==200) {
            [self.verifyButton timeFailBeginFrom:60];
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];
    
        }
}
- (void)checkButtonClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.checkButton setImage:[UIImage imageNamed:@"CSLoginAgreeSelect.png"] forState:UIControlStateNormal];
    }else{
        [self.checkButton setImage:[UIImage imageNamed:@"CSLoginAgreeUnSelect.png"] forState:UIControlStateNormal];
    }
}

- (void)sendButtonClick:(UIButton *)btn{
    if (self.checkButton.isSelected == YES) {
        [[CSNewLoginNetManager sharedManager] getLoginWithPhone:self.phoneStr withCode:self.verifyCodeNum.text Complete:^(CSNetResponseModel * _Nonnull response) {
            if (response.code == 200) {
                NSDictionary *dict = response.data;
                NSString *token = dict[@"token"];
                [[CSAPPConfigManager sharedConfig] storeSessionKey:token];
                if (self.LoginVerifyBlock) {
                    self.LoginVerifyBlock(YES);
                }
                [[CSNewLoginNetManager sharedManager] getUserInfoWithTokenComplete:^(CSNetResponseModel * _Nonnull response) {
                    if (response.code == 200) {
                        NSDictionary  *dict = response.data;
                        CSNewLoginModel *model= [CSNewLoginModel yy_modelWithDictionary:dict];
                        [CSNewLoginUserInfoManager sharedManager].userInfo = model;
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
                        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }

                    
                } failureComplete:^(NSError * _Nonnull error) {
                    
                }];
                
            }else{
                [WHToast showMessage:response.msg duration:1.0 finishHandler:nil];
                if (self.LoginVerifyBlock) {
                    self.LoginVerifyBlock(NO);
                }
            }
            
        } failureComplete:^(NSError * _Nonnull error) {
            if (self.LoginVerifyBlock) {
                self.LoginVerifyBlock(NO);
            }
        }];
    }else{
        [WHToast showMessage:csnation(@"请勾选同意用户协议") duration:1.0 finishHandler:nil];
    }


    
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NSNotification
- (void)textFieldDidChanged:(NSNotification*)notification{
    UITextField * textField = notification.object;
    if (self.verifyCodeNum.text.length > 0) {
        self.sendButton.enabled = YES;
        [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#3B3B3B"] forState:UIControlStateNormal];
    }else{
        self.sendButton.enabled = NO;
        [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
        [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
    }
    
}

@end
