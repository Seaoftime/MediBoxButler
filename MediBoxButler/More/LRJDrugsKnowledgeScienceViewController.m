//
//  LRJDrugsKnowledgeScienceViewController.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/7/16.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJDrugsKnowledgeScienceViewController.h"

#import <WebKit/WebKit.h>

@interface LRJDrugsKnowledgeScienceViewController ()<WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate>
{
    WKWebView *_webView;
    UIProgressView *_progressView;


}

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation LRJDrugsKnowledgeScienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    self.title = @"药品知识科普";
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    [self createWebView];
    
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    
}

#pragma mark - UI 
- (void)createWebView {
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 2)];
    //_progressView.progressTintColor = [UIColor yellowColor];
    _progressView.trackTintColor = [UIColor whiteColor];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(webTouched:)];
    //[_webView addGestureRecognizer:tap];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baike.baidu.com/link?url=B0GsLper7d40VjyauJRR-cs1jnddMgzmBm0geY3EqODLAGE3IMAuLMapo3EeIWpH-2yrDH_d7p2Ycpdl2EY4va"]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    [self.view addSubview:_progressView];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [_progressView setProgress:_webView.estimatedProgress animated:YES];
    if (_progressView.progress >= 1.0) {
        _progressView.hidden = YES;
        [_progressView setProgress:0.0 animated:YES];
        
//很麻烦 还是 SVProgressHUD 简单
        _HUD.mode = MBProgressHUDModeCustomView;
        
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];

        _HUD.labelText = @"模拟数据";

        [self.view addSubview:_HUD];
        
        [_HUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            [_HUD removeFromSuperview];
            
        }];
        
        
        //[SVProgressHUD showSuccessWithStatus:@"模拟数据"];
        
    }else {
        _progressView.hidden = NO;
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}



- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
