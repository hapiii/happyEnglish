//
//  DetailViewController.h
//  VOA_English
//
//  Created by 王强 on 17/3/13.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseViewController.h"
#import "ArticalTableView.h"

@interface DetailViewController : BaseViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)ArticalListModel *artModel;
@property (nonatomic,strong)DetailModel *model;

@property (nonatomic,strong)UITableView *tb;


@end
