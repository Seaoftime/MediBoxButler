//
//  FirsetPageTopDetailsViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/12.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "FirsetPageTopDetailsViewController.h"

#import "LRJBuyMediViewController.h"

#import "FiltrateView.h"
#import "FirstPageTableViewCell.h"
#import "LRJMediDetailsTableViewCell.h"


@interface FirsetPageTopDetailsViewController ()<FiltrateViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *topDetailsTableView;

@end

@implementation FirsetPageTopDetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //
    //
    NSArray *titleArr = @[@"药品类别",@"药品价格",@"综合排序"];
    NSArray *firstDataArr = @[@"内科药",@"外用药",@"儿科药",@"口服药",@"中草药",@"五官科",@"妇科药",@"骨伤科",@"注射剂"];
    NSArray *secondDataArr = @[@"0 - 20元",@"20 - 50元",@"50 - 100元",@"100 - 200元",@"200元以上"];
    NSArray *thirdDataArr = @[@"好评度",@"热卖",@"销量"];
    NSArray *dataArr = @[firstDataArr,secondDataArr,thirdDataArr];
    
    
    FiltrateView *filtreteView = [[FiltrateView alloc]initWithCount:3 withTitleArr:titleArr withDataArr:dataArr];
    filtreteView.frame = CGRectMake(0, 64, SCREENW, 44);
    filtreteView.backgroundColor = [UIColor lightGrayColor];
    filtreteView.delegate = self;
//    [self.view addSubview:filtreteView];
    
    [self.view addSubview:self.topDetailsTableView];
    [self.view addSubview:filtreteView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showSuccessWithStatus:@"模拟数据"];
        
        
    });
    
}

//返回所点击内容
- (void)completionArr:(NSArray *)dataArr
{
    for (NSString *str in dataArr) {
        
        
        NSLog(@"%@",str);
    }
}

#pragma mark - UI -


- (UITableView *)topDetailsTableView
{
    if (_topDetailsTableView == nil) {
        _topDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREENW,SCREENH - 44)];
        _topDetailsTableView.dataSource = self;
        _topDetailsTableView.delegate = self;
        
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"LRJMediDetailsTableViewCell" bundle:nil];
        [_topDetailsTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        _topDetailsTableView.backgroundColor = [UIColor whiteColor];
    }
    return _topDetailsTableView;
}





#pragma mark - tableViewDelegate && dataSource -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    LRJMediDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    
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
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
