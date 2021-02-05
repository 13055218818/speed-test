//
//  CSNewLoginViewController.m
//  ColorStar
//
//  Created by apple on 2020/11/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNewLoginViewController.h"
#import "NSString+CSAlert.h"
#import "CSNewLoginForPawssworldViewController.h"
#import "CSNewRegistViewController.h"
#import "CSNewLoginVerifyViewController.h"
#import "CSNewRegistViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
@interface CSNewLoginViewController ()<UITextFieldDelegate,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>
@property (nonatomic, strong)UIImageView            *bgImage;
@property (nonatomic, strong)UIButton               *backButton;
@property (nonatomic, strong)UIButton               *deleteButton;
@property (nonatomic, strong)UIButton               *registButton;
@property (nonatomic, strong)UILabel               *welocomLabel;
@property (nonatomic, strong)UITextField           *areaNum;
@property (nonatomic, strong)UITextField           *phoneaNum;
@property (nonatomic, strong)UIButton               *sendButton;
@property (nonatomic, strong)UIButton               *paswordButton;
@property (nonatomic, strong)UIImageView               *WXButton;
@end

@implementation CSNewLoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiChatOK:) name:@"weiChatOK" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self makeUI];
}

- (void)makeUI{
    self.bgImage = [[UIImageView alloc] init];
    self.bgImage.image = [UIImage imageNamed:@"CSNewLoginFirstBg.png"];
    [self.view addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    self.backButton = [[UIButton alloc] init];
    [self.backButton setImage:[UIImage imageNamed:@"CSNewLoginBack.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(12*widthScale);
        make.top.mas_equalTo(self.view.mas_top).offset(24*heightScale +kStatusBarHeight);
        make.width.height.mas_offset(@(26*widthScale));
    }];
    
    self.registButton = [[UIButton alloc] init];
    self.registButton.hidden = YES;
    self.registButton.titleLabel.font = kFont(16);
    [self.registButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registButton addTarget:self action:@selector(registButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registButton];
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-16*widthScale);
        make.centerY.mas_equalTo(self.backButton.mas_centerY);
    }];
    
    self.welocomLabel= [[UILabel alloc] init];
    self.welocomLabel.numberOfLines = 0;
    [self.welocomLabel setValue:@(30) forKey:@"lineSpacing"];
    self.welocomLabel.text =[NSString stringWithFormat:@"%@\n%@",NSLocalizedString(@"你好",nil),NSLocalizedString(@"欢迎来到彩色世界",nil)];
    self.welocomLabel.font = [UIFont boldSystemFontOfSize:20];
    self.welocomLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.welocomLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.welocomLabel];
    [self.welocomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(45*widthScale);
        make.top.mas_equalTo(self.backButton.mas_bottom).offset(90*heightScale);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_offset(@(80*heightScale));
    }];
    
    UIView  *centerLine1 = [[UIView alloc] init];
    centerLine1.backgroundColor = [UIColor colorWithHexString:@"#646870"];
    [self.view addSubview:centerLine1];
    [centerLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.welocomLabel.mas_left).offset(42*widthScale);
        make.top.mas_equalTo(self.welocomLabel.mas_bottom).offset(46*heightScale);
        make.width.mas_offset(@(1/[UIScreen mainScreen].scale));
        make.height.mas_offset(@(22*heightScale));
    }];
    
    UILabel  *addlabel = [[UILabel alloc] init];
    addlabel.text = @"+";
    addlabel.textColor = [UIColor whiteColor];
    [self.view addSubview:addlabel];
    [addlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.welocomLabel.mas_left);
        make.centerY.mas_equalTo(centerLine1.mas_centerY);
    }];
    
    self.areaNum = [[UITextField alloc] init];
    self.areaNum.enabled = YES;
    self.areaNum.text = @"86";
    self.areaNum.keyboardType = UIKeyboardTypeNumberPad;
    self.areaNum.font = kFont(14);
    self.areaNum.textColor = [UIColor whiteColor];
    self.areaNum.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.areaNum];
    [self.areaNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addlabel.mas_right);
        make.centerY.mas_equalTo(centerLine1.mas_centerY);
        make.right.mas_equalTo(centerLine1.mas_left);
        make.height.mas_offset(@(22*heightScale));
    }];
    
    self.phoneaNum = [[UITextField alloc] init];
    self.phoneaNum.delegate = self;
    self.phoneaNum.font = kFont(14);
    self.phoneaNum.placeholder = @"请输入手机号码";
    self.phoneaNum.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.phoneaNum.keyboardType = UIKeyboardTypeNumberPad;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8A8A8A"],NSFontAttributeName:kFont(14)}];
   self.phoneaNum.attributedPlaceholder = attrString;
    self.phoneaNum.borderStyle = UITextBorderStyleNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.phoneaNum];
    [self.view addSubview:self.phoneaNum];
    [self.phoneaNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(centerLine1.mas_right).offset(15*widthScale);
        make.centerY.mas_equalTo(centerLine1.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(22*heightScale));
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

    
    UIView  *centerLine2 = [[UIView alloc] init];
    centerLine2.backgroundColor = [UIColor colorWithHexString:@"#646870" alpha:0.3];
    [self.view addSubview:centerLine2];
    [centerLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.welocomLabel.mas_left);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.top.mas_equalTo(centerLine1.mas_bottom).offset(10*heightScale);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    
    
    self.sendButton = [[UIButton alloc] init];
    self.sendButton.enabled = NO;
    [self.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.sendButton, 5);
    self.sendButton.titleLabel.font = kFont(14);
    [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
    [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(centerLine2.mas_bottom).offset(25*heightScale);
        make.left.mas_equalTo(self.view.mas_left).offset(45*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-48*widthScale);
        make.height.mas_offset(@(44*heightScale));
    }];
    
    self.paswordButton = [[UIButton alloc] init];
    self.paswordButton.titleLabel.font = kFont(14);
    [self.paswordButton setTitle:@"密码登录" forState:UIControlStateNormal];
    [self.paswordButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
    [self.paswordButton addTarget:self action:@selector(paswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.paswordButton];
    [self.paswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sendButton.mas_bottom).offset(20*heightScale);
        make.width.mas_offset(@(200*widthScale));
        make.height.mas_offset(@(25*heightScale));
        make.centerX.mas_equalTo(self.sendButton.mas_centerX);
    }];
    
    self.WXButton = [[UIImageView alloc] init];
    [self.WXButton setTapActionWithBlock:^{
        [self sendWXAuthReq];
    }];
    self.WXButton.image = [UIImage imageNamed:@"CSNewLoginWXIcon.png"];
    [self.view addSubview:self.WXButton];
    [self.WXButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-14*heightScale - kSafeAreaBottomHeight);
        make.width.height.mas_offset(@(40*widthScale));
    }];
    
    UILabel  *thirdLabel= [[UILabel alloc] init];
    thirdLabel.numberOfLines = 0;
    thirdLabel.text = @"第三方登录";
    thirdLabel.font = [UIFont boldSystemFontOfSize:12];
    thirdLabel.textColor = [UIColor colorWithHexString:@"#ACACAC"];
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thirdLabel];
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.WXButton.mas_top).offset(-14*heightScale);
    }];
    
    UIView  *bottomLineView1= [[UIView alloc] init];
    bottomLineView1.backgroundColor = [UIColor colorWithHexString:@"#646870" alpha:0.3];
    [self.view addSubview:bottomLineView1];
    [bottomLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(thirdLabel.mas_left).offset(-15*widthScale);
        make.centerY.mas_equalTo(thirdLabel.mas_centerY);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    
    UIView  *bottomLineView2= [[UIView alloc] init];
    bottomLineView2.backgroundColor = [UIColor colorWithHexString:@"#646870" alpha:0.3];
    [self.view addSubview:bottomLineView2];
    [bottomLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view);
        make.left.mas_equalTo(thirdLabel.mas_right).offset(15*widthScale);
        make.centerY.mas_equalTo(thirdLabel.mas_centerY);
        make.height.mas_offset(@(1/[UIScreen mainScreen].scale));
    }];
    

    
    if (@available(iOS 13.0, *)) {
          ASAuthorizationAppleIDButton *appleBtn = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhiteOutline];
          [appleBtn addTarget:self action:@selector(signInWithApple) forControlEvents:UIControlEventTouchUpInside];
            appleBtn.cornerRadius = 30;
          [self.view addSubview:appleBtn];
          [appleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(self.view);
              make.top.mas_equalTo(self.paswordButton.mas_bottom).mas_offset(20);
              make.left.mas_equalTo(self.view.mas_left).offset(55*widthScale);
              make.right.mas_equalTo(self.view.mas_right).offset(-55*widthScale);
              make.height.mas_offset(@(46*heightScale));
          }];
        if ([CSNewLoginUserInfoManager sharedManager].currentAppVersionInfo.ios_hide) {
            appleBtn.hidden = NO;
        }else{
            appleBtn.hidden = YES;
        }
     }

    
}

- (void)paswordButtonClick:(UIButton *)btn{
    CSNewLoginForPawssworldViewController *vc = [CSNewLoginForPawssworldViewController new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.PawssworlLoginBlock = ^(BOOL success) {
        self.loginBlock(success);
    };
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)sendButtonClick:(UIButton *)btn{
    CSNewLoginVerifyViewController *vc = [CSNewLoginVerifyViewController new];
    vc.phoneStr=self.phoneaNum.text;
    vc.prefixStr = self.areaNum.text;
    vc.modalPresentationStyle=UIModalPresentationFullScreen;
    vc.LoginVerifyBlock = ^(BOOL success) {
        self.loginBlock(success);
    };
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)deleteButtonClick:(UIButton *)btn{
    self.phoneaNum.text = @"";
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registButtonClick{
    CSNewRegistViewController *vc = [CSNewRegistViewController new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)signInWithApple{
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        
        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        
        ASAuthorizationController *vc = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        vc.delegate = self;
        vc.presentationContextProvider = self;
        [vc performRequests];
    }
}
//  ASAuthorizationControllerPresentationContextProviding  显示在哪个视图上面

- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0))
{
    return self.view.window;
}
// ASAuthorizationControllerDelegate  授权回调

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0))
{
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]])       {
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        
        NSString *state = credential.state;
        NSString *userID = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString *email = credential.email;
        NSString *authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding]; // refresh token
        NSString *identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding]; // access token
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        NSLog(@"state: %@", state);
        NSLog(@"userID: %@", userID);
        NSLog(@"fullName: %@", fullName);
        NSLog(@"email: %@", email);
        NSLog(@"authorizationCode: %@", authorizationCode);
        NSLog(@"identityToken: %@", identityToken);
        NSLog(@"realUserStatus: %@", @(realUserStatus));
        if ([NSString isNilOrEmpty:email]) {
            email = @"";
        }
        NSString *givenName = fullName.givenName;
        NSString *familyName = fullName.familyName;
        if ([NSString isNilOrEmpty:givenName]) {
            givenName = @"";
        }
        if ([NSString isNilOrEmpty:familyName]) {
            familyName = @"";
        }
        NSDictionary *fullnameDict = @{
            @"givenName":givenName,
            @"familyName":familyName
        };
        NSDictionary  *dict = @{
                                @"user":userID,
                                @"email":email,
                                @"fullName":[[CSTotalTool sharedInstance] convertToJsonData:fullnameDict],
                                @"authorizationCode":authorizationCode,
                                @"identityToken":identityToken
        };
        [[CSNewLoginNetManager sharedManager] getAppleLoginWith:dict Complete:^(CSNetResponseModel * _Nonnull response) {
            if (response.code == 200) {
                NSDictionary *dict = response.data;
                NSString *token = dict[@"token"];
                [[CSAPPConfigManager sharedConfig] storeSessionKey:token];
                [[CSNewLoginNetManager sharedManager] getUserInfoWithTokenComplete:^(CSNetResponseModel * _Nonnull response) {
                    if (response.code == 200) {
                        NSDictionary  *dict = response.data;
                        CSNewLoginModel *model= [CSNewLoginModel yy_modelWithDictionary:dict];
                        [CSNewLoginUserInfoManager sharedManager].userInfo = model;
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }

                    
                } failureComplete:^(NSError * _Nonnull error) {
                    
                }];
            }else{
                
            }
        } failureComplete:^(NSError * _Nonnull error) {
            
        }];
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0))
{
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
    }
    NSLog(@"%@", errorMsg);
}

#pragma mark - NSNotification
- (void)textFieldDidChanged:(NSNotification*)notification{
    UITextField * textField = notification.object;
    if (self.phoneaNum == textField) {
        if (textField.text.length > 10) {
            self.phoneaNum.text = [textField.text substringToIndex:11];
            if (![NSString cs_isMobileNumber:self.phoneaNum.text]) {
                self.deleteButton.hidden = YES;
                self.sendButton.enabled = NO;
                [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
                [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
            }else{
                self.deleteButton.hidden = NO;
                self.sendButton.enabled = YES;
                [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
                [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#3B3B3B"] forState:UIControlStateNormal];
            }
        }else{
            self.deleteButton.hidden = YES;
            self.sendButton.enabled = NO;
            [self.sendButton setBackgroundColor:[UIColor colorWithHexString:@"#3A414D"]];
            [self.sendButton setTitleColor:[UIColor colorWithHexString:@"#ACACAC"] forState:UIControlStateNormal];
        }
    }
    
}

- (void)sendWXAuthReq{//复制即可
    
    if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        [WXApi sendReq:req completion:^(BOOL success) {
            if (success) {
                
            }
        }];
    }else{
//自己简单封装的alert
//        [self showAlertControllerWithTitle:@"温馨提示" withMessage:@"未安装微信应用或版本过低"];
         }
}




-(void)weiChatOK:(NSNotification *)notification{//第三方登录
    
    NSString  *code = notification.object;
    CS_Weakify(self, weakSelf);
    [[CSNewLoginNetManager sharedManager] getLoginTokenWithWXCode:code Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            NSDictionary  *dict = (NSDictionary *)response.data;
            
            NSString *loginCode= [dict[@"loginCode"] stringValue];
            if ([loginCode isEqualToString:@"-1"]) {
                NSDictionary *openDict = dict[@"loginData"];
                NSString *openId = openDict[@"openid"];
                    CSNewRegistViewController *vc =[CSNewRegistViewController new];
                    vc.openId= openId;
                vc.RegistLoginBlock = ^(BOOL success) {
                    weakSelf.loginBlock(success);
                };
                    vc.modalPresentationStyle=UIModalPresentationFullScreen;
                    [weakSelf presentViewController:vc animated:YES completion:nil];
                
            }else{
                NSDictionary *openDict = dict[@"loginData"];
                NSString *token = openDict[@"token"];
                [[CSAPPConfigManager sharedConfig] storeSessionKey:token];
                [[CSNewLoginNetManager sharedManager] getUserInfoWithTokenComplete:^(CSNetResponseModel * _Nonnull response) {
                    if (response.code == 200) {
                        NSDictionary  *dict = response.data;
                        CSNewLoginModel *model= [CSNewLoginModel yy_modelWithDictionary:dict];
                        [CSNewLoginUserInfoManager sharedManager].userInfo = model;
                        if (weakSelf.loginBlock) {
                            weakSelf.loginBlock(YES);
                        }
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
                        [weakSelf.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    }

                    
                } failureComplete:^(NSError * _Nonnull error) {
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }];
                
            }
        }else{
            if (weakSelf.loginBlock) {
                weakSelf.loginBlock(NO);
            }
        }
        
    } failureComplete:^(NSError * _Nonnull error) {
        if (weakSelf.loginBlock) {
            weakSelf.loginBlock(NO);
        }
    }];

    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weiChatOK" object:nil];
}

@end
