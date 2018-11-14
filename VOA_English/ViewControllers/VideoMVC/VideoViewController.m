//
//  VideoViewController.m
//  VOA_English
//
//  Created by 王强 on 2017/3/28.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController (){
    BOOL shouldAutorotate;
}

@end

@implementation VideoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    // 调用playerView的layoutSubviews方法
    
    if (self.playerView) {
        [self.playerView setNeedsLayout];
    }
    
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }
    

    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView pause];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
    // Do any additional setup after loading the view.
}

- (void)loadData{
   
    [self dispathLoad:^{
     self.model = [[RequestTool shareTool] getTheVideoDetailFromTheUrl:self.videoUrl];
    } mainQueue:^{
        
    [self createPlayer];
    [self createTableView];
    [self.tb reloadData];
        
    }];

}

- (void)createPlayer{
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topView];
    [topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_offset(20);
    }];
     self.playerView = [[ZFPlayerView alloc] init];
    [self.view addSubview:self.playerView];
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        //注意此处，宽高比16：9优先级比1000低就行，在因为iPhone 4S宽高比不是16：9
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
    }];
    
    // 设置播放前的占位图（需要在设置视频URL之前设置）
    self.playerView.placeholderImageName = @"videoHolder";
    self.playerView.videoURL = [NSURL URLWithString: self.model.VideoUrl];
  
    
    // 设置标题
    self.playerView.title = self.videoTitle;
    //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    
    // 如果想从xx秒开始播放视频
    // self.playerView.seekTime = 15;
     [self.playerView autoPlayTheVideo];//自动播放
    __weak typeof(self) weakSelf = self;
    
    self.playerView.goBackBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };

}

- (void)createTableView{
   
        if (iPhone4s) {
            self.tb = [[VideoListTableView alloc] initWithFrame:CGRectMake(0,self.playerView.frame.size.height+20,ScreenWidth,ScreenHeight- CGRectGetMaxY(self.playerView.frame)-50) style:UITableViewStyleGrouped andModel:self.model];
        }else{
            self.tb = [[VideoListTableView alloc] initWithFrame:CGRectMake(0,self.playerView.frame.size.height+20,ScreenWidth,ScreenHeight- CGRectGetMaxY(self.playerView.frame)-145) style:UITableViewStyleGrouped andModel:self.model];
            
        }
    
    //self.tb.model = self.model;
    __weak typeof(self) wself = self;
    //点击cell刷新数据
    _tb.VIdeoListTableViewSelectCell = ^(ArticalListModel  *model){
        
    
       
      
        //移除所有的子视图
        for(UIView *view in [wself.view subviews])
        {
            if (view == self.playerView) {
                
                [wself.playerView pause];//暂停
               }else{
                
                [view removeFromSuperview];
            }
            
            
        }
       
        
        wself.videoTitle = model.articalTitle;
        wself.videoUrl = [NSString stringWithFormat:@"http://www.51voa.com/VOA_Videos/%@",model.ArticalUrl];
         [wself loadData];
       
        
    };
    

    [self.view addSubview:self.tb];
   

}



-(BOOL)shouldAutorotate
{
    return YES;
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"旋转啦");
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
        //if use Masonry,Please open this annotation
        
         [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(20);
         }];
        self.tb.hidden = NO;
         
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view.backgroundColor = [UIColor blackColor];
        //if use Masonry,Please open this annotation
        
         [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(0);
         }];
        self.tb.hidden = YES;
         
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
