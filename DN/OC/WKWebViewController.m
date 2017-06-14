//
//  WKWebViewController.m
//  +
//
//  Created by shensu on 17/5/4.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "WebViewXib.h"
#import "Masonry.h"
#import "DN-swift.h"
@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>
    @property(strong,nonatomic) WKWebView * wkwebView;
    @property(nonatomic,strong) UILabel * lable;
    @property(nonatomic,strong) WebViewXib * footview;
    
    @end

@implementation WKWebViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.wkwebView = [[WKWebView alloc] init];
    [self.wkwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.wkwebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    self.wkwebView.UIDelegate = self;
    self.wkwebView.navigationDelegate = self;
    [self.view addSubview:self.wkwebView];
    if (_isAddFoot) {
        [self.wkwebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 49, 0));
        }];
        [self addFoot];
    }else{
        [self.wkwebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
        }];
    }
    
}
-(void)addFoot{
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    self.lable.center = self.view.center;
    self.lable.font  = [UIFont systemFontOfSize:14];
    self.lable.textAlignment = NSTextAlignmentCenter;
    self.lable.textColor = [UIColor grayColor];
    [self.view addSubview: self.lable];
    
    
    _footview = [[WebViewXib alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49)];
    [self.view addSubview:_footview];
    
    __weak __typeof (self) weak = self;
    _footview.WebViewBlock = ^(NSInteger tag){
        switch (tag) {
            case 1:
            if ([weak.wkwebView canGoBack]){
                [weak.wkwebView goBack];
            }
            break;
            case 2:
            [weak.wkwebView reload];
            
            break;
            case 3 :
            if ([weak.wkwebView canGoForward]){
                [weak.wkwebView goForward];
            }
            default:
            [weak.wkwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weak.url]]];
            break;
        }
    };
    
}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//    {
//        NSURL *requestURL = navigationAction.request.URL;
//        if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ]) && navigationAction.navigationType == UIWebViewNavigationTypeLinkClicked) {
//            [[UIApplication sharedApplication] openURL:requestURL options:@{} completionHandler:nil];
//            decisionHandler(WKNavigationActionPolicyCancel);
//        }
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
    {
        
        [self showLoadingView];
    }
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self hideLoadingView];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
    {
        [self hideLoadingView];
    }
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 接口的作用是打开新窗口委托
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    
//    NSURL *requestURL = navigationAction.request.URL;
//    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])) {
//        [[UIApplication sharedApplication] openURL:requestURL options:@{} completionHandler:nil];
//        
//    }
    
    return nil;
}
    
-(void)useProgressView
    {
        [self.wkwebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
    }
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
    {
        
        if ( [keyPath isEqualToString:@"estimatedProgress"]){
            double leng = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            NSString * str = [NSString stringWithFormat:@"%.2f",leng*100];
            str = [str stringByAppendingString:@"%"];
            self.lable.text = [NSString stringWithFormat:@"正在初始化配置信息%@",str];
            if ([[change objectForKey:NSKeyValueChangeNewKey] doubleValue] == 1) {
                [UIView animateWithDuration:1 animations:^{
                    [self.lable setAlpha:0];
                }];
                
            }
        }
    }
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * defa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alert addAction:defa];
    [self presentViewController:alert animated:true completion:nil];
}
    
    //web界面中有弹出确定框时调用
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * defa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(true);
    }];
    UIAlertAction * cancl = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    [alert addAction:defa];
    [alert addAction:cancl];
    [self presentViewController:alert animated:true completion:nil];
    
}
    
    
    
-(void)dealloc
    {
        if (self.wkwebView.observationInfo){
            [self.wkwebView removeObserver:self forKeyPath:@"estimatedProgress"];
        }
        
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    // 无窗版
    
    NSString * authenticationMethod = [[challenge protectionSpace] authenticationMethod];
    
    if ([authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        NSURLCredential *credential = [[NSURLCredential     alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        
    }
    
    
}
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    @end
