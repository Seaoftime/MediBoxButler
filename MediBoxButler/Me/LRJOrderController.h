//
//  LRJOrderController.h
//  MediBoxButler
//
//  Created by TonySheng on 16/4/5.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRJOrderController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    
    int willDelecteRow;
    
}


@property(nonatomic, strong) UITableView *orderTableView;
@property(nonatomic, strong) NSArray *orderDataArray;

@end
