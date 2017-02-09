//
//  LRJSearchViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/5.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJSearchViewController.h"

#import "RootView.h"

@interface LRJSearchViewController ()<RootViewDelegate,RootViewDataSource>



@property (nonatomic, strong) RootView       *rootView;
@property (nonatomic, strong) NSMutableArray *testArray;
@property (nonatomic, strong) NSMutableArray *keyWordArray; // 搜索关键字记录


@end

@implementation LRJSearchViewController




- (NSMutableArray *)testArray {
    if (!_testArray) {
        _testArray = [[NSMutableArray alloc] init];
    }
    return _testArray;
}

- (NSMutableArray *)keyWordArray {
    
    if (!_keyWordArray) {
        // *** 当文件为空时，创建会失败
        _keyWordArray = [NSMutableArray arrayWithContentsOfFile:[self getCachePath]];
    }
    // ***  所以要再次判断
    if (!_keyWordArray) {
        _keyWordArray = [[NSMutableArray alloc] init];
    }
    return _keyWordArray;
}

- (void)loadView {
    
    _rootView = [[[NSBundle mainBundle] loadNibNamed:@"RootView" owner:self options:nil] lastObject];
    _rootView.delegate = self;
    _rootView.datasource = self;
    self.view = _rootView;
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.title = @"";
    
    //接受消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"fanhui" object:nil];
}


- (void)back
{
    self.navigationController.navigationBarHidden = NO;
    //
    [self.navigationController popViewControllerAnimated:YES];


}



#pragma mark - CustomView代理


- (NSArray *)searchView:(RootView *)searchView {
    
    // 此代理方法的作用是提供开始输入时所展示的全部搜索记录
    return self.keyWordArray;
}

- (void)searchView:(RootView *)searchView didSelectKeyWord:(NSString *)keyword {
    
    // 此代理方法的作用是获取到选中的关键字,后续一般为向服务器提交数据请求。
    NSLog(@"选中的关键字为:%@",keyword);
}

- (void)searchView:(RootView *)searchView didDeleteKeyWord:(NSString *)keyword {
    
    // 此代理方法的作用是获取到删除的关键字后删除本地缓存的关键字。
    NSArray *keyArray = [self.keyWordArray copy];
    for (NSString *key in keyArray) {
        if ([key isEqualToString:keyword]) {
            [self.keyWordArray removeObject:key];
            [self seaveKayWord];
        }
    }
    NSLog(@"删除的关键字为:%@",keyword);
}

- (NSArray *)searchView:(RootView *)searchView didInputKeyWord:(NSString *)keyword {
    
    // 此代理方法的作用是获取到输入中的关键字后在本地缓存中模糊匹配,再把结果返回给视图,视图拿到匹配结果后,动态刷新候选关键字。
    [self.testArray removeAllObjects];
    for (NSString *key in self.keyWordArray) {
        if ([key containsString:keyword]) {
            [self.testArray addObject:key];
        }
    }
    NSLog(@"正在输入的关键字为:%@",keyword);
    return self.testArray;
}

- (void)searchView:(RootView *)searchView shouldReturnKeyWord:(NSString *)keyword {
    
    // 此代理方法的作用是获取到点击搜索按钮后搜索框中的关键字,在本地缓存中查找后再判断是否要保存到本地。
    BOOL isExist = NO;
    for (NSString *key in self.keyWordArray) {
        if ([key isEqualToString:keyword]) {
            isExist = YES;
        }
    }
    
    if (!isExist) {
        [self.keyWordArray insertObject:keyword atIndex:0];
        [self seaveKayWord];
    }
    NSLog(@"搜索的关键字为:%@",keyword);
}

#pragma mark -
#pragma mark - 数据缓存相关操作

- (void)seaveKayWord {
    
    // 此方法的作用是将关键字以数组的格式保存到本地。
    [self.keyWordArray writeToFile:[self getCachePath] atomically:YES];
}

- (NSString *)getCachePath {
    
    // 此方法的作用是获取本地缓存路径。
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSString *path = [cachePath stringByAppendingString:@"/keyword.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    return path;
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
