//
//  NavView.m
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "NavView.h"

@implementation NavView

- (instancetype)init{
   
    self = [super init];
    [self createUI];
     return self;
    
}

- (void)createUI{
   
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 66);
    self.backgroundColor  = WQRGBColor(250,55,102);
    _leftBut = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    [_leftBut addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [_leftBut setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self addSubview:_leftBut];
    
   
//    _rightBut = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 25,30 , 30)];
//    [_rightBut addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
//     [_rightBut setBackgroundColor:[UIColor redColor]];
//    [self addSubview:_rightBut];
    
        _navtitleLabel = [UILabel new];
        _navtitleLabel.frame = CGRectMake( 50,20, SCREEN_WIDTH-100, 40);
        _navtitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_navtitleLabel];
        UIFont *font = [UIFont fontWithName:@"Marker Felt" size:19];
        _navtitleLabel.font = font;
        _navtitleLabel.textColor = [UIColor whiteColor];
    


}

#pragma mark====按钮的点击事件
- (void)butClick:(UIButton *)but{
    if (but==self.leftBut) {
        if (self.leftButClick) {
            _leftButClick();
        }
    }else{
        if (self.rightButClick) {
            self.rightButClick();
        }
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
