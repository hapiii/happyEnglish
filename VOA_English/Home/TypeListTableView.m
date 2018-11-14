//
//  TypeListTableView.m
//  VOA_English
//
//  Created by 王强 on 17/3/8.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "TypeListTableView.h"
#import "NoDataCell.h"

static NSString * const ListCellID = @"ListCellID";//一张图片
static NSString * const noDataCellID = @"noDataCellID";
@implementation TypeListTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    self.delegate = self;
    self.dataSource = self;
    
    self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
   

    self.separatorStyle = NO;//去掉分割线
    self.estimatedRowHeight = 379.0f;
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([ListCell class]) bundle:nil] forCellReuseIdentifier:ListCellID];
    
     [self registerNib:[UINib nibWithNibName:NSStringFromClass([NoDataCell class]) bundle:nil] forCellReuseIdentifier:noDataCellID];
   
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ListArr.count?self.ListArr.count:1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.ListArr.count==0) {
        NoDataCell *cell           = [tableView dequeueReusableCellWithIdentifier:noDataCellID];
    
         return cell;

    }
    
      ListCell *cell           = [tableView dequeueReusableCellWithIdentifier:ListCellID];
    ArticalListModel *model = self.ListArr[indexPath.row];
    cell.ListLabel.text = model.articalTitle;
   
   
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ListArr.count==0) {
        return SCREENH_HEIGHT-64;
    }
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
      [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中，
    if (self.ListArr.count==0) {
        return;
    }
    
    if (self.TypeListSelectCell) {
            self.TypeListSelectCell(self.ListArr[indexPath.row]);
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
