//
//  LRJDrugsEntityyViewController.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/7/16.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJDrugsEntityyViewController.h"


#import "LRJMedisTakeInTableViewCell.h"



@interface LRJDrugsEntityyViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic, strong) UITableView *mediTakeinTableView;

@property (nonatomic, strong) NSMutableArray *drugPhotosArray;

@property (nonatomic, strong) NSMutableArray *drugNameArray;

@property (nonatomic, strong) NSMutableArray *drugJieArray;

@property (nonatomic, strong) NSMutableArray *drugPriceArray;

@end

@implementation LRJDrugsEntityyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title = @"常备药品录入";
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    [self.view addSubview:self.mediTakeinTableView];
    //self.mineMBTV.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    
    
    self.drugPhotosArray = [NSMutableArray arrayWithObjects:@"view_WpluB", @"kuaikee.jpg", @"999g.jpg", @"view_WpluB", @"amoxiling.jpg", @"view_WpluB", @"kuaikee.jpg", @"999g.jpg", @"view_WpluB", @"amoxiling.jpg", nil];
    
    self.drugNameArray = [NSMutableArray arrayWithObjects:@"白加黑", @"快克", @"999感冒灵", @"四季感冒", @"阿莫西林", @"白加黑", @"快克", @"999感冒灵", @"四季感冒", @"阿莫西林", nil];
    
    self.drugJieArray = [NSMutableArray arrayWithObjects:@"内科药|感冒药", @"感冒药", @"内科药|感冒药", @"感冒药", @"消炎药", @"内科药|感冒药", @"感冒药", @"内科药|感冒药", @"感冒药", @"消炎药", nil];
    
    self.drugPriceArray = [NSMutableArray arrayWithObjects:@"￥10-15",@"￥15-20",@"￥11.5",@"￥13-15",@"￥20-25",@"￥10-15",@"￥15-20",@"￥11.5",@"￥13-15",@"￥20-25", nil];
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
        UINib *nib = [UINib nibWithNibName:@"LRJMedisTakeInTableViewCell" bundle:nil];
        [_mediTakeinTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        
    }
    return _mediTakeinTableView;
}






#pragma mark - delegate && dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //return self.addressArray.count;
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LRJMedisTakeInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, SCREENW, 1)];
    vi.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [cell addSubview:vi];
    
    
    NSString *mediPhotos = [self.drugPhotosArray objectAtIndex:indexPath.row];
    
    cell.mediImgV.image = [UIImage imageNamed:mediPhotos];
    
    cell.mediNameLb.text = [self.drugNameArray objectAtIndex:indexPath.row];
    cell.mediJIeLb.text = [self.drugJieArray objectAtIndex:indexPath.row];
    cell.priceLb.text = [self.drugPriceArray objectAtIndex:indexPath.row];
    
    
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnDeleteClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = indexPath.row;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 81;
    //return SCREENH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
    
}








#pragma mark -------------------------delete
- (void)deleteBtnDeleteClicked:(UIButton *)deleteBtn
{
        
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确认删除吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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
