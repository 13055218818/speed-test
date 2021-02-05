//
//  CSMallViewController.m
//  ColorStar
//
//  Created by gavin on 2020/9/25.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSMallViewController.h"
#import "CSColorStar.h"
#import "CSEmptyRefreshView.h"
#import <MBProgressHUD.h>
#import <WebKit/WebKit.h>
#import "NSString+CS.h"
//#import "UIView+CS.h"
#import "CSColorStar.h"
#import "UIColor+CS.h"

@interface CSMallViewController ()<WKNavigationDelegate>

@property (nonatomic, strong)WKWebView * webView;

@property (nonatomic, strong)NSString  * content;

@end

@implementation CSMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#121212"];
    self.view.layer.masksToBounds = YES;
//    self.url = @"https://m.icolorstar.com/wap/test/index";
//    self.url = @"https://m.icolorstar.com/wap/store/index.html";
    if (![NSString isNilOrEmpty:self.url]) {
        WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
        self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webConfiguration];
        self.webView.backgroundColor = [UIColor colorWithHexString:@"#121212"];
        NSString *urlStr = self.url;
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//        [request addValue:@"Html5Plus" forHTTPHeaderField:@"User-Agent"];
        [request setValue:@"iOS" forHTTPHeaderField:@"type"];
        self.webView.allowsBackForwardNavigationGestures = YES;
        [self.webView loadRequest:request];
        self.webView.navigationDelegate = self;
        [self.view addSubview:self.webView];
    }else if (![NSString isNilOrEmpty:self.content]){
        
        //js脚本 （脚本注入设置网页样式）
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
           //注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];

        WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
        config.userContentController = wkUController;
        self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
        self.webView.navigationDelegate = self;
        self.webView.backgroundColor = [UIColor blackColor];
        [self.webView loadHTMLString:self.content baseURL:nil];
        [self.view addSubview:self.webView];
        
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.webView.frame = CGRectMake(0, 0, self.view.width, self.view.height + 60);
}



// 决定导航的动作，通常用于处理跨域的链接能否导航。
// WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接单独处理。
// 但是，对于Safari是允许跨域的，不用这么处理。
// 这个是决定是否Request

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
