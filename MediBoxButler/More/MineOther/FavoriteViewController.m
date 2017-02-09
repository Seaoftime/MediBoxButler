//
//  FavoriteViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/7.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "FavoriteViewController.h"

#import "FirstPageTableViewCell.h"

@interface FavoriteViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *favoriteTableView;

@property (nonatomic, strong) NSMutableArray *favoriArray;
@property (nonatomic)         NSInteger aryCount;

@end

@implementation FavoriteViewController


- (void)viewWillDisappear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    [self customNavigationLeftBarItems];
    
    [self.view addSubview:self.favoriteTableView];
    
    self.favoriArray = [[NSMutableArray alloc] initWithObjects:@"xx",@"xx", nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addFavorite) name:@"favoried" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subFavorite) name:@"favori" object:nil];
    
    self.aryCount = 10;
    
}


#pragma mark - UI -


- (void)customNavigationLeftBarItems
{
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 8, 25, 25)];
    imgV.image = [UIImage imageNamed:@"iconfont-fanhui"];
    
    //imgV.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:imgV];
    
    self.navigationItem.leftBarButtonItem = item;
    
    imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backk)];
    
    [imgV addGestureRecognizer:tap];
    
}


- (UITableView *)favoriteTableView
{
    if (_favoriteTableView == nil) {
        
        _favoriteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        _favoriteTableView.backgroundColor = [UIColor clearColor];
        _favoriteTableView.delegate = self;
        _favoriteTableView.dataSource = self;
        _favoriteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"FirstPageTableViewCell" bundle:nil];
        [_favoriteTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        
        
        
    }
    return _favoriteTableView;
}


#pragma mark - delegate && dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //return self.favoriArray.count;
    return self.aryCount - 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    FirstPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    //设置cell 的选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 100;
    
}




#pragma mark - event -

- (void)backk
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self pop];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addFavorite
{
    //self.favoriArray.count = 1;

    //[self.favoriArray addObject:@"xxx"];
    self.aryCount += 1;


}


- (void)subFavorite
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
