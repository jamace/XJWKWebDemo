//
//  ViewController.m
//  XJWebDemo
//
//  Created by wodun on 2018/5/3.
//  Copyright © 2018年 com.wodun. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
//#import "JKEventHandler+XJHandler.h"
#import "JKWKWebViewHandler.h"
#import "JKEventHandler+XJWebHandler.h"
@interface ViewController ()<WKNavigationDelegate,WKUIDelegate
>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWeb];
}

-(void)initWeb
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    WKUserScript *usrScript = [[WKUserScript alloc] initWithSource:[JKEventHandler shareInstance].handlerJS injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    
    [config.userContentController addUserScript:usrScript];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:[JKEventHandler shareInstance] name:EventHandler];
    
    NSString *url = [NSString stringWithFormat:@"file://%@",[[NSBundle mainBundle] pathForResource:@"active" ofType:@"html"]];
    //通过默认的构造器来创建对象
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                  configuration:config];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:_webView];
    
    [JKEventHandler getInject:_webView];
    
    // 导航代理
    _webView.navigationDelegate = self;
    // 与webview UI交互代理
    _webView.UIDelegate = self;
}
- (void)dealloc{
    
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:EventHandler];
    [_webView evaluateJavaScript:@"JKEventHandler.removeAllCallBacks();" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
    }];//删除所有的回调事件
    
}
@end
