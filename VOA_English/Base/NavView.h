//
//  NavView.h
//  VOA_English
//
//  Created by 王强 on 17/3/9.
//  Copyright © 2017年 王强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavView : UIView

@property (nonatomic,copy)void(^leftButClick)(void);//按左按钮的回调

@property (nonatomic,copy)void(^rightButClick)(void);//安右按钮的回调

@property (nonatomic,strong)UIButton *leftBut;

@property (nonatomic,strong)UIButton *rightBut;

@property (nonatomic,strong)UILabel *navtitleLabel;

@end
