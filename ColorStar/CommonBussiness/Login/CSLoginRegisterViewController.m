//
//  CSLoginRegisterViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSLoginRegisterViewController.h"
#import "CSColorStar.h"
#import "CSTelLoginViewController.h"
#import "CSTelRegisterViewController.h"
#import "CSEmailLoginViewController.h"
#import "CSEmailRegisterViewController.h"
#import <Masonry.h>
#import "UIColor+CS.h"


@interface CSLoginRegisterViewController ()

@property (nonatomic, strong)UIImageView * imageView;

@property (nonatomic, strong)UIButton    * registerBtn;

@property (nonatomic, strong)UIButton    * loginBtn;

@end

@implementation CSLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title =
    self.view.backgroundColor = [UIColor blackColor];
    self.title = NSLocalizedString(@"彩色世界", nil);
    [self setupViews];
}

- (void)setupViews{
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registerBtn];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(heightScale*75);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(widthScale*150, widthScale*150));
    }];

    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-(heightScale*100));
        make.left.mas_equalTo(self.view).offset(37.5*widthScale);
        make.right.mas_equalTo(self.view).offset(-37.5*widthScale);
        make.height.mas_equalTo(50);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.registerBtn.mas_top).offset(-(heightScale*20));
        make.left.mas_equalTo(self.view).offset(37.5*widthScale);
        make.right.mas_equalTo(self.view).offset(-37.5*widthScale);
        make.height.mas_equalTo(50);
    }];
    
}

- (void)loginClick{
    
    CSTelLoginViewController * telVC = [[CSTelLoginViewController alloc]init];
    telVC.complete = self.loginComplete;
    [self.navigationController pushViewController:telVC animated:YES];
    return;
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"登录", nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * actionOne = [UIAlertAction actionWithTitle:NSLocalizedString(@"手机号码", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CSTelLoginViewController * telVC = [[CSTelLoginViewController alloc]init];
        [self.navigationController pushViewController:telVC animated:YES];
    }];
    UIAlertAction * actionTwo = [UIAlertAction actionWithTitle:NSLocalizedString(@"邮箱", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CSEmailLoginViewController * emailVC = [[CSEmailLoginViewController alloc]init];
        [self.navigationController pushViewController:emailVC animated:YES];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:actionOne];
    [alertVC addAction:actionTwo];
    [alertVC addAction:cancel];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    
}

- (void)registerClick{
    
    CSTelRegisterViewController * telVC = [[CSTelRegisterViewController alloc]init];
    telVC.complete = self.loginComplete;
    [self.navigationController pushViewController:telVC animated:YES];
    return;
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"注册", nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * actionOne = [UIAlertAction actionWithTitle:NSLocalizedString(@"手机号码", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CSTelRegisterViewController * telVC = [[CSTelRegisterViewController alloc]init];
        [self.navigationController pushViewController:telVC animated:YES];
    }];
    UIAlertAction * actionTwo = [UIAlertAction actionWithTitle:NSLocalizedString(@"邮箱", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CSEmailRegisterViewController * emailVC = [[CSEmailRegisterViewController alloc]init];
        [self.navigationController pushViewController:emailVC animated:YES];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:actionOne];
    [alertVC addAction:actionTwo];
    [alertVC addAction:cancel];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Properties Method

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 75*widthScale;
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.image = [UIImage imageNamed:@"cs_login_icon"];
    }
    return _imageView;
}

- (UIButton*)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:NSLocalizedString(@"注册", nil) forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius = 25.0f;
        _registerBtn.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        _registerBtn.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.6].CGColor;
        [_registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIButton*)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 25.0f;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#3A54FA"];
        [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}


@end
