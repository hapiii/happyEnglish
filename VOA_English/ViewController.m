//
//  ViewController.m
//  VOA_English
//
//  Created by 王强 on 17/3/6.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "ViewController.h"
#import "RequestTool.h"

#define kLeftAnimationDuration 0.5
#define kRightAnimationDuration 0.5
#define kLeftViewWidth SCREEN_WIDTH*0.6
#define kRightViewWidth SCREEN_WIDTH*0.6
@interface ViewController ()



@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
     [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    __weak typeof(self) wself = self;
    
    self.centerVC.tapBarButton = ^(ShowState state) {
        
        [wself moveToVCWith:state];
    };
    
    //这里选择目录
    self.leftVC.selectCell = ^(NSInteger page) {
         NSArray *arr = [[RequestTool shareTool] getTheDoucmentofTheHome];
         DocumentModel *model = arr[page];
      
        NSMutableArray *ArtListArr = [NSMutableArray new];
        
        for (ArticalListModel *artModel in model.documentList) {
            //标题追加到数组中
            [ArtListArr addObject:artModel];
        }
        
        wself.centerVC.dataSource = ArtListArr;
        [wself.centerVC.tb reloadData];
    };
}



- (void)setupUI {
    
    self.centerVC = [[VECenterViewController alloc] init];
    self.leftVC = [[VELeftViewController alloc] init];
   
    self.centerVC.view.frame = self.view.bounds;
    self.leftVC.view.frame = self.view.bounds;

    [self.centerView addSubview:self.centerVC.view];
    [self.view addSubview:self.centerView];
   
    
}


- (void)moveToVCWith:(ShowState)state {
    
    //将页面
    [self prepareViewWith:state];
    NSTimeInterval duration = state == ShowStateLeft ? kLeftAnimationDuration : kRightAnimationDuration;
    CGFloat left = state == ShowStateLeft ? kLeftViewWidth : -kRightViewWidth;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:10 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.centerView.left = left;
        
    } completion:^(BOOL finished) {
        [self.centerView addSubview:self.closeView];
        self.currentShow = state;
    }];

}

- (void)prepareViewWith:(ShowState)state {
    if (state == ShowStateLeft) {
        
        [self.leftView addSubview:self.leftVC.view];
        //在指定的位置插入子视图，视图的所有视图其实组成了一个数组
        [self.view insertSubview:self.leftView belowSubview:self.centerView];
        
    } else {
    
    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark====懒加载
- (UIView *)centerView {
    if (_centerView == nil) {
        _centerView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _centerView;
}

- (UIView *)leftView {
    if (_leftView == nil) {
        _leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _leftView;
}


#pragma mark====用来关闭页面的View
- (UIView *)closeView {
    
    if (_closeView == nil) {
        
        _closeView = [[UIView alloc] initWithFrame:self.view.bounds];
        //添加轻按和移动手势
        [_closeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCloseView)]];
        [_closeView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)]];
        
    }
    return _closeView;
}

//轻按方法
- (void)handleCloseView {
    
    [UIView animateWithDuration:kLeftAnimationDuration animations:^{
        self.centerView.left = 0;
    } completion:^(BOOL finished) {
        [self.closeView removeFromSuperview];
        [self.leftView removeFromSuperview];
        
      
    }];
}
//移动手势方法
- (void)handlePanGesture:(UIPanGestureRecognizer*)panGesture
{
    UIGestureRecognizerState state = panGesture.state;
    
    CGPoint translation = [panGesture translationInView:self.view];
    
    switch (state) {
            //获取当前显示的是什么页面
        case UIGestureRecognizerStateBegan: {
            self.currentShow = self.centerView.left > 0 ? ShowStateLeft : ShowStateRight;
        }
            break;
            
            //发生改变时，
        case UIGestureRecognizerStateChanged: {
            CGRect centerFrame = self.centerView.frame;
            centerFrame.origin.x += translation.x;
            BOOL shouldClose = NO;
            
            if (self.currentShow == ShowStateRight) {
                if (centerFrame.origin.x >= 0) {
                    centerFrame.origin.x = 0;
                    shouldClose = YES;
                }
            } else {
                if (centerFrame.origin.x <= 0) {
                    centerFrame.origin.x = 0;
                    shouldClose = YES;
                }
            }
            
            
            self.centerView.frame = centerFrame;
            //关闭页面
            if (shouldClose) {
                [self handleCloseView];
            }
        }
            
            break;
        default: {
            BOOL shouldClose = YES;
            CGFloat left = 0.0;
            if (self.currentShow == ShowStateLeft) {
                //如果左边坐标大于总宽度的一半，则不关闭
                if (self.centerView.left > kLeftViewWidth/2) {
                    shouldClose = NO;
                    left = kLeftViewWidth;
                }
            } else {
                if (self.centerView.left < -kRightViewWidth/2) {
                    shouldClose = NO;
                    left = -kRightViewWidth;
                }
            }
            
            if (shouldClose) {
                [self handleCloseView];
            
            } else {
                 //平移动画
                [UIView animateWithDuration:self.currentShow == ShowStateLeft ? kLeftAnimationDuration / 2.0 : kRightAnimationDuration / 2.0 animations:^{
                    self.centerView.left = left;
                }];
            }
        }
            break;
    }
    //手势归零
    [panGesture setTranslation:CGPointZero inView:self.view];
}




@end
