//
//  LRJOrderrcTableViewCell.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/9/5.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJOrderrcTableViewCell.h"

@implementation LRJOrderrcTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.buyAgainBtn setTitleColor:[UIColor colorWithRed:40/255.0 green:251/255.0 blue:46/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.buyAgainBtn.layer.borderWidth = 1.0;
    self.buyAgainBtn.layer.borderColor = [UIColor colorWithRed:40/255.0 green:251/255.0 blue:46/255.0 alpha:1.0].CGColor;
    
    
    self.allMoneyLb.textColor = [UIColor colorWithRed:40/255.0 green:251/255.0 blue:46/255.0 alpha:1.0];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
