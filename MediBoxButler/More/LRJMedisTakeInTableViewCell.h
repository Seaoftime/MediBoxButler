//
//  LRJMedisTakeInTableViewCell.h
//  MediBoxButler
//
//  Created by ZhongMeng on 16/9/5.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRJMedisTakeInTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *mediImgV;


@property (weak, nonatomic) IBOutlet UILabel *mediNameLb;
@property (weak, nonatomic) IBOutlet UILabel *mediJIeLb;

@property (weak, nonatomic) IBOutlet UILabel *priceLb;


@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;





@end
