//
//  ListCell.m
//  VOA_English
//
//  Created by 王强 on 17/3/13.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self createUI];
}

- (void)createUI{

    self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    self.ListLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.contentView.height-2)];
    bgview.backgroundColor = [UIColor lightGrayColor];
    bgview.alpha = 0.3;
    self.selectedBackgroundView = bgview;
  
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    
    line.dk_backgroundColorPicker = DKColorPickerWithKey(SEP);
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(10);
         make.right.equalTo(self.mas_right).offset(-10);
        make.height.offset(1);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
