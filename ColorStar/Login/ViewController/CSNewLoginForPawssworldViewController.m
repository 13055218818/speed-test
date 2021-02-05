//
//  CSNewLoginForPawssworldViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/18.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewLoginForPawssworldViewController.h"
#import "CSNewResetPasswordsViewController.h"
@interface CSNewLoginForPawssworldViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UIButton               *backButton;
@property (nonatomic, strong)UIButton               *deleteButton;
@property (nonatomic, strong)UIButton               *seeButton;
@property (nonatomic, strong)UITextField           *passworldNum;
@property (nonatomic, strong)UITextField           *phoneaNum;
@property (nonatomic, strong)UILabel               *titleLabel;
@property (nonatomic, strong)UILabel               *errorLabel;
@property (nonatomic, strong)UILabel               *forgetLabel;
@property (nonatomic, strong)UIButton               *sendButton;
@property (nonatomic, strong)UIButton               *checkButton;
@property (nonatomic, strong)YYLabel                *agressLabel;
@end

@implementation CSNewLoginForPawssworldViewController
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
    self.titleLabel.text = @"密码登陆";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(45*widthScale);
        make.top.mas_equalTo(self.backButton.mas_bottom).offset(79*heightScale);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    
    self.phoneaNum = [[UITextField alloc] init];
    self.phoneaNum.delegate = self;
    self.phoneaNum.font = kFont(14);
    self.phoneaNum.placeholder = @"手机号";
    self.phoneaNum.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.phoneaNum.keyboardType = UIKeyboardTypeNumberPad;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8A8A8A"],NSFontAttributeName:kFont(14)}];
   self.phoneaNum.attributedPlaceholder = attrString;
    self.phoneaNum.borderStyle = UITextBorderStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.phoneaNum];
    [self.view addSubview:self.phoneaNum];
    [self.phoneaNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(58*heightScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(42*heightScale));
    }];
    
    self.deleteButton = [[UIButton alloc] init];
    self.deleteButton.hidden = YES;
    [self.deleteButton setImage:[UIImage imageNamed:@"CSNewLoginViewPhoneDelete.png"] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteButton];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneaNum.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.width.mas_offset(@(16*heightScale));
    }];

    
    UIView  *centerLine1 = [[UIView alloc] init];
    centerLine1.backgroundColor = [UIColor colorWithHexString:@"#646870" alpha:0.06];
    [self.view addSubview:centerLine1];
    [centerLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneaNum.mas_left);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.top.mas_equalTo(self.phoneaNum.mas_bottom).offset(1*heightScale);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    
    
    self.passworldNum = [[UITextField alloc] init];
    self.passworldNum.delegate = self;
    self.passworldNum.secureTextEntry = YES;
    self.passworldNum.font = kFont(14);
    self.passworldNum.placeholder = @"密码长度8-20";
    self.passworldNum.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
//    self.passworldNum.keyboardType = UIKeyboardTypeNumberPad;
    NSAttributedString *attrStringPass = [[NSAttributedString alloc] initWithString:@"密码长度8-20" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8A8A8A"],NSFontAttributeName:kFont(14)}];
   self.passworldNum.attributedPlaceholder = attrStringPass;
    self.passworldNum.borderStyle = UITextBorderStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.passworldNum];
    [self.view addSubview:self.passworldNum];
    [self.passworldNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.phoneaNum.mas_bottom).offset(10*heightScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(42*heightScale));
    }];
    
    self.seeButton = [[UIButton alloc] init];
    self.seeButton.hidden = YES;
    [self.seeButton setImage:[UIImage imageNamed:@"CSNewLoginOpenPass.png"] forState:UIControlStateNormal];
    [self.seeButton addTarget:self action:@selector(seeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.seeButton];
    [self.seeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passworldNum.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.width.mas_offset(@(16*heightScale));
    }];

    
    UIView  *centerLine2 = [[UIView alloc] init];
    centerLine2.backgroundColor = [UIColor colorWithHexString:@"#646870" alpha:0.06];
    [self.view addSubview:centerLine2];
    [centerLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passworldNum.mas_left);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.top.mas_equalTo(self.passworldNum.mas_bottom).offset(1*heightScale);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    
    
    self.errorLabel= [[UILabel alloc] init];
    self.errorLabel.hidden = YES;
    self.errorLabel.text = @"帐号或密码错误，请重新输入";
    self.errorLabel.font = [UIFont boldSystemFontOfSize:8];
    self.errorLabel.textColor = [UIColor colorWithHexString:@"#FF4E4E"];
    self.errorLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.errorLabel];
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(centerLine2.mas_bottom).offset(10*heightScale);
    }];
    
    self.forgetLabel= [[UILabel alloc] init];
    self.forgetLabel.text = @"忘记了？点这里找回密码哦";
    [self.forgetLabel setTapActionWithBlock:^{
        CSNewResetPasswordsViewController *vc = [CSNewResetPasswordsViewController new];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    self.forgetLabel.font = [UIFont boldSystemFontOfSize:9];
    self.forgetLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.forgetLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.forgetLabel];
    [self.forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(centerLine2.mas_right);
        make.centerY.mas_equalTo(self.errorLabel.mas_centerY);
    }];
    
    
    self.sendButton = [[UIButton alloc] init];
    self.sendButton.enabled = NO;
    [self.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.sendButton, 5);
    self.sendButton.titleLabel.font = kFont(14);
    [self.sendButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
    [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.forgetLabel.mas_bottom).offset(55*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(45*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(44*heightScale));
    }];
    
    self.checkButton = [[UIButton alloc] init];
    [self.checkButton setImage:[UIImage imageNamed:@"CSLoginAgreeUnSelect.png"] forState:UIControlStateNormal];
    [self.checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkButton];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sendButton.mas_bottom).offset(160*heightScale);
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

- (void)deleteButtonClick:(UIButton *)btn{
    self.phoneaNum.text = @"";
}

- (void)checkButtonClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.checkButton setImage:[UIImage imageNamed:@"CSLoginAgreeSelect.png"] forState:UIControlStateNormal];
    }else{
        [self.checkButton setImage:[UIImage imageNamed:@"CSLoginAgreeUnSelect.png"] forState:UIControlStateNormal];
    }
}
- (void)seeButtonClick:(UIButton *)btn{
        btn.selected = !btn.selected;
        if (btn.selected) {
            [self.seeButton setImage:[UIImage imageNamed:@"CSNewLoginClosePass.png"] forState:UIControlStateNormal];
            self.passworldNum.secureTextEntry = NO;
        }else{
            [self.seeButton setImage:[UIImage imageNamed:@"CSNewLoginOpenPass.png"] forState:UIControlStateNormal];
            self.passworldNum.secureTextEntry = YES;
        }
}
- (void)sendButtonClick:(UIButton *)btn{
    if (self.checkButton.isSelected) {
        [[CSNewLoginNetManager sharedManager] getLoginWithPhone:self.phoneaNum.text withPws:self.passworldNum.text Complete:^(CSNetResponseModel * _Nonnull response) {
            if (response.code == 200) {
                NSDictionary *dict = response.data;
                NSString *token = dict[@"token"];
                [[CSAPPConfigManager sharedConfig] storeSessionKey:token];
                if (self.PawssworlLoginBlock) {
                    self.PawssworlLoginBlock(YES);
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
                self.errorLabel.hidden = NO;
                if (self.PawssworlLoginBlock) {
                    self.PawssworlLoginBlock(NO);
                }
            }
        } failureComplete:^(NSError * _Nonnull error) {
            if (self.PawssworlLoginBlock) {
                self.PawssworlLoginBlock(NO);
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
    if (textField == self.phoneaNum) {
        if (self.phoneaNum.text.length > 10) {
            self.phoneaNum.text = [textField.text substringToIndex:11];
            self.deleteButton.hidden = NO;
            
        }else{
            self.sendButton.enabled = NO;
            self.deleteButton.hidden = YES;
        }
    }else{
        if (textField.text.length > 0) {
            self.seeButton.hidden = NO;
        }else{
            self.seeButton.hidden = YES;
        }
    }
   
    if (self.phoneaNum.text.length >10 && self.passworldNum.text.length > 7  && self.passworldNum.text.length < 21 && [NSString cs_isMobileNumber:self.phoneaNum.text]) {
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
