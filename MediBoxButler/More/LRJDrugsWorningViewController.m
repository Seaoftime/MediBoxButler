//
//  LRJDrugsWorningViewController.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/7/16.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJDrugsWorningViewController.h"


#import "LRJOverdueMediTableViewCell.h"


@interface LRJDrugsWorningViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>


@property (nonatomic, strong) UITableView *overMediTableView;
@property (nonatomic, strong) NSIndexPath *indexpathhh;


@end

@implementation LRJDrugsWorningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title = @"过期药品预警";
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    
    
    
    [self.view addSubview:self.overMediTableView];
    
    
}


- (UITableView *)overMediTableView
{
    if (_overMediTableView == nil) {
        
        _overMediTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        _overMediTableView.backgroundColor = [UIColor clearColor];
        _overMediTableView.delegate = self;
        _overMediTableView.dataSource = self;
        _overMediTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //注册cell
        UINib *nib = [UINib nibWithNibName:@"LRJOverdueMediTableViewCell" bundle:nil];
        [_overMediTableView registerNib:nib forCellReuseIdentifier:@"cellID"];
        
    }
    return _overMediTableView;
}






#pragma mark - delegate && dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //return self.addressArray.count;
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LRJOverdueMediTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, SCREENW, 1)];
    vi.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [cell addSubview:vi];
    
    
    
    [cell.yesBtn addTarget:self action:@selector(yesBtnDeleteClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.yesBtn.tag = indexPath.row;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 190;
    //return SCREENH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
    
}



#pragma mark -------------------------delete
- (void)yesBtnDeleteClicked:(UIButton *)deleteBtn
{
    //NSLog(@"vvvvv");
    
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确认删除吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    LRJOverdueMediTableViewCell *celll = (LRJOverdueMediTableViewCell *)[[deleteBtn superview] superview];
    self.indexpathhh = [self.overMediTableView indexPathForCell:celll];
       

    //NSLog(@"%@",indexpathhh);
    



}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

//    if (buttonIndex == 1) {
//        
//        
//        [self.overMediTableView deleteRowsAtIndexPaths:@[self.indexpathhh] withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//        
//        [self.overMediTableView reloadData];
//    }
//




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
