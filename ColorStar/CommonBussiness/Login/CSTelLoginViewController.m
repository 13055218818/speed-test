//
//  CSTelLoginViewController.m
//  ColorStar
//
//  Created by 陶涛 on 2020/8/12.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSTelLoginViewController.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"
#import <Masonry.h>
#import "NSString+CSAlert.h"
#import "NSString+CS.h"
#import "CSNetworkManager.h"
#import "NSString+CS.h"
#import "CSUserModel.h"
#import <YYModel/YYModel.h>
#import "CSLoginManager.h"
#import "CSAPPConfigManager.h"
#import <YYLabel.h>
#import <YYText.h>
#import "CSWebViewController.h"

@interface CSTelLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, assign)CGFloat         leftMargin;

@property (nonatomic, strong)UIImageView   * imageView;

@property (nonatomic, strong)UILabel       * telTitleLabel;

@property (nonatomic, strong)UITextField   * telTextField;

@property (nonatomic, strong)UIView        * firstLine;

@property (nonatomic, strong)UILabel       * codeTitleLable;

@property (nonatomic, strong)UITextField   * codeTextField;

@property (nonatomic, strong)UIButton      * codeBtn;

@property (nonatomic, strong)UIView        * secondLine;

@property (nonatomic, strong)UIButton      * loginBtn;

@property (nonatomic, strong)UIButton      * userProtocalBtn;

@property (nonatomic, strong)YYLabel       * userPrototalLabel;

@end

@implementation CSTelLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = NSLocalizedString(@"彩色世界", nil);
    self.leftMargin = 35*widthScale;

    [self setupViews];
}

- (void)setupViews{
    
    [self.view addSubview:self.imageView];
    
    [self.view addSubview:self.telTitleLabel];
    [self.view addSubview:self.telTextField];
    [self.view addSubview:self.firstLine];
    
    [self.view addSubview:self.codeTitleLable];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.codeBtn];
    [self.view addSubview:self.secondLine];
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.userPrototalLabel];
    [self.view addSubview:self.userProtocalBtn];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(self.leftMargin);
        make.top.mas_equalTo(self.view).offset(100*widthScale);
        make.size.mas_equalTo(CGSizeMake(90*widthScale, 90*widthScale));
    }];
    
    [self.telTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(heightScale*47);
    }];
    
    [self.telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.telTitleLabel.mas_bottom).offset(heightScale*30);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.telTextField.mas_bottom).offset(10*heightScale);
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
        if ([CSAPPConfigManager sharedConfig].languageType == CSAPPLanuageTypeCN) {
            make.width.mas_equalTo(90);
        }else{
            make.width.mas_equalTo(150);
        }
    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.codeTextField.mas_bottom).offset(10*heightScale);
        make.height.mas_equalTo(1/[UIScreen mainScreen].scale);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
    }];
    
    
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self.view).offset(-self.leftMargin);
        make.top.mas_equalTo(self.secondLine.mas_bottom).offset(heightScale*60);
        make.height.mas_equalTo(50);
    }];
    
    [self.userPrototalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.loginBtn);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(10);
    }];
    
    [self.userProtocalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.userPrototalLabel);
        make.right.mas_equalTo(self.userPrototalLabel.mas_left).offset(-5);
        make.width.height.mas_equalTo(15);
    }];
}

#pragma mark Action Method

- (void)queryCode:(UIButton*)sender{
    NSString * toast = @"";
    if ([NSString isNilOrEmpty:self.telTextField.text]) {
        toast = NSLocalizedString(@"请输入手机号码", nil);
        [toast showAlert];
        return;
    }
    [self startTimer];
    [[CSNetworkManager sharedManager] quaryCodeWithType:CSRegisterTypeTelephone account:self.telTextField.text successComplete:^(CSNetResponseModel *response) {
        
        [NSLocalizedString(@"验证码发送成功", nil) showAlert];
        
    } failureComplete:^(NSError *error) {
        
    }];
    
    
}

- (void)loginClick{
    
    NSString * toast = @"";
    if ([NSString isNilOrEmpty:self.telTextField.text]) {
        toast = NSLocalizedString(@"请输入手机号码", nil);
        [toast showAlert];
        return;
    }
    if ([NSString isNilOrEmpty:self.codeTextField.text]) {
        toast = NSLocalizedString(@"请输入验证码", nil);
        [toast showAlert];
        return;
    }
    
    if (!self.userProtocalBtn.selected) {
        toast = NSLocalizedString(@"请勾选同意用户协议", nil);
        [toast showAlert];
        return;
    }
    
    CS_Weakify(self, weakSelf);
    [[CSNetworkManager sharedManager] loginWithType:CSRegisterTypeTelephone account:self.telTextField.text password:@"" code:self.codeTextField.text successComplete:^(CSNetResponseModel *response) {
        
        id object = (NSDictionary*)response.data;
        NSDictionary * data;
        if ([object isKindOfClass:[NSDictionary class]]) {
            data = (NSDictionary*)object;
        }
        if (data.count > 0) {
            NSDictionary * userInfo = [data valueForKey:@"userinfo"];
            CSUserModel * user = [CSUserModel yy_modelWithDictionary:userInfo];
            NSString * sessionkey = [data valueForKey:@"sessionkey"];
            [[CSAPPConfigManager sharedConfig] storeSessionKey:sessionkey];
            [CSLoginManager sharedManager].userInfo = user;
            if (self.complete) {
                self.complete(YES, nil);
            }
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];

        }else{
            
            [@"验证码错误" showAlert];
            if (self.complete) {
                self.complete(NO, @"登陆失败");
            }
        }
        
    } failureComplete:^(NSError *error) {
        
        [@"登陆失败,请稍后再试" showAlert];
        if (self.complete) {
            self.complete(NO, @"登陆失败");
        }
    }];
    
    
}

#pragma mark Private Method

- (void)startTimer{
    
    __block NSInteger time = 60; //倒计时时间
    
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
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%.2d秒", seconds] forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
}

- (void)protocalSelcte:(UIButton*)sender{
    sender.selected = !sender.selected;
}

- (void)enterUserProtocal{
    
    CSWebViewController * webVC = [[CSWebViewController alloc]init];
    webVC.title = NSLocalizedString(@"用户协议", nil);
    webVC.content = [CSAPPConfigManager sharedConfig].userProtocal;
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}
#pragma mark - Properties Method

- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 45*widthScale;
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.image = [UIImage imageNamed:@"cs_login_icon"];
    }
    return _imageView;
}

- (UILabel*)telTitleLabel{
    if (!_telTitleLabel) {
        _telTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _telTitleLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.38];
        _telTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        _telTitleLabel.text = NSLocalizedString(@"手机号码", nil);
    }
    return _telTitleLabel;
}

- (UITextField*)telTextField{
    if (!_telTextField) {
        _telTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        _telTextField.delegate = self;
        _telTextField.font = [UIFont systemFontOfSize:22.0f];
        _telTextField.textColor = [UIColor whiteColor];
        _telTextField.placeholder = NSLocalizedString(@"请输入手机号码", nil);
        [_telTextField setValue:[UIColor colorWithWhite:1.0 alpha:0.12] forKeyPath:@"placeholderLabel.textColor"];
        
    }
    return _telTextField;
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
        _codeTitleLable.text = NSLocalizedString(@"手机验证码", nil);
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

- (UIButton*)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.87] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 25;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#3A54FA"];
        [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton*)userProtocalBtn{
    if (!_userProtocalBtn) {
        _userProtocalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_userProtocalBtn setImage:[UIImage imageNamed:@"cs_login_protocal_normal"] forState:UIControlStateNormal];
        [_userProtocalBtn setImage:[UIImage imageNamed:@"cs_login_protocal_selected"] forState:UIControlStateSelected];
        [_userProtocalBtn addTarget:self action:@selector(protocalSelcte:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userProtocalBtn;
}

- (YYLabel*)userPrototalLabel{
    if (!_userPrototalLabel) {
        CS_Weakify(self, weakSelf);
        _userPrototalLabel = [[YYLabel alloc]initWithFrame:CGRectZero];
        NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#606060"]};
        NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#3953F9"]};
        NSInteger userProtocolLength = [CSAPPConfigManager sharedConfig].languageType == CSAPPLanuageTypeCN ? 6 : 16;
        NSString * originText = NSLocalizedString(@"登录即视为您已阅读并同意《用户协议》", nil);
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:originText];
        [text addAttributes:attributes1 range:NSMakeRange(0, originText.length - userProtocolLength)];
        [text addAttributes:attributes2 range:NSMakeRange(originText.length - userProtocolLength, userProtocolLength)];
        //设置高亮色和点击事件
        [text yy_setTextHighlightRange:NSMakeRange(originText.length - userProtocolLength, userProtocolLength) color:nil backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            [weakSelf enterUserProtocal];
        }];
        _userPrototalLabel.attributedText = text;
    }
    return _userPrototalLabel;
}

@end
