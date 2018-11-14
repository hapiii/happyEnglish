//
//  BaseViewController.m
//  VOA_English
//
//  Created by 王强 on 17/3/6.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworkReachabilityManager.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
    [self checkNetwork];
}

- (void)hideNavBar:(BOOL)ishide {
    
    _statusBarHidden = ishide;
    [self.navigationController setNavigationBarHidden:ishide animated:YES];
    
}
#pragma mark  － 自定义提示框
-(void)showmyAlart:(NSString *)string inView:(UIView *)view{
    
    __block UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, (SCREENH_HEIGHT- 33) / 2, SCREEN_WIDTH - 200, 33)];
    label.backgroundColor = [UIColor blackColor];
    label.text = string;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 3.0f;
    [view addSubview:label];
    
    [UIView animateWithDuration:2.5 animations:^{
        label.alpha = 0;
    }completion:^(BOOL finished) {
        [label removeFromSuperview];
        label = nil;
    }];
    
}

#pragma mark 封装异步加载请求
-(void)dispathLoad:(void (^)())block mainQueue:(void (^)())mainBlock{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [SVProgressHUD show];
        // 处理耗时操作的代码块...
        block();
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            mainBlock();
        [SVProgressHUD dismiss];
        });
        
    });
    
}
- (BOOL)shouldAutorotate{
    return NO;
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return NO;
//}
//禁止横屏
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
#pragma mark - 检测网络
- (void)checkNetwork{
    //创建一个监听者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manger startMonitoring];
    
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case
                AFNetworkReachabilityStatusUnknown :{
                    
                   
                }
                break;
            case
            AFNetworkReachabilityStatusNotReachable:{
               
                [SVProgressHUD showInfoWithStatus:@"网络错误，请稍后重试"];
               
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
               
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
               
                
            }
                break;
            default:
                break;
        }
    }];
}


#pragma mark====截屏方法
- (UIImage *)screenShotinView:(UIViewController *)vc{
    
   
    
    
    // 将要被截图的view,即窗口的根控制器的view
    //UIViewController *beyondVC = self.view.window.rootViewController;
    // 背景图片 总的大小
    CGSize size = vc.view.frame.size;
    // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    // 要裁剪的矩形范围
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
    [vc.view drawViewHierarchyInRect:rect  afterScreenUpdates:NO];
    // 从上下文中,取出UIImage
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    // 添加截取好的图片到图片数组
    // 千万记得,结束上下文(移除栈顶的基于当前位图的图形上下文)
    UIGraphicsEndImageContext();
    
    return snapshot;
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
