//
//  CSWebViewController.m
//  ColorStar
//
//  Created by gavin on 2020/8/6.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSWebViewController.h"
#import <WebKit/WebKit.h>
#import "NSString+CS.h"

@interface CSWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,strong)WKWebView  * webView;
@property(nonatomic, strong)UIView                      *navView;

@end

@implementation CSWebViewController
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self deleteWebCache];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#181F30"];
    [self makeNavUI];
    if (![NSString isNilOrEmpty:self.url]) {
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
        webConfiguration.userContentController = wkUController;
        self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webConfiguration];
       
        NSString * urlStr = [self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        self.webView.allowsBackForwardNavigationGestures = YES;
        [self.webView loadRequest:request];
        self.webView.navigationDelegate = self;
        [self.view addSubview:self.webView];
        [webConfiguration.userContentController addScriptMessageHandler:self name:@"payAfter"];
        [webConfiguration.userContentController addScriptMessageHandler:self name:@"backToApp"];
        
    }else if (![NSString isNilOrEmpty:self.content]){
        
        //js脚本 （脚本注入设置网页样式）
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
           //注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];

        WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
        config.userContentController = wkUController;
        
        self.webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
        self.webView.navigationDelegate = self;
        self.webView.backgroundColor = [UIColor blackColor];
        [self.webView loadHTMLString:self.content baseURL:nil];
        [self.view addSubview:self.webView];
    
    }
    if (self.titleStr.length > 0) {
        self.webView.frame = CGRectMake(0, kStatusBarHeight + 44.0*heightScale, ScreenW, ScreenH-kStatusBarHeight - 44.0*heightScale);
    }else{

        self.webView.frame = CGRectMake(0, kStatusBarHeight, ScreenW, ScreenH-kStatusBarHeight);
    }
    
    
}
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
    titleLabel.text = self.titleStr;
    titleLabel.font = kFont(18);
    titleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navView.mas_centerX);
        make.centerY.mas_equalTo(backButton.mas_centerY);
        make.left.mas_equalTo(self.view.mas_left).offset(50);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
    }];
}

- (void)back{
    if (self.isPresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)deleteWebCache {
//allWebsiteDataTypes清除所有缓存
 NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];

    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];

    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:@"payAfter"]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];

        NSInteger  code = [dict[@"code"] integerValue];
        NSInteger type= [dict[@"type"] integerValue];
        //type : 1:会员卡2:充值3:视频4:商品
        if (code != 200) {
            //支付失败
            if (self.payBlock) {
                self.payBlock(NO);
            }
        }else{
            //支付成功
            if (self.payBlock) {
                self.payBlock(YES);
            }
        }
        
        switch (type) {
            case 1:
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            case 2:
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            case 3:
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            case 4:
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
                
            default:
                break;
        }
        
        
    }else if([message.name isEqualToString:@"backToApp"]){
        if (self.isPresent) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

// 决定导航的动作，通常用于处理跨域的链接能否导航。
// WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接单独处理。
// 但是，对于Safari是允许跨域的，不用这么处理。
// 这个是决定是否Request
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    //  在发送请求之前，决定是否跳转
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *urlStr = navigationAction.request.URL.absoluteString;
    if ([urlStr containsString:@"noncestr="] || [urlStr containsString:@"fromAppUrlScheme"]) {
        NSURL* jumpURL = [NSURL URLWithString:urlStr];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:jumpURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                
            }];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:jumpURL];
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 是否接收响应
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    // 在收到响应后，决定是否跳转和发送请求之前那个允许配套使用
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//用于授权验证的API，与AFN、UIWebView的授权验证API是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler{
    
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling ,nil);
}

// main frame的导航开始请求时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
   
}

// 当main frame接收到服务重定向时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    // 接收到服务器跳转请求之后调用
}

// 当main frame开始加载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {

}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//当main frame导航完成时，会回调
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    // 页面加载完成之后调用
}

// 当main frame最后下载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

// 当web content处理完成时，会回调
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}


@end
