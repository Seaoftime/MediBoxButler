//
//  FirstPageDetailsViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/11.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "FirstPageDetailsViewController.h"

#import "LRJFirstPageDetailsTableViewCell.h"
#import "MBProgressHUD.h"
#import "LRJBuyMediViewController.h"


@interface FirstPageDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *firstPageDetailsTableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *mediImgView;
@property (nonatomic, strong) UILabel *mediNameLabel;
@property (nonatomic, strong) UILabel *clsNameLabel;
@property (nonatomic, strong) UILabel *priceeLb;



//@property (nonatomic, strong) UIImageView *favoriImgView;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *detailsLabel;


@end

@implementation FirstPageDetailsViewController


- (void)viewWillDisappear:(BOOL)animated
{
    
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"药品详情";
    
    [self.view addSubview:self.firstPageDetailsTableView];
    
    self.firstPageDetailsTableView.tableHeaderView = self.topView;
    
    [self.topView addSubview:self.mediImgView];
    [self.topView addSubview:self.mediNameLabel];
    [self.topView addSubview:self.clsNameLabel];
    [self.topView addSubview:self.priceeLb];
    [self.topView addSubview:self.detailsLabel];
    
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buy) name:@"buy" object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showSuccessWithStatus:@"模拟数据"];
    
        
    });
    
}

#pragma mark - UI -

- (UITableView *)firstPageDetailsTableView
{
    if (_firstPageDetailsTableView == nil) {
        _firstPageDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW,SCREENH - 2)];
        _firstPageDetailsTableView.dataSource = self;
        _firstPageDetailsTableView.delegate = self;
        //
        //_firstPageDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _leftTableView.backgroundColor = [UIColor clearColor];
        
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"LRJFirstPageDetailsTableViewCell" bundle:nil];
        [_firstPageDetailsTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        _firstPageDetailsTableView.backgroundColor = [UIColor whiteColor];
    }
    return _firstPageDetailsTableView;
}

- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 210 - 50)];
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}


- (UIImageView *)mediImgView
{
    if (_mediImgView == nil) {
        _mediImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SCREENW/4 + 10, 70)];
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _mediImgView.backgroundColor = [UIColor whiteColor];
        _mediImgView.image = [UIImage imageNamed:@"view_WpluB"];
        
    }
    return _mediImgView;
}

- (UILabel *)mediNameLabel
{
    if (_mediNameLabel == nil) {
        _mediNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENW/4 + 25, 10, 60, 40)];
        _mediNameLabel.backgroundColor = [UIColor whiteColor];
        _mediNameLabel.text = @"白加黑";
        _mediNameLabel.textColor = [UIColor blackColor];
        _mediNameLabel.textAlignment = NSTextAlignmentCenter;
        [_mediNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    }

    return _mediNameLabel;
}


- (UILabel *)clsNameLabel
{
    if (_clsNameLabel == nil) {
        _clsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENW/4 + 25, 45, SCREENW, 40)];
        _clsNameLabel.backgroundColor = [UIColor whiteColor];
        _clsNameLabel.text = @"内科药/感冒药  火炬大厦/家电城";
        _clsNameLabel.textColor = [UIColor lightGrayColor];
        _clsNameLabel.textAlignment = NSTextAlignmentLeft;
        _clsNameLabel.font = [UIFont systemFontOfSize:15];

        //[_clsNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    }

    return _clsNameLabel;
}

- (UILabel *)priceeLb
{
    if (_priceeLb == nil) {
        _priceeLb = [[UILabel alloc] initWithFrame:CGRectMake(SCREENW - 100, 20, 100, 40)];
        _priceeLb.backgroundColor = [UIColor clearColor];
        _priceeLb.text = @"¥15-20";
        _priceeLb.textColor = [UIColor lightGrayColor];
        _priceeLb.textAlignment = NSTextAlignmentCenter;
        _priceeLb.font = [UIFont systemFontOfSize:14];
        //[_priceeLb setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    }
    
    return _priceeLb;

}

- (UIButton *)rightBtn
{
    if (_rightBtn == nil) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(SCREENW - 50, 10, 40, 40);
        
        UIImage *collectImg = [[UIImage imageNamed:@"收藏"]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *collectedImg = [[UIImage imageNamed:@"收藏 (1)"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        //[_rightBtn setTitleColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_rightBtn setTintColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0]];
        
        [_rightBtn setBackgroundImage:collectImg
                             forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:collectedImg
                             forState:UIControlStateSelected];
        _rightBtn.selected = NO;
        
        [_rightBtn addTarget:self
                      action:@selector(rightClick:)
            forControlEvents:UIControlEventTouchUpInside];
    }

    return _rightBtn;
}

- (UILabel *)detailsLabel
{
    if (_detailsLabel == nil) {
        _detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, SCREENW - 20, 40)];
        _detailsLabel.backgroundColor = [UIColor whiteColor];
        _detailsLabel.text = @"适用于有感冒的人群使用";
        _detailsLabel.textColor = [UIColor blackColor];
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
        //[_detailsLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        _detailsLabel.font = [UIFont systemFontOfSize:14];
        _detailsLabel.numberOfLines = 0;
        
    }
    
    return _detailsLabel;
}





#pragma mark - tableViewDelegate && dataSource -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    LRJFirstPageDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    
    //设置cell 的选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.backgroundColor = [UIColor clearColor];
    
    
    
    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 100;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


#pragma mark - Event -


- (void)buy
{
    LRJBuyMediViewController *buyVC = [[LRJBuyMediViewController alloc] init];
    [self.navigationController pushViewController:buyVC animated:YES];
    
}

- (void)favoriImgViewTaped
{
    



}



- (void)rightClick:(UIButton *)rightButton {
    
    
    _HUD.mode = MBProgressHUDModeCustomView;
    
    _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
    
    
    if (rightButton.selected == NO) {
        
        _rightBtn.selected = YES;
        _HUD.labelText = @"已收藏";
        
    }else {
    
        _rightBtn.selected = NO;
        _HUD.labelText = @"取消收藏";
    
    
    }
    
    [self.view addSubview:_HUD];
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [_HUD removeFromSuperview];
        
    }];
    
//    if ([_HUD.labelText  isEqualToString: @"已收藏"]) {
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"favoried" object:self];
//    }
    
//    if ((_rightBtn.selected = YES)) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"favoried" object:self];
//    }
//    
//    if ([_HUD.labelText  isEqual: @"取消收藏"]) {
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"favori" object:self];
//    }
    
    
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
