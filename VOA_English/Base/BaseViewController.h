//
//  BaseViewController.h
//  VOA_English
//
//  Created by 王强 on 17/3/6.
//  Copyright © 2017年 王强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic) BOOL statusBarHidden;


-(void)showmyAlart:(NSString *)string inView:(UIView *)view;

//封装的异步请求
-(void)dispathLoad:(void (^)())block mainQueue:(void (^)())mainBlock;
//截屏方法
- (UIImage *)screenShotinView:(UIViewController *)vc;
- (void)checkNetwork;
@end
