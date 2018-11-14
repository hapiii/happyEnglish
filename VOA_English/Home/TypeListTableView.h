//
//  TypeListTableView.h
//  VOA_English
//
//  Created by 王强 on 17/3/8.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseTableView.h"
#import "ListCell.h"

@interface TypeListTableView : BaseTableView<UITableViewDelegate,UITableViewDataSource>



@property (copy, nonatomic) void(^TypeListSelectCell)(ArticalListModel  *model);



@end
