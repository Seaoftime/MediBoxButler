//
//  LRJOverdueMediTableViewCell.m
//  MediBoxButler
//
//  Created by ZhongMeng on 16/9/5.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJOverdueMediTableViewCell.h"

@implementation LRJOverdueMediTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.detailsLb.numberOfLines = 0;
    self.detailsLb.text = @"生产日期:2016-6-6\n 保质期:12个月\n 到期日:2017-6-6";
    
    [self.yesBtn setBackgroundColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0]];
    [self.yesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.noBtn setBackgroundColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0]];
    [self.noBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
