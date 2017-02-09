//
//  LRJFirstPageController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/3/29.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJFirstPageController.h"
#import "FirstPageTableViewCell.h"

#import "FirstPageDetailsViewController.h"
#import "FirsetPageTopDetailsViewController.h"

@interface LRJFirstPageController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *firstPageTableView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *topImageView;
//
@property (nonatomic, strong) UIImageView *topImageView1;
@property (nonatomic, strong) UIImageView *topImageView2;
@property (nonatomic, strong) UIImageView *topImageView3;
@property (nonatomic, strong) UIImageView *topImageView4;
@property (nonatomic, strong) UIImageView *topImageView5;
@property (nonatomic, strong) UIImageView *topImageView6;
@property (nonatomic, strong) UIImageView *topImageView7;
@property (nonatomic, strong) UIImageView *topImageView8;
@property (nonatomic, strong) UIImageView *topImageView9;



@end

@implementation LRJFirstPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title = @"";
    
    
    [self.view addSubview:self.firstPageTableView];
    [self.view addSubview:self.bgImageView];
    
    self.firstPageTableView.tableHeaderView = self.topImageView;
    
    //[self.firstPageTableView addSubview:self.topImageView];
    //
    [self.topImageView addSubview:self.topImageView1];
    [self.topImageView addSubview:self.topImageView2];
    [self.topImageView addSubview:self.topImageView3];
    [self.topImageView addSubview:self.topImageView4];
    [self.topImageView addSubview:self.topImageView5];
    [self.topImageView addSubview:self.topImageView6];
    [self.topImageView addSubview:self.topImageView7];
    [self.topImageView addSubview:self.topImageView8];
    [self.topImageView addSubview:self.topImageView9];
    
    
    
}



#pragma mark - UI -


- (UITableView *)firstPageTableView
{
    if (_firstPageTableView == nil) {
        _firstPageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,20, SCREENW,SCREENH - 22)];
        _firstPageTableView.dataSource = self;
        _firstPageTableView.delegate = self;
        //
//        _leftTableView.showsVerticalScrollIndicator = YES;
        _firstPageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _leftTableView.backgroundColor = [UIColor clearColor];
        
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"FirstPageTableViewCell" bundle:nil];
        [_firstPageTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        _firstPageTableView.backgroundColor = [UIColor whiteColor];
    }
    return _firstPageTableView;
}



- (UIImageView *)bgImageView
{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, 20)];
        _bgImageView.image = [UIImage imageNamed:@"background01"];
        
    }
    return _bgImageView;
}

- (UIImageView *)topImageView
{
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 230)];
        //_topImageView.image = [UIImage imageNamed:@"background01"];
        _topImageView.backgroundColor = [UIColor whiteColor];
        _topImageView.userInteractionEnabled = YES;
    }
    return _topImageView;
}


- (UIImageView *)topImageView1
{
    if (_topImageView1 == nil) {
        _topImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, (SCREENW- 100)/3, 50)];
        _topImageView1.image = [UIImage imageNamed:@"button_01"];
        _topImageView1.backgroundColor = [UIColor redColor];
        
        _topImageView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
        [_topImageView1 addGestureRecognizer:tap];
        
    }
    return _topImageView1;
}

- (UIImageView *)topImageView2
{
    if (_topImageView2 == nil) {
        _topImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50 + (SCREENW- 100)/3, 10, (SCREENW- 100)/3, 50)];
        _topImageView2.image = [UIImage imageNamed:@"button_02"];
        _topImageView2.backgroundColor = [UIColor redColor];
        
        _topImageView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
        [_topImageView2 addGestureRecognizer:tap];
        
    }
    return _topImageView2;
}

- (UIImageView *)topImageView3
{
    if (_topImageView3 == nil) {
        _topImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(80 + 2 * (SCREENW- 100)/3, 10, (SCREENW- 100)/3, 50)];
        _topImageView3.image = [UIImage imageNamed:@"button_03"];
        _topImageView3.backgroundColor = [UIColor redColor];
        
        _topImageView3.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3)];
        [_topImageView3 addGestureRecognizer:tap];
        
    }
    return _topImageView3;
}

- (UIImageView *)topImageView4
{
    if (_topImageView4 == nil) {
        _topImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, (SCREENW- 100)/3, 50)];
        _topImageView4.image = [UIImage imageNamed:@"button_04"];
        _topImageView4.backgroundColor = [UIColor redColor];
        
        _topImageView4.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4)];
        [_topImageView4 addGestureRecognizer:tap];
    }
    return _topImageView4;
}

- (UIImageView *)topImageView5
{
    if (_topImageView5 == nil) {
        _topImageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(50 + (SCREENW- 100)/3, 80, (SCREENW- 100)/3, 50)];
        _topImageView5.image = [UIImage imageNamed:@"button_05"];
        _topImageView5.backgroundColor = [UIColor redColor];
        _topImageView5.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap5)];
        [_topImageView5 addGestureRecognizer:tap];
    
    
    }
    return _topImageView5;
}

- (UIImageView *)topImageView6
{
    if (_topImageView6 == nil) {
        _topImageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(80 + 2 * (SCREENW- 100)/3, 80, (SCREENW- 100)/3, 50)];
        _topImageView6.image = [UIImage imageNamed:@"button_06"];
        _topImageView6.backgroundColor = [UIColor redColor];
    
        _topImageView6.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap6)];
        [_topImageView6 addGestureRecognizer:tap];
    
    }
    return _topImageView6;
}

- (UIImageView *)topImageView7
{
    if (_topImageView7 == nil) {
        _topImageView7 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 160, (SCREENW- 100)/3, 50)];
        _topImageView7.image = [UIImage imageNamed:@"button_07"];
        _topImageView7.backgroundColor = [UIColor redColor];
        
        _topImageView7.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap7)];
        [_topImageView7 addGestureRecognizer:tap];
    }
    return _topImageView7;
}

- (UIImageView *)topImageView8
{
    if (_topImageView8 == nil) {
        _topImageView8 = [[UIImageView alloc] initWithFrame:CGRectMake(50 + (SCREENW- 100)/3, 160, (SCREENW- 100)/3, 50)];
        _topImageView8.image = [UIImage imageNamed:@"button_08"];
        _topImageView8.backgroundColor = [UIColor redColor];
        
        _topImageView8.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap8)];
        [_topImageView8 addGestureRecognizer:tap];
    }
    return _topImageView8;
}

- (UIImageView *)topImageView9
{
    if (_topImageView9 == nil) {
        _topImageView9 = [[UIImageView alloc] initWithFrame:CGRectMake(80 + 2 * (SCREENW- 100)/3, 160, (SCREENW- 100)/3, 50)];
        _topImageView9.image = [UIImage imageNamed:@"button_09"];
        _topImageView9.backgroundColor = [UIColor redColor];
        
        _topImageView9.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap9)];
        [_topImageView9 addGestureRecognizer:tap];
    }
    return _topImageView9;
}

#pragma mark - tableViewDelegate && dataSource -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    FirstPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    
        //设置cell 的选中状态
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.backgroundColor = [UIColor clearColor];

    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    vie.layer.borderWidth = 1.0f;
    vie.layer.borderColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0].CGColor;
    cell.backgroundView = vie;
    
    
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FirstPageDetailsViewController *detailsVC = [[FirstPageDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:detailsVC animated:YES];
    
    
}





#pragma mark - event -
- (void)tap1
{
    FirsetPageTopDetailsViewController *top = [[FirsetPageTopDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:top animated:YES];
    top.title = @"内科药";
}

- (void)tap2
{
    FirsetPageTopDetailsViewController *top = [[FirsetPageTopDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:top animated:YES];
    top.title = @"外用药";
}
- (void)tap3
{
    FirsetPageTopDetailsViewController *top = [[FirsetPageTopDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:top animated:YES];
    top.title = @"儿科药";
}
- (void)tap4
{
    FirsetPageTopDetailsViewController *top = [[FirsetPageTopDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:top animated:YES];
    top.title = @"口服药";
}
- (void)tap5
{
    FirsetPageTopDetailsViewController *top = [[FirsetPageTopDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:top animated:YES];
    top.title = @"中草药";
}
- (void)tap6
{
    FirsetPageTopDetailsViewController *top = [[FirsetPageTopDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:top animated:YES];
    top.title = @"五官科";
}
- (void)tap7
{
    FirsetPageTopDetailsViewController *top = [[FirsetPageTopDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:top animated:YES];
    top.title = @"妇科药";
}
- (void)tap8
{
    FirsetPageTopDetailsViewController *top = [[FirsetPageTopDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:top animated:YES];
    top.title = @"骨伤科";
}
- (void)tap9
{
    FirsetPageTopDetailsViewController *top = [[FirsetPageTopDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:top animated:YES];
    top.title = @"注射剂";
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
