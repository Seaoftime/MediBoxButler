//
//  LRJHealthyKnowledgeScienceViewController.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/7/16.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJHealthyKnowledgeScienceViewController.h"

#import <WebKit/WebKit.h>

#import "LRJUserNotification.h"
#import "LRJNotificatiTableViewCell.h"
#import "LRJUserNotificationModdel.h"


@interface LRJHealthyKnowledgeScienceViewController ()<WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate, UITableViewDataSource,UITableViewDelegate>
{
    WKWebView *_webView;
    UIProgressView *_progressView;
    
    
}
@property (nonatomic, strong) MBProgressHUD *HUD;
//测试
@property (nonatomic, strong) UIButton *testBtn;
@property (nonatomic, strong) UITableView *mediTakeinTableView;
@property (nonatomic, strong) NSArray *notiArray;


@end

@implementation LRJHealthyKnowledgeScienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    self.title = @"家庭健康知识";//标题  推送内容  推送时间
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    
    //[self createWebView];
    
    
    //_HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    
    
    
    
    
    self.notiArray = [LRJUserNotificationModdel findAll];
    
    [self.view addSubview:self.mediTakeinTableView];
    
    
    [self.view addSubview:self.testBtn];

    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.notiArray = [LRJUserNotificationModdel findAll];
    
    
    [self.mediTakeinTableView reloadData];

}


- (UITableView *)mediTakeinTableView
{
    if (_mediTakeinTableView == nil) {
        
        _mediTakeinTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        _mediTakeinTableView.backgroundColor = [UIColor clearColor];
        _mediTakeinTableView.delegate = self;
        _mediTakeinTableView.dataSource = self;
        _mediTakeinTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"LRJNotificatiTableViewCell" bundle:nil];
        [_mediTakeinTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        
    }
    return _mediTakeinTableView;
}





#pragma mark - delegate && dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.notiArray.count;
    //return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LRJNotificatiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, SCREENW, 1)];
    vi.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [cell addSubview:vi];
    
    
    LRJUserNotificationModdel *model = [self.notiArray objectAtIndex:indexPath.row];
    
    
    cell.notiTitleLb.text = model.nofi_title;
    
    cell.notiBodyLb.text = model.nofi_body;
    
    cell.notiTimeLb.text = model.nofi_data;
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 85;
    //return SCREENH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
    
}









- (UIButton *)testBtn
{
    if (_testBtn == nil) {
        
        _testBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENW - 60 - 30, SCREENH - 100, 60, 60)];
        
        _testBtn.backgroundColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
        [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _testBtn.layer.cornerRadius = 20;
        _testBtn.layer.masksToBounds = YES;
        
        [_testBtn setTitle:@"点击推送" forState:UIControlStateNormal];
        _testBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_testBtn addTarget:self action:@selector(_testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
    
}


- (void)_testBtnClicked
{

    [[LRJUserNotification sharedNotification] addNotificationWithTimeIntervalTrigger];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        [self viewWillAppear:NO];//刷新界面
    });
    
    
    
    //周期性的推送
    //[[LRJUserNotification sharedNotification] addNotificationWithCalendarTrigger];
    
    
    
    
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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.fhs.gov.hk/sc_chi/"]];
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
