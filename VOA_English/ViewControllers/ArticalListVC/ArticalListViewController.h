//
//  ArticalListViewController.h
//  VOA_English
//
//  Created by 王强 on 17/3/8.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseViewController.h"
#import "NavView.h"
#import "ArticalTableView.h"

@interface ArticalListViewController : BaseViewController

@property (nonatomic,copy)NSString *ListTitle;//列表标题
@property (nonatomic,copy)NSString *Url;//后接地址

@property (nonatomic,strong)ArticalTableView *tb;

@property (nonatomic,assign)int index;

@property (nonatomic,strong)NSMutableArray *dataSource;

@end
