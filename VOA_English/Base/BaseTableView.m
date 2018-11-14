//
//  BaseTableView.m
//  VOA_English
//
//  Created by 王强 on 17/3/8.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (NSArray *)ListArr{
    if (!_ListArr) {
        _ListArr = [[NSArray alloc] init];
    }
    return _ListArr;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);

    return self;
}


@end
