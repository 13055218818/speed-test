//
//  CSEmailRegisterViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSEmailRegisterViewController.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import <Masonry.h>
#import "NSString+CSAlert.h"
#import "NSString+CS.h"
#import "CSNetworkManager.h"

@interface CSEmailRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, assign)CGFloat         leftMargin;

@property (nonatomic, strong)UIImageView   * imageView;

@property (nonatomic, strong)UILabel       * emailTitleLabel;

@property (nonatomic, strong)UITextField   * emailTextField;

@property (nonatomic, strong)UIView        * firstLine;

@property (nonatomic, strong)UILabel       * codeTitleLable;

@property (nonatomic, strong)UITextField   * codeTextField;

@property (nonatomic, strong)UIButton      * codeBtn;

@property (nonatomic, strong)UIView        * secondLine;

@property (nonatomic, strong)UILabel       * passwordTitleLabel;

@property (nonatomic, strong)UITextField   * passwordTextField;

@property (nonatomic, strong)UIButton      * passwordShowBtn;

@property (nonatomic, strong)UIView        * thirdLine;

@property (nonatomic, strong)UIButton      * registerBtn;

@end

@implementation CSEmailRegisterViewController

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
    
    [self.view addSubview:self.codeTitleLable];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.codeBtn];
    [self.view addSubview:self.secondLine];
    
    [self.view addSubview:self.passwordTitleLabel];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.passwordShowBtn];
    [self.view addSubview:self.thirdLine];
    [self.view addSubview:self.registerBtn];
    
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
    
    [self.codeTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.firstLine.mas_bottom).offset(30*heightScale);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.codeTitleLable.mas_bottom).offset(heightScale*30);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self.view).offset(-(self.leftMargin + 100));
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.codeTextField);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.codeTextField.mas_bottom).offset(10*heightScale);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
    }];
    
    [self.passwordTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.secondLine.mas_bottom).offset(30*heightScale);
    }];
    
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.passwordTitleLabel.mas_bottom).offset(heightScale*30);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self.view).offset(-(self.leftMargin + 100));
    }];
    
    [self.passwordShowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordTextField);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
        make.size.mas_equalTo(CGSizeMake(17, 13.5));
    }];
    
    [self.thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(10*heightScale);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
        make.top.mas_equalTo(self.thirdLine.mas_bottom).offset(heightScale*60);
        make.height.mas_equalTo(50);
    }];
    
}

#pragma mark Action Method

- (void)queryCode:(UIButton*)sender{
    [self startTimer];
    
    
    
}

- (void)registerClick{
    
    NSString * toast = @"";
    if ([NSString isNilOrEmpty:self.emailTextField.text]) {
        toast = NSLocalizedString(@"请输入您的邮箱", nil);
        [toast showAlert];
        return;
    }
    if ([NSString isNilOrEmpty:self.codeTextField.text]) {
        toast = NSLocalizedString(@"请输入验证码", nil);
        [toast showAlert];
        return;
    }
    if ([NSString isNilOrEmpty:self.passwordTextField.text]) {
        toast = NSLocalizedString(@"请输入您的密码", nil);
        [toast showAlert];
        return;
    }
    
    [[CSNetworkManager sharedManager] registerWithType:CSRegisterTypeEmail account:self.emailTextField.text code:self.codeTextField.text password:self.passwordTextField.text successComplete:^(CSNetResponseModel *response) {
        
        
    } failureComplete:^(NSError *error) {
        
    }];
    
    
}

#pragma mark Private Method

- (void)startTimer{
    
    __block NSInteger time = 10; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮的样式
                [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
            });

        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮显示读秒效果
                [self.codeBtn setTitle:[NSString stringWithFormat:@"(%.2d)", seconds] forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
}


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
        _emailTitleLabel.text = NSLocalizedString(@"手机号码", nil);
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

- (UILabel*)codeTitleLable{
    if (!_codeTitleLable) {
        _codeTitleLable = [[UILabel alloc]initWithFrame:CGRectZero];
        _codeTitleLable.text = NSLocalizedString(@"邮箱验证码", nil);
        _codeTitleLable.textColor = [UIColor colorWithWhite:1.0f alpha:0.38];
        _codeTitleLable.font = [UIFont systemFontOfSize:12.0f];
    }
    return _codeTitleLable;
}

- (UITextField*)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        _codeTextField.font = [UIFont systemFontOfSize:22.0f];
        _codeTextField.textColor = [UIColor whiteColor];
        _codeTextField.placeholder = NSLocalizedString(@"请输入验证码", nil);
        [_codeTextField setValue:[UIColor colorWithWhite:1.0 alpha:0.12] forKeyPath:@"placeholderLabel.textColor"];
    }
    return _codeTextField;
}

- (UIButton*)codeBtn{
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:NSLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
        [_codeBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.6] forState:UIControlStateNormal];
        _codeBtn.backgroundColor = [UIColor colorWithHexString:@"#3A54FA"];
        _codeBtn.layer.masksToBounds = YES;
        _codeBtn.layer.cornerRadius = 6.0f;
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_codeBtn addTarget:self action:@selector(queryCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}

- (UIView*)secondLine{
    if (!_secondLine) {
        _secondLine = [[UIView alloc]initWithFrame:CGRectZero];
        _secondLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.12];
    }
    return _secondLine;
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

- (UIButton*)passwordShowBtn{
    if (_passwordShowBtn) {
        _passwordShowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passwordShowBtn setImage:[UIImage imageNamed:@"cs_register_password_show"] forState:UIControlStateNormal];
        [_passwordShowBtn setImage:[UIImage imageNamed:@"cs_register_password_hidden"] forState:UIControlStateSelected];
    }
    return _passwordShowBtn;
}

- (UIView*)thirdLine{
    if (!_thirdLine) {
        _thirdLine = [[UIView alloc]initWithFrame:CGRectZero];
        _thirdLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.12];
    }
    return _thirdLine;
}

- (UIButton*)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:NSLocalizedString(@"邮箱注册", nil) forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.87] forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius = 25;
        _registerBtn.backgroundColor = [UIColor colorWithHexString:@"#3A54FA"];
        [_registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}


@end
