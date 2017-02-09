//
//  LRJMediDetailsTableViewCell.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/9/7.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJMediDetailsTableViewCell.h"

@implementation LRJMediDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImage *image = [[UIImage imageNamed:@"星星"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.xing11.image = image;
    
    self.xing11.tintColor = [UIColor colorWithRed:251/255.0 green:127/255.0 blue:36/255.0 alpha:1.0];
    
    UIImage *image22 = [[UIImage imageNamed:@"星星"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.xing22.image = image22;
    
    self.xing22.tintColor = [UIColor colorWithRed:251/255.0 green:127/255.0 blue:36/255.0 alpha:1.0];
    
    UIImage *image33 = [[UIImage imageNamed:@"星星"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.xing33.image = image33;
    
    self.xing33.tintColor = [UIColor colorWithRed:251/255.0 green:127/255.0 blue:36/255.0 alpha:1.0];
    
    UIImage *image44 = [[UIImage imageNamed:@"星星"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.xing44.image = image44;
    
    self.xing44.tintColor = [UIColor colorWithRed:251/255.0 green:127/255.0 blue:36/255.0 alpha:1.0];
    
    UIImage *image55 = [[UIImage imageNamed:@"星星"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.xing55.image = image55;
    
    self.xing55.tintColor = [UIColor colorWithRed:251/255.0 green:127/255.0 blue:36/255.0 alpha:1.0];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
