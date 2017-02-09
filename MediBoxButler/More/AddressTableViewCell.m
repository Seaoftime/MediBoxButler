//
//  AddressTableViewCell.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/8.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "AddressTableViewCell.h"


@interface AddressTableViewCell ()





@end

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.telLabel.text = @"13460286118";
    self.addressLb.text = @"河南省郑州市郑东新区龙子湖高校大学城";
    self.lineImageView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
