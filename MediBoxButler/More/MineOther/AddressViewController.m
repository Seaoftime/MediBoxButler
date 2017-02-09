//
//  AddressViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/7.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "AddressViewController.h"


#import "AddressTableViewCell.h"


@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *addressTableView;

@property (nonatomic, strong) UIImageView *bgImageView1;
@property (nonatomic, strong) UIImageView *bgImageView2;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UILabel *addLabel;
@property (nonatomic, strong) UIView *bgV;
@property (nonatomic, strong) UIView *bgV1;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *alertLabel;
@property (nonatomic, strong) UITextField *telTF;
@property (nonatomic, strong) UITextField *addressTF;
@property (nonatomic, strong) UIButton *sureButton;


@end

@implementation AddressViewController


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.bgV removeFromSuperview];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    self.title = @"我的所在地";
    [self customNavigationLeftBarItems];
    
    [self.view addSubview:self.addressTableView];
    self.addressTableView.tableHeaderView = self.bgImageView1;
    
    
    //[self.addressTableView addSubview:self.bgImageView1];
    [self.bgImageView1 addSubview:self.bgImageView2];
    [self.bgImageView2 addSubview:self.addImageView];
    [self.bgImageView2 addSubview:self.addLabel];
    
    //
    //
    self.bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH/2)];
    self.bgV.backgroundColor = [UIColor blackColor];
    self.bgV.alpha = 0.7;
    //
    self.bgV1 = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENH/2, SCREENW, SCREENH/2)];
    self.bgV1.backgroundColor = [UIColor whiteColor];
    
    self.alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENW/2 - 50, 12, 100, 40)];
    self.alertLabel.backgroundColor = [UIColor whiteColor];
    self.alertLabel.text = @"添加地址";
    self.alertLabel.textAlignment = NSTextAlignmentCenter;
    self.alertLabel.font = [UIFont systemFontOfSize:17];
    
    self.telLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 62, 80, 40)];
    self.telLabel.backgroundColor = [UIColor whiteColor];
    self.telLabel.text = @"手机号：";
    self.telLabel.font = [UIFont systemFontOfSize:14];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 114, 80, 40)];
    self.addressLabel.backgroundColor = [UIColor whiteColor];
    self.addressLabel.text = @"地址：";
    self.addressLabel.font = [UIFont systemFontOfSize:17];
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENW/2 - 50, SCREENH/2 - 80, 100, 40)];
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    //[self.sureButton setTintColor:[UIColor blackColor]];
    [self.sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bgV1 addSubview:self.alertLabel];
    [self.bgV1 addSubview:self.telLabel];
    [self.bgV1 addSubview:self.addressLabel];
    [self.bgV1 addSubview:self.sureButton];
    
    
    
    
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


- (UITableView *)addressTableView
{
    if (_addressTableView == nil) {
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW,SCREENH)];
        
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
        //
        //        _leftTableView.showsVerticalScrollIndicator = YES;
        _addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _leftTableView.backgroundColor = [UIColor clearColor];
        
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"AddressTableViewCell" bundle:nil];
        [_addressTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        _addressTableView.backgroundColor = [UIColor clearColor];
    }
    return _addressTableView;
}




- (UIImageView *)bgImageView1
{
    if (_bgImageView1 == nil) {
        _bgImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, SCREENW, 84)];
        _bgImageView1.backgroundColor = [UIColor clearColor];
        
        //
        _bgImageView1.userInteractionEnabled = YES;
        
    }
    return _bgImageView1;
}


- (UIImageView *)bgImageView2
{
    if (_bgImageView2 == nil) {
        _bgImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREENW, 44)];
        _bgImageView2.backgroundColor = [UIColor whiteColor];
        _bgImageView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTap)];
        [_bgImageView2 addGestureRecognizer:tap];
        
    }
    return _bgImageView2;
}


- (UIImageView *)addImageView
{
    if (_addImageView == nil) {
        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 30, 30)];
        //_addImageView.backgroundColor = [UIColor blackColor];
        UIImage *img = [[UIImage imageNamed:@"iconfont-jiahao (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _addImageView.image = img;
        _addImageView.tintColor = [UIColor colorWithRed:250/255.0 green:50/255.0 blue:45/255.0 alpha:1.0];
        
        //
        _addImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTap)];
        [_addImageView addGestureRecognizer:tap];

        
    }
    return _addImageView;
}

- (UILabel *)addLabel
{
    if (_addLabel == nil) {
        _addLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 80, 34)];
        _addLabel.text = @"新增地址";
        _addLabel.textColor = [UIColor colorWithRed:250/255.0 green:50/255.0 blue:45/255.0 alpha:1.0];
        _addLabel.textAlignment = NSTextAlignmentLeft;
        _addLabel.font = [UIFont systemFontOfSize:15];
        _addLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTap)];
        [_addLabel addGestureRecognizer:tap];

    }
    return _addLabel;
}




#pragma mark - delegate -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    
    //设置cell 的选中状态
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return 15;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 90;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}













#pragma mark - event -

- (void)backk
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self pop];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addressTap
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgV];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgV1];


}

- (void)sureButtonClick
{
    [self.bgV removeFromSuperview];
    [self.bgV1 removeFromSuperview];


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
