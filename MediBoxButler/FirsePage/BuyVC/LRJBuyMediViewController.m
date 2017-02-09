//
//  LRJBuyMediViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/13.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJBuyMediViewController.h"

#import "CCLocationManager.h"
#import "LRJOrderrModel.h"


@interface LRJBuyMediViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSString *_price;


}


@property (nonatomic, strong) UITableView *buyTableView;

@property (nonatomic, strong) UIImageView *locationImgV;

@property (nonatomic, strong) UILabel *buyTimeLabel;
@property (nonatomic, strong) UILabel *personLabel;
@property (nonatomic, strong) UILabel *mediNameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *mediStoreLabel;
//
@property (nonatomic, strong) UILabel *buyTime;
@property (nonatomic, strong) UILabel *personLabel1;
@property (nonatomic, strong) UILabel *mediNameLabel1;
@property (nonatomic, strong) UILabel *priceLabel1;
@property (nonatomic, strong) UILabel *moneyLabel1;
@property (nonatomic, strong) UILabel *mediStoreLabel1;
//
@property (nonatomic, strong) UILabel *buyWayLabel;

@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *subBtn;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *numLbl;

@property (nonatomic, assign)         NSInteger num;
@property (nonatomic, strong) UIView *topV;
@property (nonatomic, strong) UILabel *locationLb;

@property (nonatomic, strong) LRJOrderrModel *orderModell;


@end

@implementation LRJBuyMediViewController


- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购买";
    
    _num = 1;
    
    
    [self.view addSubview:self.buyTableView];
    
    //[self.buyTableView addSubview:self.buyTimeLabel];
    //[self.buyTableView addSubview:self.personLabel];
    [self.buyTableView addSubview:self.mediNameLabel];
    [self.buyTableView addSubview:self.priceLabel];
    [self.buyTableView addSubview:self.moneyLabel];
    [self.buyTableView addSubview:self.mediStoreLabel];
    
    
    
    //
    //[self.buyTableView addSubview:self.buyTime];
    //[self.buyTableView addSubview:self.personLabel1];
    [self.buyTableView addSubview:self.mediNameLabel1];
    [self.buyTableView addSubview:self.priceLabel1];
    [self.buyTableView addSubview:self.moneyLabel1];
    [self.buyTableView addSubview:self.mediStoreLabel1];
    //
    [self.buyTableView addSubview:self.buyWayLabel];
    //
    [self.buyTableView addSubview:self.doneButton];
    [self.buyTableView addSubview:self.deleteButton];
    //
    [self.buyTableView addSubview:self.numLabel];
    [self.buyTableView addSubview:self.subBtn];
    [self.buyTableView addSubview:self.addBtn];
    [self.buyTableView addSubview:self.numLbl];

    //
    [self.buyTableView addSubview:self.topV];
    [self.topV addSubview:self.locationImgV];
    [self.topV addSubview:self.personLabel];
    [self.topV addSubview:self.personLabel1];
    [self.topV addSubview:self.locationLb];
    
    [self getAllInfo];
    
    
    
    
}


#pragma mark - UI -


- (UITableView *)buyTableView
{
    if (_buyTableView == nil) {
        
        _buyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
        _buyTableView.backgroundColor = [UIColor whiteColor];
        _buyTableView.delegate = self;
        _buyTableView.dataSource = self;
        _buyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_buyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _buyTableView;
}


- (UIView *)topV
{
    if (_topV == nil) {
        _topV = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREENW, 80)];
        _topV.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];

    }

    return _topV;
}

- (UIImageView *)locationImgV
{
    if (_locationImgV == nil) {
        
        _locationImgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 45, 25, 25)];
       
        UIImage *image = [[UIImage imageNamed:@"定位"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _locationImgV.image = image;
        
        _locationImgV.tintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    }

    return _locationImgV;
}

- (UILabel *)buyTimeLabel
{
    if (_buyTimeLabel == nil) {
        _buyTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 40)];
        _buyTimeLabel.backgroundColor = [UIColor whiteColor];
        _buyTimeLabel.text = @"预定时间:";
        _buyTimeLabel.textColor = [UIColor blackColor];
        _buyTimeLabel.textAlignment = NSTextAlignmentLeft;
        [_buyTimeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    }
    
    return _buyTimeLabel;
}

- (UILabel *)buyTime
{
    if (_buyTime == nil) {
        
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss SS"];
        
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        
        _buyTime = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 200, 40)];
        _buyTime.backgroundColor = [UIColor whiteColor];
        _buyTime.text = dateString;
        
        _buyTime.textColor = [UIColor blackColor];
        _buyTime.textAlignment = NSTextAlignmentLeft;
        [_buyTime setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    
    return _buyTime;
}

- (UILabel *)personLabel
{
    if (_personLabel == nil) {
        _personLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 100, 40)];
        _personLabel.backgroundColor = [UIColor clearColor];
        _personLabel.numberOfLines = 0;
        
        NSString *nameStr = [NSUserDefaults standardUserDefaults].userName;
        
        if (nameStr == nil || nameStr == NULL || [nameStr isKindOfClass:[NSNull class]]) {
            
            _personLabel.text = @"路人甲";
        }else {
            
            _personLabel.text = nameStr;
        }
        
        _personLabel.textColor = [UIColor blackColor];
        _personLabel.textAlignment = NSTextAlignmentLeft;
        [_personLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    }
    
    return _personLabel;
    
}

- (UILabel *)personLabel1
{
    if (_personLabel1 == nil) {
        _personLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, 100, 40)];
        _personLabel1.backgroundColor = [UIColor clearColor];
        
        
        NSString *telStr = [NSUserDefaults standardUserDefaults].userMobilNumber;
        
        if (telStr == nil || telStr == NULL || [telStr isKindOfClass:[NSNull class]]) {
            
            _personLabel1.text = @"16888661188";
        }else {
            
            _personLabel1.text = telStr;
        }
        
        
        _personLabel1.textColor = [UIColor blackColor];
        _personLabel1.textAlignment = NSTextAlignmentLeft;
        [_personLabel1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    }
    
    return _personLabel1;
    
}


- (UILabel *)locationLb
{
    if (_locationLb == nil) {
        _locationLb = [[UILabel alloc] initWithFrame:CGRectMake(70, 38, SCREENW - 100, 40)];
        _locationLb.backgroundColor = [UIColor clearColor];
        _locationLb.text = @"正在定位...";
        _locationLb.textColor = [UIColor blackColor];
        _locationLb.numberOfLines = 0;
        _locationLb.textAlignment = NSTextAlignmentLeft;
        [_locationLb setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    }

    return _locationLb;
}


- (UILabel *)mediNameLabel
{
    if (_mediNameLabel == nil) {
        _mediNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 130, 100, 40)];
        _mediNameLabel.backgroundColor = [UIColor whiteColor];
        _mediNameLabel.text = @"药品:";
        _mediNameLabel.textColor = [UIColor blackColor];
        _mediNameLabel.textAlignment = NSTextAlignmentLeft;
        [_mediNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    }
    
    return _mediNameLabel;
}

- (UILabel *)mediNameLabel1
{
    if (_mediNameLabel1 == nil) {
        _mediNameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 130, 100, 40)];
        _mediNameLabel1.backgroundColor = [UIColor whiteColor];
        _mediNameLabel1.text = @"白加黑治感冒";
        _mediNameLabel1.textColor = [UIColor blackColor];
        _mediNameLabel1.textAlignment = NSTextAlignmentLeft;
        [_mediNameLabel1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    
    return _mediNameLabel1;
}

- (UILabel *)numLabel
{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 135, 50, 30)];
        _numLabel.backgroundColor = [UIColor whiteColor];
        _numLabel.text = [NSString stringWithFormat:@"%ld",_num];
        
        _numLabel.textColor = [UIColor blackColor];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [_numLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    }
    return _numLabel;
}

- (UILabel *)numLbl
{
    if (_numLbl == nil) {
        _numLbl = [[UILabel alloc] initWithFrame:CGRectMake(270, 135, 30, 30)];
        _numLbl.backgroundColor = [UIColor whiteColor];
        _numLbl.text = @"盒";
        
        _numLbl.textColor = [UIColor blackColor];
        _numLbl.textAlignment = NSTextAlignmentCenter;
        [_numLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    }
    return _numLbl;
}

- (UIButton *)subBtn
{
    if (_subBtn == nil) {
        _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _subBtn.frame = CGRectMake(230, 110, 30, 35);
        
        UIImage *collectImg = [[UIImage imageNamed:@"上"]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        //[_rightBtn setTitleColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_subBtn setTintColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0]];
        
        [_subBtn setBackgroundImage:collectImg
                             forState:UIControlStateNormal];
        
        [_subBtn addTarget:self
                      action:@selector(subBtnClick)
            forControlEvents:UIControlEventTouchUpInside];
    }

    return _subBtn;
}

- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(230, 155, 30, 35);
        
        UIImage *collectImg = [[UIImage imageNamed:@"下"]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        //[_rightBtn setTitleColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_addBtn setTintColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0]];
        
        [_addBtn setBackgroundImage:collectImg
                           forState:UIControlStateNormal];
        
        [_addBtn addTarget:self
                    action:@selector(addBtnClick)
          forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;

}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 180, 100, 40)];
        _priceLabel.backgroundColor = [UIColor whiteColor];
        _priceLabel.text = @"价格:";
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [_priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    }
    
    return _priceLabel;
}

- (UILabel *)priceLabel1
{
    if (_priceLabel1 == nil) {
        _priceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 180, 100, 40)];
        _priceLabel1.backgroundColor = [UIColor whiteColor];
        _priceLabel1.text = @"6.8元/盒";
        _priceLabel1.textColor = [UIColor blackColor];
        _priceLabel1.textAlignment = NSTextAlignmentLeft;
        [_priceLabel1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    
    return _priceLabel1;
}

- (UILabel *)moneyLabel
{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 230, 100, 40)];
        _moneyLabel.backgroundColor = [UIColor whiteColor];
        _moneyLabel.text = @"总价:";
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        [_moneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    }
    
    return _moneyLabel;
}

- (UILabel *)moneyLabel1
{
    if (_moneyLabel1 == nil) {
        _moneyLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 230, 100, 40)];
        _moneyLabel1.backgroundColor = [UIColor whiteColor];
        _moneyLabel1.text = @"优惠价6.8元";
        _moneyLabel1.textColor = [UIColor blackColor];
        _moneyLabel1.textAlignment = NSTextAlignmentLeft;
        [_moneyLabel1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    
    return _moneyLabel1;
}

- (UILabel *)buyWayLabel
{
    if (_buyWayLabel == nil) {
        _buyWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 235, 80, 30)];
        _buyWayLabel.backgroundColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
        _buyWayLabel.text = @"在线付款";
        _buyWayLabel.textColor = [UIColor whiteColor];
        _buyWayLabel.layer.cornerRadius = 3;
        _buyWayLabel.layer.masksToBounds = YES;
        
        _buyWayLabel.textAlignment = NSTextAlignmentCenter;
        [_buyWayLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    
    return _buyWayLabel;
}



- (UILabel *)mediStoreLabel
{
    if (_mediStoreLabel == nil) {
        _mediStoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 280, 100, 40)];
        _mediStoreLabel.backgroundColor = [UIColor whiteColor];
        _mediStoreLabel.text = @"药店:";
        _mediStoreLabel.textColor = [UIColor blackColor];
        _mediStoreLabel.textAlignment = NSTextAlignmentLeft;
        [_mediStoreLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    }
    
    return _mediStoreLabel;
}

- (UILabel *)mediStoreLabel1
{
    if (_mediStoreLabel1 == nil) {
        _mediStoreLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 280, 100, 40)];
        _mediStoreLabel1.backgroundColor = [UIColor whiteColor];
        _mediStoreLabel1.text = @"长春堂大药房";
        _mediStoreLabel1.textColor = [UIColor blackColor];
        _mediStoreLabel1.textAlignment = NSTextAlignmentLeft;
        [_mediStoreLabel1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    }
    
    return _mediStoreLabel1;
}


- (UIButton *)doneButton
{
    if (_doneButton == nil) {
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENW/2 - 150 + 10, 365, 100, 40)];
        _doneButton.backgroundColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
        [_doneButton setTitle:@"完成订单" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //_doneButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_doneButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        
        _doneButton.layer.cornerRadius = 5;
        _doneButton.layer.masksToBounds = YES;
        
        [_doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _doneButton;
}

- (UIButton *)deleteButton
{
    if (_deleteButton == nil) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENW/2 + 50 - 10, 365, 100, 40)];
        _deleteButton.backgroundColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
        [_deleteButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //_deleteButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_deleteButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        _deleteButton.layer.cornerRadius = 5;
        _deleteButton.layer.masksToBounds = YES;
        
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _deleteButton;
}


#pragma mark - delegate && dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //cell.contentView.userInteractionEnabled = YES;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //return 100;
    return SCREENH;
}







#pragma mark - event -


/**
 *  完成订单
 */
- (void)doneButtonClicked
{
    NSString *strr = [NSString stringWithFormat:@"订单金额共计：%@",self.moneyLabel1.text];
    
    //[NSUserDefaults standardUserDefaults].all_MoneyStr = self.moneyLabel1.text;
    
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:strr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertV show];
    
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString*filePath = [TOOL fullPathWithFileName:@"tLRJOrder.plist"];
//    if (![fileManager fileExistsAtPath:filePath])
//    {
//        [TOOL createFileWithName:@"tLRJOrder.plist"];
//    }
//    //self.defineReportsData =[NSMutableArray arrayWithContentsOfFile:filePath];
//    self.orderDataArray = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:filePath]];
//    
//    [self.orderDataArray insertObject:[NSString stringWithFormat:@"%@", self.title] atIndex:0];
//    
//    NSString *file = [TOOL fullPathWithFileName:@"tLRJOrder.plist"];
//    [self.orderDataArray writeToFile:file atomically:YES];
//    NSLog(@"define:%@",self.orderDataArray);
//    
    //发送消息
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"order" object:self];
    
    
    
    
}

#pragma mark - alertV
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }else {
    
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSString*filePath = [TOOL fullPathWithFileName:@"tLRJOrder.plist"];
//        if (![fileManager fileExistsAtPath:filePath])
//        {
//            [TOOL createFileWithName:@"tLRJOrder.plist"];
//        }
//        //self.defineReportsData =[NSMutableArray arrayWithContentsOfFile:filePath];
//        self.orderDataArray = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:filePath]];
//        
//        [self.orderDataArray insertObject:[NSString stringWithFormat:@"%@", self.title] atIndex:0];
//        
//        NSString *file = [TOOL fullPathWithFileName:@"tLRJOrder.plist"];
//        [self.orderDataArray writeToFile:file atomically:YES];
//        NSLog(@"define:%@",self.orderDataArray);
        
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm"];
        
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        
        self.orderModell = [[LRJOrderrModel alloc] init];
        self.orderModell.buyTimeStr = dateString;
        self.orderModell.allMoneyStr = self.moneyLabel1.text;
        
        [self.orderModell save];//保存至数据库
        
        [SVProgressHUD showSuccessWithStatus:@"订单已完成"];
        
        [self.navigationController popViewControllerAnimated:YES];
        

    
    }


}





- (void)deleteButtonClicked
{

    [self.navigationController popViewControllerAnimated:YES];


}

- (void)subBtnClick
{
    if (_num > 1) {
        _num --;
    }
    [self.numLabel setText:[NSString stringWithFormat:@"%ld",_num]];
    
    [self.moneyLabel1 setText:[NSString stringWithFormat:@"%.2f 元",_num * 6.8]];
    


}

- (void)addBtnClick
{
    _num ++;
    
    [self.numLabel setText:[NSString stringWithFormat:@"%ld",_num]];
    
    [self.moneyLabel1 setText:[NSString stringWithFormat:@"%.2f 元",_num * 6.8]];
    
}



-(void)getAllInfo
{
    __block NSString *string;
    __block __weak LRJBuyMediViewController *wself = self;
    
    
    if (IS_IOS8) {
        
        [[CCLocationManager shareLocation]getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            string = [NSString stringWithFormat:@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude];
        } withAddress:^(NSString *addressString) {
            NSLog(@"%@",addressString);
            //string = [NSString stringWithFormat:@"%@\n%@",string,addressString];
            string = [NSString stringWithFormat:@"%@",addressString];
            [wself setLabelText:string];
            
        }];
    }
    
}

-(void)setLabelText:(NSString *)text
{
    NSLog(@"text %@",text);
    _locationLb.text = text;
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
