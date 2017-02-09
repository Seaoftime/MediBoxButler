//
//  FirstPageTableViewCell.m
//  MediBoxButler
//
//  Created by TonySheng on 16/3/31.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "FirstPageTableViewCell.h"



@interface FirstPageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageV;



@property (weak, nonatomic) IBOutlet UIImageView *pictureImageV;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *classLabel1;

@property (weak, nonatomic) IBOutlet UILabel *classLabel2;

@property (weak, nonatomic) IBOutlet UIImageView *lineImageV;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

//

@property (weak, nonatomic) IBOutlet UIImageView *line1;

@property (weak, nonatomic) IBOutlet UIImageView *line2;

@property (weak, nonatomic) IBOutlet UIImageView *line3;

@property (weak, nonatomic) IBOutlet UIImageView *line4;








@end

@implementation FirstPageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
    self.pictureImageV.image = [UIImage imageNamed:@"view_WpluB"];
    self.nameLabel.text = @"白加黑治感冒";
    self.classLabel1.text = @"内科药|感冒药";
    //self.classLabel2.text = @"感冒药";
    //self.bgImageV.backgroundColor = [UIColor blackColor];
    self.lineImageV.backgroundColor = [UIColor blackColor];
    
    self.priceLabel.text = @"¥ 10-15";
    self.priceLabel.textColor = [UIColor colorWithRed:60/255.0 green:245/255.0 blue:60/255.0 alpha:1.0];
    
    //
//    [self.bgImageV.layer setCornerRadius:1];
//    [self.bgImageV.layer setBorderColor:[UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1].CGColor];
//    [self.bgImageV.layer setBorderWidth:3];
//    
//    [self.bgImageV setClipsToBounds:YES];
    
    self.line1.backgroundColor = [UIColor colorWithRed:200/255.f  green:199/255.f  blue:204/255.f alpha:1];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
