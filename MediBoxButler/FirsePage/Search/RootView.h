//
//  LWSearchView.h
//  Hdoctor
//
//  Created by lanwon on 15/12/4.
//  Copyright © 2015年 lanwon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backBlock)(id obj);

@protocol RootViewDelegate;
@protocol RootViewDataSource;

@interface RootView : UIView
@property (nonatomic, weak) IBOutlet UITextField  *textField;
@property (nonatomic, weak) id<RootViewDelegate> delegate;
@property (nonatomic, weak) id<RootViewDataSource> datasource;
@property (nonatomic, copy) backBlock block;
@end

@protocol RootViewDelegate <NSObject>
// 可选
@optional
- (NSArray *)searchView:(RootView *)searchView didInputKeyWord:(NSString *)keyword;  // 输入中
- (void)searchView:(RootView *)searchView didSelectKeyWord:(NSString *)keyword;      // 选中某行
- (void)searchView:(RootView *)searchView didDeleteKeyWord:(NSString *)keyword;      // 删除某行
- (void)searchView:(RootView *)searchView shouldReturnKeyWord:(NSString *)keyword;   // 搜索
@end

@protocol RootViewDataSource <NSObject>
// 必选
@required
- (NSArray *)searchView:(RootView *)searchView; // 返回数据源
@end
