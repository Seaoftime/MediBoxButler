//
//  CustomTableViewCell.h
//  lallal
//
//  Created by lanwon on 16/2/24.
//  Copyright © 2016年 lanwon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootTableViewCell;
@protocol RootTableViewCellDelegate <NSObject>
@optional
- (void)deleteButtonClick:(NSString *)keyword;
@end

@interface RootTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *keyWordLb;
@property (nonatomic, weak) id<RootTableViewCellDelegate> delegate;
@end
