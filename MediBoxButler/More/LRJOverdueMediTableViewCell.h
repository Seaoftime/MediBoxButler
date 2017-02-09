//
//  LRJOverdueMediTableViewCell.h
//  MediBoxButler
//
//  Created by ZhongMeng on 16/9/5.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRJOverdueMediTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *overImgV;

@property (weak, nonatomic) IBOutlet UILabel *overLb;

@property (weak, nonatomic) IBOutlet UILabel *detailsLb;

@property (weak, nonatomic) IBOutlet UILabel *eatOverLb;

@property (weak, nonatomic) IBOutlet UIButton *yesBtn;

@property (weak, nonatomic) IBOutlet UIButton *noBtn;



@end
