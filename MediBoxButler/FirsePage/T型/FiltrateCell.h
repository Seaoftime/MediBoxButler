//
//  FiltrateCell.h
//  3198CommercialChance
//
//  Created by iOS开发 on 15/12/8.
//  Copyright © 2015年 路鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltrateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *angleImgView;
@property (nonatomic,assign) BOOL isSelected;
@end
