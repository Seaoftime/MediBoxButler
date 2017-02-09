//
//  LRJOrderController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/5.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJOrderController.h"

//#import "FirstPageTableViewCell.h"
#import "LRJOrderrcTableViewCell.h"
#import "LRJOrderrModel.h"
#import "FirstPageDetailsViewController.h"


@interface LRJOrderController ()<UIAlertViewDelegate>



//@property (nonatomic, strong) NSMutableArray *orderArray;

@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, strong) LRJOrderrModel *orderModel;

@end

@implementation LRJOrderController


//设置 statusBar 字体与背景色
//1.
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    
    //
    //设置字体和字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

}


-(void)viewDidAppear:(BOOL)animated
{
    [self getOrderData];
    [self.orderTableView reloadData];
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"订单";
    
    [self getOrderData];
    
    self.orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, (SCREENH))];
    self.orderTableView.backgroundColor = [UIColor clearColor];
    self.orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.orderTableView.dataSource = self;
    self.orderTableView.delegate = self;
    [self.view addSubview:self.orderTableView];
    
    //
    //[self.orderTableView addSubview:self.showLabel];
    
    
//    if (self.orderDataArray.count == 0) {
//        
//        [self.view addSubview:self.showLabel];
//    }
    
    [self.view addSubview:self.showLabel];
    
    if (self.orderDataArray.count == 0) {
        self.showLabel.hidden = NO;
    }else {
    
        self.showLabel.hidden = YES;
    }
    
    
}

- (UILabel *)showLabel
{
    if (_showLabel == nil) {
        _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREENH/2 - 64, SCREENW, 40)];
        _showLabel.text = @"您还没有订单，请去首页购买!";
        _showLabel.textColor = [UIColor blackColor];
        _showLabel.backgroundColor = [UIColor clearColor];
        _showLabel.textAlignment = NSTextAlignmentCenter;
        _showLabel.font = [UIFont systemFontOfSize:17];
    }
    return _showLabel;
}






- (void)getOrderData
{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString*filePath = [TOOL fullPathWithFileName:@"tLRJOrder.plist"];
//    if (![fileManager fileExistsAtPath:filePath])
//    {
//        [TOOL createFileWithName:@"tLRJOrder.plist"];
//    }
//    //self.defineReportsData =[NSMutableArray arrayWithContentsOfFile:filePath];
//    self.orderDataArray = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:filePath]];
    //NSLog(@"%@",self.defineReportsData);
    
    self.orderDataArray = [LRJOrderrModel findAll];
    
    if (self.orderDataArray.count == 0) {
        self.showLabel.hidden = NO;
    }else {
        
        self.showLabel.hidden = YES;
    }
    
}




#pragma mark -tableview delegte -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orderDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *CellIdentifier = @"firstPage";
    LRJOrderrcTableViewCell *cell= [self.orderTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [self.orderTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LRJOrderrcTableViewCell" owner:self options:nil] lastObject];
        UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, SCREENW, 1)];
        vi.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [cell addSubview:vi];
        
    }
    //
    self.orderModel = self.orderDataArray[indexPath.row];
    cell.buyTimeLb.text = self.orderModel.buyTimeStr;
    cell.allMoneyLb.text = [NSString stringWithFormat:@"实付%@",self.orderModel.allMoneyStr];
    
    [cell.deleteOrderBtn addTarget:self action:@selector(deletteOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteOrderBtn.tag = indexPath.row;
    
    [cell.buyAgainBtn addTarget:self action:@selector(buyAgainBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  121;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];


}


#pragma mark - event -


- (void)buyAgainBtnClicked
{

    FirstPageDetailsViewController *detailsVC = [[FirstPageDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:detailsVC animated:YES];

}


- (void)deletteOrderClicked:(UIButton *)deleteBtn
{
    
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertV show];
    
    [NSUserDefaults standardUserDefaults].all_MoneyStr = [NSString stringWithFormat:@"%ld",deleteBtn.tag];
    

}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }else {
        
        NSInteger tagg = [[NSUserDefaults standardUserDefaults].all_MoneyStr integerValue];
        
        self.orderModel = self.orderDataArray[tagg];
        
        [self.orderModel deleteObject];
        
        
        self.orderDataArray = [LRJOrderrModel findAll];
        
        
        if (self.orderDataArray.count == 0) {
            self.showLabel.hidden = NO;
        }else {
            
            self.showLabel.hidden = YES;
        }
        
        [self.orderTableView reloadData];
        
        [SVProgressHUD showSuccessWithStatus:@"订单已删除" maskType:SVProgressHUDMaskTypeBlack];
        
    }
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
