//
//  VideoListTableView.m
//  VOA_English
//
//  Created by 王强 on 2017/3/28.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "VideoListTableView.h"

#import "ListCell.h"

static NSString * const ListCellID = @"ListCellID";

@implementation VideoListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andModel:(VideoModel *)model{
    self = [super initWithFrame:frame style:style];
    self.delegate = self;
    self.dataSource = self;
    
    self.separatorStyle = NO;//去掉分割线
    self.estimatedRowHeight = 379.0f;
    self.rowHeight = UITableViewAutomaticDimension;
     self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([ListCell class]) bundle:nil] forCellReuseIdentifier:ListCellID];//一张图片
    
    self.model = model;
    //这里处理相关推荐的数据：去掉第一个
    if (self.model.relatedArr.count>0) {
        _ReArr =[NSMutableArray arrayWithArray:self.model.relatedArr];
        [_ReArr removeObjectAtIndex:0];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
     return  _ReArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
#pragma mark - 组头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //第一组高度位50
    if (section==0) {
         return 0.01;
        
    }else{
        return 20;
    }
}

#pragma mark====== tb的头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 20)];
        label.text = @"相关推荐:";
        label.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        return label;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListCell *cell           = [tableView dequeueReusableCellWithIdentifier:ListCellID];
    
    if (indexPath.section==0) {
        cell.ListLabel.text = self.model.VideoDes;
    }else{
        //相关推荐
        ArticalListModel *model = [ArticalListModel new];
        model = _ReArr[indexPath.row];
        cell.ListLabel.text = model.articalTitle;

    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
    }else{
        
    }
    
    if (self.VIdeoListTableViewSelectCell) {
        self.VIdeoListTableViewSelectCell(_ReArr[indexPath.row]);
    }
}



@end
