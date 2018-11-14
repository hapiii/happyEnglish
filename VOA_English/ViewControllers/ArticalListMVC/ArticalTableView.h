//
//  ArticalTableView.h
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseTableView.h"

@interface ArticalTableView : BaseTableView<UITableViewDelegate,UITableViewDataSource>

@property (copy, nonatomic) void(^ArticalTableViewSelectCell)(NSString  *ListTitle);

@end
