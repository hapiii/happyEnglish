//
//  VECenterViewController.m
//  VOA_English
//
//  Created by 王强 on 17/3/7.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "VECenterViewController.h"

@interface VECenterViewController (){
    CGFloat _topHight;
}

@end

@implementation VECenterViewController

- (NSArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource = [NSArray new];
    }
    return _dataSource;
}

- (TypeListTableView *)tb{

    if (_tb==nil) {
       
        _tb = [[TypeListTableView alloc] initWithFrame:CGRectMake(0, _topHight, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStylePlain];
    }
    
    __weak typeof(self) wself = self;
    //点击cell跳转到列表页
    _tb.TypeListSelectCell = ^(ArticalListModel *model){
        ArticalListViewController *vc = [[ArticalListViewController alloc] init];
        vc.ListTitle  = model.articalTitle;
        vc.Url = model.ArticalUrl;
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
        //这里区分视频
            if ([model.articalTitle containsString:@"视频"]||[model.articalTitle containsString:@"News Words"]||[model.articalTitle containsString:@"影视"]){
            vc.isVideo = YES;
            
        }else{
            vc.isVideo = NO;
          }
         [wself.view.window.rootViewController presentViewController:navi animated:YES completion:nil];
    };
   //这里来数据
    _tb.ListArr = self.dataSource;
    return _tb;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.hidesBarsOnTap = YES;
    _topHight = 64;
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    if (@available(iOS 11.0, *)) {
        CGFloat bottomSafeInset = keyWindow.safeAreaInsets.bottom;
        if (bottomSafeInset == 34.0f || bottomSafeInset == 21.0f) { //获
            _topHight = 88;
        }
    }
    
    [self configUI];
    [self.view addSubview:self.tb];

   
    
}
-(void)configUI{
    
    UIView *topBG = [UIView new];
    [self.view addSubview:topBG];
    topBG.backgroundColor = WQRGBColor(250,56,101);
    UIButton *leftBtn = [UIButton new];
    [leftBtn setImage:[UIImage imageNamed:@"bookStore"] forState:UIControlStateNormal];
    leftBtn.tag = 100;
    [topBG addSubview:leftBtn];
    UIButton *rightBtn = [UIButton new];
    [rightBtn setImage:[UIImage imageNamed:@"night"] forState:UIControlStateNormal];
    rightBtn.tag = 101;
    [topBG addSubview:rightBtn];
    
    
    
    [topBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        
        make.height.offset(_topHight);
    }];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBG).offset(10);
        make.bottom.equalTo(topBG).offset(-5);
        make.width.height.offset(40);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topBG).offset(-10);
       make.bottom.equalTo(topBG).offset(-5);
        make.width.height.offset(40);
    }];
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"VOA English";
    titleLab.font = [UIFont fontWithName:@"MalayalamSangamMN-Bold" size:20.f];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [topBG addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topBG).offset(-10);
        make.left.right.bottom.equalTo(topBG);
    }];
    titleLab.textColor = [UIColor whiteColor];
    [leftBtn addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(rightBut:) forControlEvents:UIControlEventTouchUpInside];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self butClick:leftBtn];
    });
}


- (void)butClick:(UIButton *)sender {
    
    [self checkNetwork];
    ShowState state = sender.tag == 101 ?  ShowStateRight:ShowStateLeft;
    
    if (self.tapBarButton){
      self.tapBarButton(state);
    }

}

- (void)rightBut:(UIButton *)sender {
    
    if([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNormal]) {//将要切换至夜间模式
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        self.dk_manager.themeVersion = DKThemeVersionNight;
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:NightIsComming object:self userInfo:nil];
        // self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        
    } else {
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        self.dk_manager.themeVersion = DKThemeVersionNormal;
         //[[NSNotificationCenter defaultCenter] postNotificationName:LightIsComming object:self userInfo:nil];
         //self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
