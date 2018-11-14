//
//  ArticalTableView.m
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "ArticalTableView.h"
#import "ArticalListModel.h"

@implementation ArticalTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    self.delegate = self;
    self.dataSource = self;
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticalListModel *model = [ArticalListModel new];
    static NSString *cellId = @"LeftCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.backgroundColor = WQRGBColor(40, 40, 40);
    cell.textLabel.textColor = WQRGBColor(230, 230, 230);
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, tableView.rowHeight)];
    bgview.backgroundColor = WQRGBColor(28, 28, 28);
    cell.selectedBackgroundView = bgview;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"rsm_icon_%zi",indexPath.row]];
    model = self.ListArr[indexPath.row];
    cell.textLabel.text = model.articalTitle;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, tableView.rowHeight - 1.5, tableView.width, 1.5)];
    line.backgroundColor = WQRGBColor(20, 20, 20);
    [cell addSubview:line];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.ArticalTableViewSelectCell) {
        self.ArticalTableViewSelectCell(self.ListArr[indexPath.row]);
    }
}



@end
