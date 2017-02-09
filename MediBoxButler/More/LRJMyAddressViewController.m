//
//  LRJMyAddressViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/27.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJMyAddressViewController.h"


#import "LRJAddAddressViewController.h"
#import "LRJAddAddressTableViewCell.h"
#import "LRJAddAddressDBModel.h"


@interface LRJMyAddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) NSArray *addressArray;
@property (nonatomic, strong) UILabel *noAddressLb;

@property (nonatomic, strong) UITableView *addressTableView;

@end

@implementation LRJMyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    self.title = @"我的地址";
    
    [self customNavigationRightBarItems];
    [self.view addSubview:self.noAddressLb];
    [self.view addSubview:self.addressTableView];
    //
//    self.addressArray = [[NSMutableArray alloc] init];
    
    
//    NSString *s = [NSUserDefaults standardUserDefaults].address_Name;
//    if (s == nil || s == NULL || [s isKindOfClass:[NSNull class]]) {
//        
//        
//    }else {
//     
//        [self.addressArray addObject:@"address"];
//    }
    
    //LRJAddAddressDBModel *modell = [[LRJAddAddressDBModel alloc] init];
    
    self.addressArray = [LRJAddAddressDBModel findAll];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ///[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add) name:@"addAddress" object:nil];
    
    
    self.addressArray = [LRJAddAddressDBModel findAll];

    if (self.addressArray.count == 0) {
     
        self.noAddressLb.hidden = NO;
    }else {
    
        self.noAddressLb.hidden = YES;
    
    }
    
    [self.addressTableView reloadData];
}



- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - UI -
- (void)customNavigationRightBarItems
{
    
    self.addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 25, 25)];
    //_addImageView.backgroundColor = [UIColor blackColor];
    UIImage *img = [[UIImage imageNamed:@"iconfont-jiahao (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.addImageView.image = img;
    self.addImageView.tintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    self.addImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTap)];
    [self.addImageView addGestureRecognizer:tap];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.self.addImageView];
    
    self.navigationItem.rightBarButtonItem = item;


}

- (UILabel *)noAddressLb
{
    if (_noAddressLb == nil) {
        _noAddressLb = [[UILabel alloc] initWithFrame:CGRectMake(SCREENW/2 - 150, SCREENH/2 - 40, 300, 40)];
        _noAddressLb.text = @"点击右上角添加地址";
        //[_userNameLb sizeToFit];
        _noAddressLb.textAlignment = NSTextAlignmentCenter;
        
        _noAddressLb.textColor = [UIColor blackColor];
        _noAddressLb.font = [UIFont systemFontOfSize:17];
        
    }
    
    return _noAddressLb;

}



- (UITableView *)addressTableView
{
    if (_addressTableView == nil) {
        
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH)];
        _addressTableView.backgroundColor = [UIColor clearColor];
        _addressTableView.delegate = self;
        _addressTableView.dataSource = self;
        _addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"LRJAddAddressTableViewCell" bundle:nil];
        [_addressTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        
    }
    return _addressTableView;
}



#pragma mark - delegate && dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.addressArray.count;
    //return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LRJAddAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, SCREENW, 1)];
    vi.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [cell addSubview:vi];
    
    LRJAddAddressDBModel *modell = [self.addressArray objectAtIndex:indexPath.row];
    cell.nameLb.text = modell.userName;
    cell.telphoneLb.text = modell.userMobile;
    cell.detailsAddressLb.text = [NSString stringWithFormat:@"%@  %@",modell.userAddress,modell.userDetailsAddress];
    [cell.editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;
    
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = indexPath.row;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    //return SCREENH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });

}





#pragma mark - event -
- (void)addressTap
{
    LRJAddAddressViewController *addVC = [[LRJAddAddressViewController alloc] init];
    
    addVC.title = @"添加地址";
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    
}


- (void)editBtnClicked:(UIButton *)editBtn
{
    LRJAddAddressDBModel *modell = [self.addressArray objectAtIndex: editBtn.tag];
    LRJAddAddressViewController *addAddressVC = [[LRJAddAddressViewController alloc] init];
    
    addAddressVC.title = @"编辑地址";
    
    addAddressVC.nameTF.text = modell.userName;
    addAddressVC.phoneTF.text = modell.userMobile;
    addAddressVC.addressLabel.text = modell.userAddress;
    addAddressVC.addressDetailTF.text = modell.userDetailsAddress;
    
    
    [self.navigationController pushViewController:addAddressVC animated:YES];
    

}

- (void)deleteBtnClicked:(UIButton *)deleteBtn
{
    LRJAddAddressDBModel *modell = [self.addressArray objectAtIndex: deleteBtn.tag];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [modell deleteObject];
//    });
    
    [modell deleteObject];
    
    
    self.addressArray = [LRJAddAddressDBModel findAll];
    
    if (self.addressArray.count == 0) {
        
        self.noAddressLb.hidden = NO;
    }else {
        
        self.noAddressLb.hidden = YES;
        
    }
    
    [self.addressTableView reloadData];

    
    
    [SVProgressHUD showSuccessWithStatus:@"已删除"];
    
    
    
    
    
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
