//
//  VECenterViewController.m
//  VOA_English
//
//  Created by 王强 on 17/3/7.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "VECenterViewController.h"

@interface VECenterViewController ()

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
        _tb = [[TypeListTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64) style:UITableViewStylePlain];
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
   
  
  
    [self.view addSubview:self.tb];
//     UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREENH_HEIGHT-64)];
//    if (_tb.ListArr.count==0) {
//       
//        [self.view addSubview:iv];
//        iv.image = [UIImage imageNamed:@"getIn"];
//    }else{
//        [iv removeFromSuperview];
//        iv = nil;
//    }
    
}

- (IBAction)butClick:(UIButton *)sender {
    
    [self checkNetwork];
    ShowState state = sender.tag == 101 ?  ShowStateRight:ShowStateLeft;
    
    if (self.tapBarButton){
      self.tapBarButton(state);
    }

}
- (IBAction)rightBut:(UIButton *)sender {
    
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
