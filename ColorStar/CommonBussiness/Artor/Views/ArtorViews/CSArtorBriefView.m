//
//  CSArtorBriefView.m
//  ColorStar
//
//  Created by gavin on 2020/8/17.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSArtorBriefView.h"
#import <WebKit/WebKit.h>
#import "NSString+CS.h"

@interface CSArtorBriefView ()<WKNavigationDelegate>

@property (nonatomic, strong)WKWebView  * webView;

@end

@implementation CSArtorBriefView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{

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
    
    [self addSubview:self.webView];
    
}

- (void)setContent:(NSString *)content{
    _content = content;
    if (![NSString isNilOrEmpty:_content]) {
        [self.webView loadHTMLString:_content baseURL:nil];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.webView.frame = self.bounds;
    
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='#000000';document.getElementsByTagName('p')[0].style.color='#FFFFFF';" completionHandler:^(id response, NSError * _Nullable error) {
        
    }];
}

@end
