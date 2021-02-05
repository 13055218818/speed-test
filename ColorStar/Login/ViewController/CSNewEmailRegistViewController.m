//
//  CSNewEmailRegistViewController.m
//  ColorStar
//
//  Created by apple on 2020/12/14.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewEmailRegistViewController.h"
#import "CSMeVerifyButton.h"
#import "NSString+CS.h"
@interface CSNewEmailRegistViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UIButton               *backButton;
@property (nonatomic, strong)UILabel                *titleLabel;
@property (nonatomic, strong)UIButton               *registerSendButton;
@property (nonatomic, strong)UIButton               *sendButton;

@property (nonatomic, strong)YYLabel                *agressLabel;
@property (nonatomic, strong)UIButton               *emailImage;
@property (nonatomic, strong)UITextField            *emailTextField;
@property (nonatomic, strong)UIView                  *emailLineCode;

@property (nonatomic, strong)UIButton               *pwsImage;
@property (nonatomic, strong)UITextField            *pwsTextField;
@property (nonatomic, strong)UIView                  *pwsLineCode;

@property (nonatomic, strong)UIButton               *verifyImage;
@property (nonatomic, strong)UITextField            *verifyTextField;
@property (nonatomic, strong)UIView                  *verfiyLineCode;
@end

@implementation CSNewEmailRegistViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
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
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(45*widthScale);
        make.top.mas_equalTo(self.backButton.mas_bottom).offset(79*heightScale);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    self.emailImage = [[UIButton alloc] init];
    [self.emailImage setImage:[UIImage imageNamed:@"csEnglishEmailIcon.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.emailImage ];
    [self.emailImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(46*heightScale);
        make.height.width.mas_offset(@(42*heightScale));
    }];
    
    self.emailTextField = [[UITextField alloc] init];
    self.emailTextField.delegate = self;
    self.emailTextField.font = kFont(14);
    self.emailTextField.placeholder = @"E-mail";
    self.emailTextField.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    NSAttributedString *attrStringCode = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8A8A8A"],NSFontAttributeName:kFont(14)}];
    self.emailTextField.attributedPlaceholder = attrStringCode;
    self.emailTextField.borderStyle = UITextBorderStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.emailTextField];
    [self.view addSubview:self.emailTextField];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.emailImage.mas_right).offset(6);
        make.centerY.mas_equalTo(self.emailImage.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(42*heightScale));
    }];
    
    self.emailLineCode = [[UIView alloc] init];
    self.emailLineCode.backgroundColor = [UIColor colorWithHexString:@"#646870" alpha:0.5];
    [self.view addSubview:self.emailLineCode];
    [self.emailLineCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.top.mas_equalTo(self.emailTextField.mas_bottom).offset(1*heightScale);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    
    self.verifyImage = [[UIButton alloc] init];
    [self.verifyImage setImage:[UIImage imageNamed:@"csEnglishVerifyIcon.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.verifyImage ];
    [self.verifyImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.emailLineCode.mas_bottom).offset(5*heightScale);
        make.height.width.mas_offset(@(42*heightScale));
    }];
    
    self.verifyTextField = [[UITextField alloc] init];
    self.verifyTextField.delegate = self;
    self.verifyTextField.font = kFont(14);
    self.verifyTextField.placeholder = @"Verify";
    self.verifyTextField.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    NSAttributedString *verifyStringCode = [[NSAttributedString alloc] initWithString:@"Verfiy" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8A8A8A"],NSFontAttributeName:kFont(14)}];
    self.verifyTextField.attributedPlaceholder = verifyStringCode;
    self.verifyTextField.borderStyle = UITextBorderStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.verifyTextField];
    [self.view addSubview:self.verifyTextField];
    [self.verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.verifyImage.mas_right).offset(6);
        make.centerY.mas_equalTo(self.verifyImage.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(42*heightScale));
    }];
    
    self.verfiyLineCode = [[UIView alloc] init];
    self.verfiyLineCode.backgroundColor = [UIColor colorWithHexString:@"#646870" alpha:0.5];
    [self.view addSubview:self.verfiyLineCode];
    [self.verfiyLineCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.top.mas_equalTo(self.verifyTextField.mas_bottom).offset(1*heightScale);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    
    self.pwsImage = [[UIButton alloc] init];
    [self.pwsImage setImage:[UIImage imageNamed:@"csEnglishPwsIcon.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.pwsImage ];
    [self.pwsImage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.verfiyLineCode.mas_bottom).offset(5*heightScale);
        make.height.width.mas_offset(@(42*heightScale));
    }];
    
    self.pwsTextField = [[UITextField alloc] init];
    self.pwsTextField.delegate = self;
    self.pwsTextField.font = kFont(14);
    self.pwsTextField.placeholder = @"Password";
    self.pwsTextField.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    NSAttributedString *pwsStringCode = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8A8A8A"],NSFontAttributeName:kFont(14)}];
    self.pwsTextField.attributedPlaceholder = pwsStringCode;
    self.pwsTextField.borderStyle = UITextBorderStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.pwsTextField];
    [self.view addSubview:self.pwsTextField];
    [self.pwsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pwsImage.mas_right).offset(6);
        make.centerY.mas_equalTo(self.pwsImage.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(42*heightScale));
    }];
    
    self.pwsLineCode = [[UIView alloc] init];
    self.pwsLineCode.backgroundColor = [UIColor colorWithHexString:@"#646870" alpha:0.5];
    [self.view addSubview:self.pwsLineCode];
    [self.pwsLineCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.top.mas_equalTo(self.pwsTextField.mas_bottom).offset(1*heightScale);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    
    self.registerSendButton = [[UIButton alloc] init];
    self.registerSendButton.enabled = NO;
    [self.registerSendButton addTarget:self action:@selector(registerSendButton:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.registerSendButton, 5);
    self.registerSendButton.titleLabel.font = kFont(14);
    [self.registerSendButton setTitle:@"continue" forState:UIControlStateNormal];
    [self.registerSendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
    [self.registerSendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
    [self.view addSubview:self.registerSendButton];
    [self.registerSendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwsLineCode.mas_bottom).offset(25*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(45*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(44*heightScale));
    }];

    self.sendButton = [[UIButton alloc] init];
    self.sendButton.enabled = NO;
    [self.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.sendButton, 5);
    self.sendButton.titleLabel.font = kFont(14);
    [self.sendButton setTitle:@"continue" forState:UIControlStateNormal];
    [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
    [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwsLineCode.mas_bottom).offset(25*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(45*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(44*heightScale));
    }];
    
    self.agressLabel= [[YYLabel alloc] init];
    self.agressLabel.frame = CGRectMake(0, 200, ScreenW, 100);
    [self.view addSubview:self.agressLabel];
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"By tapping “Continue”，you agree to our Terms of Service and Privacy Policy"];
    text.yy_lineSpacing = 5;
    text.yy_font = kFont(14);
    text.yy_color = [UIColor colorWithHexString:@"#8A8A8A"];
    __weak typeof(self) weakself = self;
    [text yy_setTextHighlightRange:NSMakeRange(39, 16) color:[UIColor colorWithHexString:@"#00FEFF"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"xxx协议被点击了");
        //           if (weakself.agProtocolAction) {
        //               weakself.agProtocolAction();
        //           }
    }];
    [text yy_setTextHighlightRange:NSMakeRange(60, 14) color:[UIColor colorWithHexString:@"#00FEFF"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"xxx协议被点击了");
        //           if (weakself.agProtocolAction) {
        //               weakself.agProtocolAction();
        //           }
    }];
    self.agressLabel.numberOfLines = 0;
    self.agressLabel.preferredMaxLayoutWidth = ScreenW - 80*widthScale;
    self.agressLabel.attributedText = text;
    
    
    [self.agressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(38*heightScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-38*widthScale);
        make.top.mas_equalTo(self.sendButton.mas_bottom).mas_equalTo(80*heightScale);
    }];
    
    
    if ([self.type isEqualToString:@"0"]) {
        self.titleLabel.text = @"Sign Up";
        self.verifyImage.hidden = YES;
        self.verifyTextField.hidden = YES;
        self.verfiyLineCode.hidden = YES;
        self.pwsImage.hidden = YES;
        self.pwsLineCode.hidden = YES;
        self.pwsTextField.hidden = YES;
        self.registerSendButton.hidden = NO;
        self.sendButton.hidden = YES;
    }else{
        self.titleLabel.text = @"Sign In";
        self.verifyImage.hidden = YES;
        self.verifyTextField.hidden = YES;
        self.verfiyLineCode.hidden = YES;
        self.pwsImage.hidden = NO;
        self.pwsLineCode.hidden = NO;
        self.pwsTextField.hidden = NO;
        self.registerSendButton.hidden = YES;
        self.sendButton.hidden = NO;
        [self.pwsImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.top.mas_equalTo(self.emailLineCode.mas_bottom).offset(5*heightScale);
            make.height.width.mas_offset(@(42*heightScale));
        }];

    }

}
- (void)registerSendButton:(UIButton *)btn{
    [[CSNewLoginNetManager sharedManager] getsendEmailCode:self.emailTextField.text Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            self.registerSendButton.hidden = YES;
            self.sendButton.hidden = NO;
            self.verifyImage.hidden = NO;
            self.verifyTextField.hidden = NO;
            self.verfiyLineCode.hidden = NO;
            self.pwsImage.hidden = NO;
            self.pwsLineCode.hidden = NO;
            self.pwsTextField.hidden = NO;
            self.registerSendButton.hidden = YES;
            self.sendButton.hidden = NO;
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
        
    }];

}

- (void)sendButtonClick:(UIButton *)btn{
    NSString *verfiy;
    if ([self.type isEqualToString:@"0"]) {
        verfiy = self.verifyTextField.text;
    }else{
        verfiy = @"";
    }
    [[CSNewLoginNetManager sharedManager] getEmailLoginWithEmail:self.emailTextField.text WithVerify:verfiy Withpws:self.pwsTextField.text Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            NSDictionary  *dict = response.data;
            NSString  *token = dict[@"token"];
            [[CSAPPConfigManager sharedConfig] storeSessionKey:token];
            if (self.EmailRegistBlock) {
                self.EmailRegistBlock(YES);
            };
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
            if (self.EmailRegistBlock) {
                self.EmailRegistBlock(NO);
            };
        }
    } failureComplete:^(NSError * _Nonnull error) {
        if (self.EmailRegistBlock) {
            self.EmailRegistBlock(NO);
        };
    }];
}
#pragma mark - NSNotification
- (void)textFieldDidChanged:(NSNotification*)notification{
    UITextField * textField = notification.object;
    if ([self.type isEqualToString:@"0"]) {
        if (self.registerSendButton.hidden == YES) {
            if ([NSString cs_isEmail:self.emailTextField.text] && self.emailTextField.text.length > 0 && self.pwsTextField.text.length > 0 && self.verifyTextField.text.length > 0) {
                self.sendButton.enabled = YES;
                [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
                [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#3B3B3B"] forState:UIControlStateNormal];
            }else{
                self.sendButton.enabled = NO;
                [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
                [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
            }
        }else{
            if ([NSString cs_isEmail:self.emailTextField.text] && self.emailTextField.text.length > 0 ) {
                self.registerSendButton.enabled = YES;
                [self.registerSendButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
                [self.registerSendButton setTitleColor:[UIColor colorWithHexString:@"#3B3B3B"] forState:UIControlStateNormal];
            }else{
                self.registerSendButton.enabled = NO;
                [self.registerSendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
                [self.registerSendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
            }
        }


    }else{
        if ([NSString cs_isEmail:self.emailTextField.text] && self.emailTextField.text.length > 0 && self.pwsTextField.text.length > 0) {
            self.sendButton.enabled = YES;
            [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
            [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#3B3B3B"] forState:UIControlStateNormal];
        }else{
            self.sendButton.enabled = NO;
            [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
            [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
        }
    }
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
