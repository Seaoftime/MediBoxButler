//
//  LRJFirstPageDetailsTableViewCell.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/12.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJFirstPageDetailsTableViewCell.h"


@interface LRJFirstPageDetailsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *storeLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *longLabel;

@property (weak, nonatomic) IBOutlet UIButton *buyButton;



@end

@implementation LRJFirstPageDetailsTableViewCell


- (void)viewWillDisappear:(BOOL)animated
{
    
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)awakeFromNib {
    // Initialization code
    
    
    
    
    self.priceLabel.textColor = [UIColor blackColor];
    self.addressLabel.textColor = [UIColor blackColor];
    self.longLabel.textColor = [UIColor blackColor];
    
    
    
    
    [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buyButton.backgroundColor = [UIColor colorWithRed:41/255.0 green:252/255.0 blue:46/255.0 alpha:1.0];
    [self.buyButton setTitle:@"购买" forState:UIControlStateNormal];
    
    [self.buyButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self.buyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.buyButton addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buyButtonClick
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"buy" object:self];

}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
