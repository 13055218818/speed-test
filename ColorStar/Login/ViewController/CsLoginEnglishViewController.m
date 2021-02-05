//
//  CsLoginEnglishViewController.m
//  ColorStar
//
//  Created by apple on 2020/12/9.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CsLoginEnglishViewController.h"
#import "FBSDKLoginKit.h"
#import <GoogleSignIn/GIDSignIn.h>
#import <GoogleSignIn/GIDSignInButton.h>
#import <GoogleSignIn/GIDGoogleUser.h>
#import <GoogleSignIn/GIDProfileData.h>
#import "CSNewEmailRegistViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
@interface CsLoginEnglishViewController ()<GIDSignInDelegate,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>
@property (nonatomic, strong)UIImageView    *bgImage;
@property (nonatomic, strong)UIButton       *backButton;
@property (nonatomic, strong)UIImageView    *bgHeadimage;
@property (nonatomic, strong)UIImageView    *headimage;
@property (nonatomic, strong)UILabel        *firstLabel;
@property (nonatomic, strong)UILabel        *secondLabel;
@property (nonatomic, strong)UILabel        *thirdLabel;
@property (nonatomic, strong)UIView         *faceBookView;
@property (nonatomic, strong)UIView         *gmailView;
@property (nonatomic, strong)UILabel        *fourLabel;
@property (nonatomic, strong)UILabel        *countLabel;
@property (nonatomic, strong)UILabel        *lastLabel;
@property (nonatomic, strong)YYLabel        *agressLabel;
@end

@implementation CsLoginEnglishViewController
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
    
    UILabel *create = [[UILabel alloc] init];
    create.text = @"regist";
    [create setTapActionWithBlock:^{
        CSNewEmailRegistViewController *vc =[CSNewEmailRegistViewController new];
        vc.type = @"0";
        vc.EmailRegistBlock = ^(BOOL success) {
            self.LoginEnglishBlock(success);
        };
        vc.modalPresentationStyle=UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    create.font = [UIFont boldSystemFontOfSize:14];
    create.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    create.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:create];
    [create mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-12*widthScale);
        make.centerY.mas_equalTo(self.backButton.mas_centerY);
    }];
    
    self.headimage = [[UIImageView alloc] init];
    ViewRadius(self.headimage, 19*heightScale);
    self.headimage.clipsToBounds = YES;
    self.headimage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.headimage];
    [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.width.mas_offset(@(79*heightScale));
        make.top.mas_equalTo(self.backButton.mas_bottom).offset(35*heightScale);
    }];
    self.bgHeadimage = [[UIImageView alloc] init];
    self.bgHeadimage.image = [UIImage imageNamed:@"CS_home_recomendArtisheadRaiduImage.png"];
    [self.view addSubview:self.bgHeadimage];
    [self.bgHeadimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.self.headimage);
        make.height.width.mas_offset(@(80*heightScale));
    }];
    
    self.firstLabel = [[UILabel alloc] init];
    self.firstLabel.numberOfLines = 0;
    self.firstLabel.text = @"Your Profile";
    self.firstLabel.font = [UIFont boldSystemFontOfSize:20];
    self.firstLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.firstLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.firstLabel];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.bgHeadimage.mas_bottom).offset(10*heightScale);
    }];
    
    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.numberOfLines = 0;
    self.secondLabel.text = @"Sign in to get started";
    self.secondLabel.font = [UIFont boldSystemFontOfSize:20];
    self.secondLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.secondLabel];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.firstLabel.mas_bottom).offset(20*heightScale);
    }];
    
    self.thirdLabel = [[UILabel alloc] init];
    self.thirdLabel.numberOfLines = 0;
    self.thirdLabel.text = @"Sign in to access your enrolled classes and account information.";
    self.thirdLabel.font = [UIFont boldSystemFontOfSize:14];
    self.thirdLabel.textColor = [UIColor colorWithHexString:@"#C4C4C4"];
    self.thirdLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.thirdLabel];
    [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(55*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-55*widthScale);
        make.top.mas_equalTo(self.secondLabel.mas_bottom).offset(4*heightScale);
    }];
    
    self.faceBookView = [[UIView alloc] init];
    [self.faceBookView setTapActionWithBlock:^{
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];

        [loginManager logInWithPermissions:@[@"email",@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Process error");
            } else if (result.isCancelled) {
                NSLog(@"Cancelled");
            } else {
                NSLog(@"token信息：%@", result.token);
                //[self getUserInfoWithResult:result];
                [self getUserInfoWithResult:result];
            }
        }];
    }];
    ViewRadius(self.faceBookView, 23*heightScale);
    self.faceBookView.backgroundColor = [UIColor colorWithHexString:@"#3891FF"];
    [self.view addSubview:self.faceBookView];
    [self.faceBookView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(55*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-55*widthScale);
        make.top.mas_equalTo(self.thirdLabel.mas_bottom).offset(32*heightScale);
        make.height.mas_offset(@(46*heightScale));
    }];
    UIImageView   *faceImage = [[UIImageView alloc] init];
    faceImage.image = [UIImage imageNamed:@"loginfacebook"];
    [self.faceBookView addSubview:faceImage];
    [faceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.faceBookView.mas_centerY);
        make.left.mas_equalTo(self.faceBookView.mas_left).offset(30*widthScale);
        make.width.height.mas_equalTo(@(22));
    }];
    UILabel *faceLabel = [[UILabel alloc] init];
    faceLabel.numberOfLines = 0;
    faceLabel.text = @"LOG IN USING FACEBOOK";
    faceLabel.font = [UIFont boldSystemFontOfSize:12];
    faceLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    faceLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:faceLabel];
    [faceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(faceImage.mas_left).offset(20*widthScale);
        make.right.mas_equalTo(self.faceBookView.mas_right).offset(-20*widthScale);
        make.centerY.mas_equalTo(self.faceBookView.mas_centerY);
    }];
    
    self.gmailView = [[UIView alloc] init];
    CS_Weakify(self, weakSelf);
    [self.gmailView setTapActionWithBlock:^{
        GIDSignIn*signIn = [GIDSignIn sharedInstance];
        [GIDSignIn sharedInstance] .shouldFetchBasicProfile = YES;
            signIn.presentingViewController = self;
            signIn.delegate = self;
            [signIn signIn];
    }];
    ViewRadius(self.gmailView, 23*heightScale);
    self.gmailView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self.view addSubview:self.gmailView];
    [self.gmailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(55*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-55*widthScale);
        make.top.mas_equalTo(self.faceBookView.mas_bottom).offset(27*heightScale);
        make.height.mas_offset(@(46*heightScale));
    }];
    
    UIImageView   *googleImage = [[UIImageView alloc] init];
    googleImage.image = [UIImage imageNamed:@"loginGoogle"];
    [self.gmailView addSubview:googleImage];
    [googleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.gmailView.mas_centerY);
        make.left.mas_equalTo(self.gmailView.mas_left).offset(30*widthScale);
        make.width.height.mas_equalTo(@(22));
    }];
    UILabel *gooleLabel = [[UILabel alloc] init];
    gooleLabel.numberOfLines = 0;
    gooleLabel.text = @"LOG IN USING GOOGLE";
    gooleLabel.font = [UIFont boldSystemFontOfSize:12];
    gooleLabel.textColor = [UIColor colorWithHexString:@"#3B3B3B"];
    gooleLabel.textAlignment = NSTextAlignmentCenter;
    [self.gmailView addSubview:gooleLabel];
    [gooleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(googleImage.mas_right).offset(20*widthScale);
        make.right.mas_equalTo(self.gmailView.mas_right).offset(-20*widthScale);
        make.centerY.mas_equalTo(self.gmailView.mas_centerY);
    }];
    
    self.fourLabel = [[UILabel alloc] init];
    self.fourLabel.numberOfLines = 0;
    self.fourLabel.hidden = YES;
    self.fourLabel.text = @"OR";
    self.fourLabel.font = [UIFont boldSystemFontOfSize:14];
    self.fourLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.fourLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.fourLabel];
    [self.fourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(55*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-55*widthScale);
        make.top.mas_equalTo(self.gmailView.mas_bottom).offset(12*heightScale);
    }];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.numberOfLines = 0;
    self.countLabel.text = @"LOG ON";
    [self.countLabel setTapActionWithBlock:^{
        CSNewEmailRegistViewController *vc =[CSNewEmailRegistViewController new];
        vc.modalPresentationStyle=UIModalPresentationFullScreen;
        vc.type = @"1";
        vc.EmailRegistBlock = ^(BOOL success) {
            self.LoginEnglishBlock(success);
        };
        [self presentViewController:vc animated:YES completion:nil];
    }];
    self.countLabel.font = [UIFont boldSystemFontOfSize:14];
    self.countLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    ViewRadius(self.countLabel, 23*heightScale);
    [self.view addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(55*widthScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-55*widthScale);
        make.top.mas_equalTo(self.fourLabel.mas_bottom).offset(12*heightScale);
        make.height.mas_offset(@(46*heightScale));
    }];
    if (@available(iOS 13.0, *)) {
          ASAuthorizationAppleIDButton *appleBtn = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhiteOutline];
          [appleBtn addTarget:self action:@selector(signInWithApple) forControlEvents:UIControlEventTouchUpInside];
        appleBtn.cornerRadius = 30;
          [self.view addSubview:appleBtn];
          [appleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(self.view);
              make.top.mas_equalTo(self.countLabel.mas_bottom).mas_offset(20);
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
    
    self.agressLabel= [[YYLabel alloc] init];
    self.agressLabel.frame = CGRectMake(0, 200, ScreenW, 100);
    [self.view addSubview:self.agressLabel];
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"By creating an account，you agree to our Term of Service and Privacy Policy"];
    text.yy_lineSpacing = 5;
    text.yy_font = kFont(14);
    text.yy_color = [UIColor colorWithHexString:@"#8A8A8A"];
    __weak typeof(self) weakself = self;
    [text yy_setTextHighlightRange:NSMakeRange(40, 15) color:[UIColor colorWithHexString:@"#00FEFF"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
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
    self.agressLabel.preferredMaxLayoutWidth = ScreenW - 76*widthScale;
    self.agressLabel.attributedText = text;
    
    [self.agressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(38*heightScale);
        make.right.mas_equalTo(self.view.mas_right).offset(-38*widthScale);
        make.top.mas_equalTo(self.countLabel.mas_bottom).mas_equalTo(66*heightScale);
    }];
    
    
}
-(void)gotoRegistAndLogin:(NSDictionary *)dict{
    [[CSTotalTool sharedInstance] showHudInView:self.view hint:@""];
    [[CSNewLoginNetManager sharedManager] getLoginFacebookAndGoogleWithDict:dict Complete:^(CSNetResponseModel * _Nonnull response) {
        if (response.code == 200) {
            [[CSTotalTool sharedInstance] hidHudInView:self.view];
            NSDictionary  *dict = response.data;
            NSString *token = dict[@"token"];
            [[CSAPPConfigManager sharedConfig] storeSessionKey:token];
            if (self.LoginEnglishBlock) {
                self.LoginEnglishBlock(YES);
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
            if (self.LoginEnglishBlock) {
                self.LoginEnglishBlock(NO);
            };
        }
    } failureComplete:^(NSError * _Nonnull error) {
        if (self.LoginEnglishBlock) {
            self.LoginEnglishBlock(NO);
        };
    }];
}
- (void)signIn:(GIDSignIn*)signIn didSignInForUser:(GIDGoogleUser*)user withError:(NSError*)error
{
    NSLog(@"user %@",user);
    NSLog(@"error %@",error);
    NSURL *imageURL;
    if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
       {
           NSUInteger dimension = round(120 * [[UIScreen mainScreen] scale]);
           imageURL = [user.profile imageURLWithDimension:dimension];
       }
    if (user) {
        NSDictionary  *dict = @{@"user_name":user.profile.email,
                                @"nickname":user.profile.email,
                                @"avatar":imageURL.absoluteString,
                                @"name":user.profile.name,
                                @"phone":@"",
                                @"full_name":@"",
        };
        [self gotoRegistAndLogin:dict];
    }
   
}
//获取用户信息 picture用户头像
- (void)getUserInfoWithResult:(FBSDKLoginManagerLoginResult *)result
{
    NSDictionary*params= @{@"fields":@"id,name,email,age_range,first_name,last_name,link,gender,locale,picture,timezone,updated_time,verified"};
      
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:result.token.userID
                                  parameters:params
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                        NSLog(@"%@",result);
        NSDictionary  *dict1 = result[@"picture"];
        NSDictionary *dict2 = dict1[@"data"];
        NSString *url = dict2[@"url"];
       
        NSDictionary  *dict = @{@"user_name":result[@"email"],
                                @"nickname":result[@"email"],
                                @"avatar":url,
                                @"name":result[@"name"],
                                @"phone":@"",
                                @"full_name":@"",
        };
        [self gotoRegistAndLogin:dict];

    }];
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
        [[CSTotalTool sharedInstance] showHudInView:self.view hint:@""];
        [[CSNewLoginNetManager sharedManager] getAppleLoginWith:dict Complete:^(CSNetResponseModel * _Nonnull response) {
            if (response.code == 200) {
                NSDictionary *dict = response.data;
                NSString *token = dict[@"token"];
                [[CSAPPConfigManager sharedConfig] storeSessionKey:token];
                [[CSNewLoginNetManager sharedManager] getUserInfoWithTokenComplete:^(CSNetResponseModel * _Nonnull response) {
                    [[CSTotalTool sharedInstance] hidHudInView:self.view];
                    if (response.code == 200) {
                        NSDictionary  *dict = response.data;
                        CSNewLoginModel *model= [CSNewLoginModel yy_modelWithDictionary:dict];
                        [CSNewLoginUserInfoManager sharedManager].userInfo = model;
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }

                    
                } failureComplete:^(NSError * _Nonnull error) {
                    [[CSTotalTool sharedInstance] hidHudInView:self.view];
                }];
            }else{
                [[CSTotalTool sharedInstance] hidHudInView:self.view];
            }
        } failureComplete:^(NSError * _Nonnull error) {
            [[CSTotalTool sharedInstance] hidHudInView:self.view];
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

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
