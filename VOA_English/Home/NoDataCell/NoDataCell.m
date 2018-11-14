//
//  NoDataCell.m
//  VOA_English
//
//  Created by 王强 on 17/3/15.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "NoDataCell.h"

@implementation NoDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
       // Initialization code
}


//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//       // [self configCell];
//    }
//    return self;
//}
- (void)configCell{
    self.userInteractionEnabled = UITableViewCellSelectionStyleNone;
    
    self.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    //self.dk_backgroundColorPicker = self.contentView.dk_backgroundColorPicker;
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREENH_HEIGHT-64)];
    
    bg.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    [self.contentView addSubview:bg];
    
    UIImageView *noDataIv = [[UIImageView alloc]init];
    noDataIv.image = [UIImage imageNamed:@"start"];
    [bg addSubview:noDataIv];
    
    [noDataIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(bg);
        make.bottom.equalTo(bg).offset(-100);
    }];
    
    UILabel *label = [UILabel new];
    label.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    label.text = @"点击右上角开始学习吧";
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [bg addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(bg);
        make.top.equalTo(noDataIv.mas_bottom);
        make.height.equalTo(@80);
        
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
