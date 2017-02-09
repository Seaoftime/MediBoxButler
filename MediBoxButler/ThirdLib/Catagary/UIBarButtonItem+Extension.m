//
//  UIBarButtonItem+Extension.m
//
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)BarButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    
    return [[self alloc] initWithTitle:title style:style target:target action:action];
    
}

+ (instancetype)BarButtonItemWithBackgroudImageName:(NSString *)backgroudImage highBackgroudImageName:(NSString *)highBackgroudImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageWithName:backgroudImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highBackgroudImageName] forState:UIControlStateHighlighted];
  
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
/**
 *  设置tarbuttoonItem
 *
 *  @param imageName     图片名称
 *  @param highImageName 高亮图片名称
 *  @param title         标题
 *  @param target        回调对象
 *  @param action        回调方法
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)BarButtonItemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    
    
    [button setImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highImageName] forState:UIControlStateHighlighted];
    
    //
    [button setTintColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0]];
    
    
    
    if (title) {
        
        [button setTitle:title forState:UIControlStateNormal];
        
        //
        [button setTitleColor:[UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        
        
        [button setTitleColor:nil forState:UIControlStateHighlighted];
        button.titleLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:11 ];
        
    }
    /**
     *  调整位置
     *
     */
    
    // 设置按钮的尺寸为背景图片的尺寸+文字大小
    button.width = [title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width - 10;
    
    button.height = button.currentImage.size.height+[title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
    
    
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //设置title在button上的位置（上top，左left，下bottom，右right）
    
    button.titleEdgeInsets = UIEdgeInsetsMake(25,-36, 0, -10);

    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}


+ (instancetype)LeftBarButtonItemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    
    [button setImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highImageName] forState:UIControlStateHighlighted];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithRed:25/255.0 green:147/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [button setTitleColor:nil forState:UIControlStateHighlighted];
        
        button.titleLabel.font =[UIFont fontWithName:@"Helvetica-Bold" size:10 ];
        
    }
    
    // 设置按钮的尺寸为背景图片的尺寸+文字大小
    //button.width = [title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    button.width = 40;
    
    //button.height = button.currentImage.size.height+[title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
    button.height = 50;
    
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    //设置title在button上的位置（上top，左left，下bottom，右right）
    button.titleEdgeInsets = UIEdgeInsetsMake(33,-43, 10, 0);
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}





@end
