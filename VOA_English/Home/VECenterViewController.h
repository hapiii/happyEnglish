//
//  VECenterViewController.h
//  VOA_English
//
//  Created by 王强 on 17/3/7.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseViewController.h"
#import "TypeListTableView.h"
#import "ArticalListViewController.h"

typedef NS_ENUM(NSInteger,ShowState) {
    ShowStateLeft,
    ShowStateRight
};

@interface VECenterViewController : BaseViewController

@property (nonatomic,copy) void(^tapBarButton)(ShowState);
@property (nonatomic,strong)TypeListTableView *tb;

@property (nonatomic,strong)NSArray *dataSource;

@end
