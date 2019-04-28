//
//  ArticalTableView.m
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "ArticalTableView.h"
#import "ArticalListModel.h"
#import "ListCell.h"

static NSString * const ListCellID = @"ListCellID";

@implementation ArticalTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    self.delegate = self;
    self.dataSource = self;
    
    self.separatorStyle = NO;//去掉分割线
    self.estimatedRowHeight = 379.0f;
    self.rowHeight = UITableViewAutomaticDimension;
    self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
    

    [self registerNib:[UINib nibWithNibName:NSStringFromClass([ListCell class]) bundle:nil] forCellReuseIdentifier:ListCellID];//一张图片

    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0.001)];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    ListCell *cell           = [tableView dequeueReusableCellWithIdentifier:ListCellID];
    
    ArticalListModel *model = [ArticalListModel new];
    model = self.ListArr[indexPath.row];
    cell.ListLabel.text = model.articalTitle;
    
   
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中，
    if (self.ArticalTableViewSelectCell) {
        self.ArticalTableViewSelectCell(self.ListArr[indexPath.row]);
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    //隐藏导航条
    if (self.ifHidenTheNav) {
        //为真隐藏
        BOOL hide = velocity.y>0?1:0;
        _ifHidenTheNav(hide);
    }
    
}


@end
