//
//  ArticalListViewController.m
//  VOA_English
//
//  Created by 王强 on 17/3/8.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "ArticalListViewController.h"
#import "DetailViewController.h"
#import "VideoViewController.h"
#import <MJRefresh.h>
//最后一级的列表页，文章列表
@interface ArticalListViewController ()

@end

@implementation ArticalListViewController

- (ArticalTableView *)tb{
    
    if (_tb==nil) {
        _tb = [[ArticalTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    }
    
     _tb.ListArr = self.dataSource;
    __weak typeof(self) wself = self;
    //点击cell跳转
     _tb.ArticalTableViewSelectCell = ^(ArticalListModel  *model){
         if (wself.isVideo) {
             VideoViewController *vc = [[VideoViewController alloc] init];
             vc.videoTitle = model.articalTitle;
             vc.videoUrl = model.ArticalUrl;
             
             [wself.navigationController pushViewController:vc animated:YES];
             
         }else{
             DetailViewController *vc = [[DetailViewController alloc] init];
             vc.artModel = model;
            [wself.navigationController pushViewController:vc animated:YES];

         }
     };
   
    
    _tb.ifHidenTheNav = ^(BOOL hiden){
          [wself.navigationController setNavigationBarHidden:hiden animated:YES];
        
    };
     return _tb;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
     self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf0f0f0, 0x000000, 0xfafafa);
    [self createNav];
    
    [self.view addSubview:self.tb];
    
    
    [self createFresh];
    
    
    [self dispathLoad:^{
         self.dataSource = [[RequestTool shareTool] getTehListofTheUrlType:[NSString stringWithFormat:@"%@%@",VoaEnglish,_Url]];
    } mainQueue:^{
        [self.tb reloadData];
    }
     ];
    //去掉这种效果手势冲突，以后再说[self addPanAndSelector];
 
}

- (void)createFresh{
    
    //上拉刷新
    self.tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _index = 1;
        [self loadNewData];
    }];
    
    //下拉加载
    self.tb.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        ++_index;
        [self loadMoreData];
        //[self.tb reloadData];
    }];

}
#pragma mark 下拉刷新
-(void)loadNewData{
    
    __unsafe_unretained typeof(self) selfVC=self;
      dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
         NSArray *array = [[RequestTool shareTool] getTehListofTheUrlType:[NSString stringWithFormat:@"%@%@",VoaEnglish,[self getTheLoadUrl]]];
          
        if (nil !=array) {
            [self.dataSource removeAllObjects];
            self.dataSource = [NSMutableArray arrayWithArray:array];
        
            
            dispatch_async(dispatch_get_main_queue(), ^{

                [selfVC.tb reloadData];
                [selfVC.tb.mj_header endRefreshing];
            });
            
        }else{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [selfVC.tb.mj_header endRefreshing];
             });
            
        }
    });
}

#pragma mark 上拉加载更多
-(void)loadMoreData{
    
    __unsafe_unretained typeof(self) selfVC=self;
    __block NSArray *array=nil;
    [self dispathLoad:^{
        
        array = [[RequestTool shareTool] getTehListofTheUrlType:[NSString stringWithFormat:@"%@%@",VoaEnglish,[self getTheLoadUrl]]];
        if (nil !=array) {///VOA_Standard_1_2.html
                   [selfVC.dataSource addObjectsFromArray:array];
        }
    } mainQueue:^{
        if (array.count>0) {
            [self.tb reloadData];
            
        }
        [selfVC.tb.mj_footer endRefreshing];
    }];
    
}


#pragma mark====获取后缀的一大比逻辑，下拉加一
- (NSString *)getTheLoadUrl{
    
    NSString *ResultUrl = [NSString new];
    NSString *frontStr = [NSString new];
    NSString *behindStr = [NSString new];
    NSString *TheLastStr = [NSString new];
    
    if (_Url) {
       
        
        NSString *str = [_Url stringByDeletingPathExtension];//去掉.html
        NSArray *arr = [str componentsSeparatedByString:@"_"];
      
        
        if ([_Url containsString:@"archiver"]) {
           
             for (int i=0;i<arr.count;i++) {
                //[1,2,3] count = 3
                if (i<arr.count-2) {
                    NSString *addStr = [arr[i] stringByAppendingString:@"_"];
                    frontStr = [frontStr stringByAppendingString:addStr];
                }else if (i==arr.count-2){
                    
                }else{
                    if (i==arr.count-1) {//如果是最后一个，不追加_
                         NSString *addStr = [arr[i] stringByAppendingString:@""];
                         behindStr = [behindStr stringByAppendingString:addStr];
                    }else{
                        NSString *addStr = [arr[i] stringByAppendingString:@"_"];
                        behindStr = [behindStr stringByAppendingString:addStr];
                    }
                 }
               
            }
            
             TheLastStr = [NSString stringWithFormat:@"%@%i_%@.html",frontStr,_index,behindStr];
            
        }else{
          
            for (NSString *str in arr) {
                if (str ==[arr lastObject]) {
                   
                }else{
                    
                    NSString *addStr = [str stringByAppendingString:@"_"];
                    ResultUrl = [ResultUrl stringByAppendingString:addStr];
                }
        }
            
            TheLastStr = [NSString stringWithFormat:@"%@%i.html",ResultUrl,_index];
       
            
        }
        
        }
    return TheLastStr;
}

#pragma mark====伪导航条
- (void)createNav{
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(returnButClick)];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = WQRGBColor(250,55,102);
    
    self.navigationItem.leftBarButtonItem = search;
    UILabel *titleLab = [UILabel new];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = self.ListTitle;
    self.navigationItem.titleView = titleLab;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return YES;
    }
    
    return YES;
}
- (void)returnButClick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////添加移动手势
//- (void)addPanAndSelector{
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
//    [self.tb addGestureRecognizer:pan];
//    //背景的截图，用于侧滑返回
//    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREENH_HEIGHT)];
//    //iv.image = self.RetBgImg;
//    [self.view insertSubview:iv belowSubview:self.tb];
//
//}
//
//#pragma mark －实现移动手势
//-(void)panGesture:(UIPanGestureRecognizer *)pan{
//
//    UIGestureRecognizerState state = pan.state;
//    CGPoint point = [pan translationInView:self.view];
//    switch (state) {
//            //发生改变时，
//        case UIGestureRecognizerStateChanged: {
//            self.tb.center = CGPointMake(self.tb.center.x + point.x, self.tb.center.y);
//        }
//            break;
//        case UIGestureRecognizerStateEnded:{
//            if (self.tb.left > SCREEN_WIDTH*0.4) {
//                [self handleCloseView];//关闭
//            }else{
//                [UIView animateWithDuration:0.5 animations:^{
//                    self.tb.left = 0;
//                }];
//            }
//        }
//            break;
//
//        default: {
//
//            break;
//        }
//    }
//    //归零
//    [pan setTranslation:CGPointZero inView:self.view];
//
//}
//#pragma mark====解决手势冲突的方法
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 点击tableViewCell不执行Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"TableView"]) {
//        return NO;
//    }
//    return  YES;
//}
//
////可以识别多个手势
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}
//-(void)handleCloseView{
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
