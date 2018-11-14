//
//  webView.m
//  VOA_English
//
//  Created by 王强 on 17/3/14.
//  Copyright © 2017年 王强. All rights reserved.
//

#import "webView.h"

@implementation webView

- (instancetype)initWithFrame:(CGRect)frame WithTheHTMLString:(NSString *)str{
    self = [super initWithFrame:frame];
    
    
    [self loadHTMLString:str baseURL:nil];
    self.UIDelegate = self;
    self.navigationDelegate = self;
    [self createUI];
    return self;
    
}
- (void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self setOpaque:NO];//透明
   
    [self hiddenTheScrollIndicator];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    //字体大小
    NSString *sizeString;
    if (iPhone4s) {
         sizeString = [NSString stringWithFormat:@"\ndocument.body.style.fontSize=%f", 70.0];
    }else{
        sizeString = [NSString stringWithFormat:@"\ndocument.body.style.fontSize=%f", 50.0];
    }
    
//    NSString *jsCode = [NSString stringWithFormat:@"var i,L=document.images.length; \nfor(i=0;i<L;++i){ \ndocument.images[i].style.height = 'auto';\n document.images[i].style.width = 'auto'; %@}", sizeString];
    
    
    [webView evaluateJavaScript:sizeString completionHandler:nil];

        [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'" completionHandler:nil];
    
   
    [SVProgressHUD dismiss];
    
}

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    return nil;
//}

#pragma mark====隐藏滚动条的方法
- (void)hiddenTheScrollIndicator{
    
    for (UIView *_aView in [self subviews])
    {
        if ([_aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
            //右侧的滚动条
            
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            //下侧的滚动条
            
            for (UIView *_inScrollview in _aView.subviews)
            {
                if ([_inScrollview isKindOfClass:[UIImageView class]])
                {
                    _inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
                }
            }
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
