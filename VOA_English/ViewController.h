//
//  ViewController.h
//  VOA_English
//
//  Created by 王强 on 17/3/6.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseModel.h"
#import "VECenterViewController.h"
#import "VELeftViewController.h"




@interface ViewController : BaseViewController

@property(strong,nonatomic)VECenterViewController *centerVC;
@property (strong,nonatomic)VELeftViewController *leftVC;


@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UIView *leftView;

@property (strong, nonatomic) UIView *closeView;
@property (nonatomic,assign)ShowState currentShow;

@property (nonatomic,assign)BOOL hasLoad;

@property (nonatomic,strong)NSArray *dataSource;




@end

