//
//  VideoListTableView.h
//  VOA_English
//
//  Created by 王强 on 2017/3/28.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseTableView.h"
#import "ZFPlayer.h"

@interface VideoListTableView : BaseTableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)VideoModel *model;

@property (nonatomic,strong)NSMutableArray *ReArr;
@property (copy, nonatomic) void(^VIdeoListTableViewSelectCell)(ArticalListModel  *model);

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andModel:(VideoModel *)model;
@end
