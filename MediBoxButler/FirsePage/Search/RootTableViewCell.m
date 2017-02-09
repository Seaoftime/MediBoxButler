//
//  CustomTableViewCell.m
//  lallal
//
//  Created by lanwon on 16/2/24.
//  Copyright © 2016年 lanwon. All rights reserved.
//

#import "RootTableViewCell.h"

@interface RootTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@end

@implementation RootTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.keyWordLb.numberOfLines = 1;
    self.backgroundColor = [UIColor whiteColor];
}

- (IBAction)deleteClick:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(deleteButtonClick:)]) {
        [self.delegate deleteButtonClick:self.keyWordLb.text];
    }
}
@end
