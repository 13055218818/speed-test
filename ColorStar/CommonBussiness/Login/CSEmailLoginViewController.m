//
//  CSEmailLoginViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSEmailLoginViewController.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import <Masonry.h>
#import "NSString+CSAlert.h"
#import "NSString+CS.h"
#import "CSNetworkManager.h"


@interface CSEmailLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, assign)CGFloat         leftMargin;

@property (nonatomic, strong)UIImageView   * imageView;

@property (nonatomic, strong)UILabel       * emailTitleLabel;

@property (nonatomic, strong)UITextField   * emailTextField;

@property (nonatomic, strong)UIView        * firstLine;

@property (nonatomic, strong)UIView        * secondLine;

@property (nonatomic, strong)UILabel       * passwordTitleLabel;

@property (nonatomic, strong)UITextField   * passwordTextField;

@property (nonatomic, strong)UIButton      * loginBtn;

@end

@implementation CSEmailLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"彩色世界", nil);
    self.leftMargin = 35*widthScale;

    [self setupViews];
}

- (void)setupViews{
    
    [self.view addSubview:self.imageView];
    
    [self.view addSubview:self.emailTitleLabel];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.firstLine];
    
        
    [self.view addSubview:self.passwordTitleLabel];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.secondLine];

    [self.view addSubview:self.loginBtn];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(self.leftMargin);
        make.top.mas_equalTo(self.view).offset(100*widthScale);
        make.size.mas_equalTo(CGSizeMake(90*widthScale, 90*widthScale));
    }];
    
    [self.emailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(heightScale*47);
    }];
    
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.emailTitleLabel.mas_bottom).offset(heightScale*30);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.emailTextField.mas_bottom).offset(10*heightScale);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
    }];
    
    [self.passwordTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.firstLine.mas_bottom).offset(30*heightScale);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.passwordTitleLabel.mas_bottom).offset(heightScale*30);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(10*heightScale);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
        make.top.mas_equalTo(self.secondLine.mas_bottom).offset(heightScale*60);
        make.height.mas_equalTo(50);
    }];
    
}

#pragma mark Action Method


- (void)loginClick{
    
    NSString * toast = @"";
    if ([NSString isNilOrEmpty:self.emailTextField.text]) {
        toast = NSLocalizedString(@"请输入您的邮箱", nil);
        [toast showAlert];
        return;
    }
    
    if ([NSString isNilOrEmpty:self.passwordTextField.text]) {
        toast = NSLocalizedString(@"请输入您的密码", nil);
        [toast showAlert];
        return;
    }
    
    
    [[CSNetworkManager sharedManager] loginWithType:CSRegisterTypeEmail account:self.emailTextField.text password:self.passwordTextField.text code:@"" successComplete:^(CSNetResponseModel *response) {
        
    } failureComplete:^(NSError *error) {
        
    }];
    
}

#pragma mark Private Method



#pragma mark - Properties Method

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 45*widthScale;
        _imageView.backgroundColor = [UIColor whiteColor];
    }
    return _imageView;
}

- (UILabel*)emailTitleLabel{
    if (!_emailTitleLabel) {
        _emailTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _emailTitleLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.38];
        _emailTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        _emailTitleLabel.text = NSLocalizedString(@"邮箱账号", nil);
    }
    return _emailTitleLabel;
}

- (UITextField*)emailTextField{
    if (!_emailTextField) {
        _emailTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        _emailTextField.delegate = self;
        _emailTextField.font = [UIFont systemFontOfSize:22.0f];
        _emailTextField.textColor = [UIColor whiteColor];
        _emailTextField.placeholder = NSLocalizedString(@"请输入您的邮箱", nil);
        [_emailTextField setValue:[UIColor colorWithWhite:1.0 alpha:0.12] forKeyPath:@"placeholderLabel.textColor"];
        
    }
    return _emailTextField;
}

- (UIView*)firstLine{
    if (!_firstLine) {
        _firstLine = [[UIView alloc]initWithFrame:CGRectZero];
        _firstLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.12];
    }
    return _firstLine;
}

- (UILabel*)passwordTitleLabel{
    if (!_passwordTitleLabel) {
        _passwordTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _passwordTitleLabel.text = NSLocalizedString(@"密码", nil);
        _passwordTitleLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.38];
        _passwordTitleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _passwordTitleLabel;
}

- (UITextField*)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        _passwordTextField.delegate = self;
        _passwordTextField.placeholder = NSLocalizedString(@"请输入您的密码", nil);
        [_passwordTextField setValue:[UIColor colorWithWhite:1.0 alpha:0.12] forKeyPath:@"placeholderLabel.textColor"];
        _passwordTextField.textColor = [UIColor whiteColor];
    }
    return _passwordTextField;
}

- (UIView*)secondLine{
    if (!_secondLine) {
        _secondLine = [[UIView alloc]initWithFrame:CGRectZero];
        _secondLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.12];
    }
    return _secondLine;
}

- (UIButton*)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:NSLocalizedString(@"登陆", nil) forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.87] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 25;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#3A54FA"];
        [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

@end
