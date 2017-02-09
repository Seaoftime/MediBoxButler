//
//  FiltrateView.h
//  3198CommercialChance
//
//  Created by iOS开发 on 15/12/7.
//  Copyright © 2015年 路鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FiltrateView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain)UITableView *tableView;
- (id)initWithCount:(int)count withTitleArr:(NSArray *)titleArr withDataArr:(NSArray *)dataArr;
//- (void)completionBlock:(void(^)(NSArray *dataArr))block;
@end

@protocol FiltrateViewDelegate <NSObject>

- (void)completionArr:(NSArray *)dataArr;

@end

@interface CustomView : UIView
@property (nonatomic,assign) BOOL isUnfold;

@end