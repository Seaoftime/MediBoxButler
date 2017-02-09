//
//  LRJMedisTakeInTableViewCell.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/9/5.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJMedisTakeInTableViewCell.h"

@implementation LRJMedisTakeInTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.priceLb.textColor = [UIColor colorWithRed:60/255.0 green:245/255.0 blue:60/255.0 alpha:1.0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
