//
//  MainWebController.m
//  VOA_English
//
//  Created by hapii on 2019/4/28.
//  Copyright © 2019 王强. All rights reserved.
//

#import "MainWebController.h"
#import <WebKit/WebKit.h>
#import "VEUrlMake.h"

@interface MainWebController ()
@property (nonatomic,strong)WKWebView *webView;

@end

@implementation MainWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    config.preferences.minimumFontSize = 10.0;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.processPool = [[WKProcessPool alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    [self.view addSubview:_webView];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self saveUserInfo]]];
    [self.webView loadRequest:request];
    // Do any additional setup after loading the view.
}
-(NSString *)saveUserInfo{
    //http://home.tuiguang5000.com/index.php/index/login/index
    NSString *str = @"http:";
    NSString *headStr = [str stringByAppendingString:@"//"];
    return [VEUrlMake shareTool].dealPath(headStr,@"com");
    
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
