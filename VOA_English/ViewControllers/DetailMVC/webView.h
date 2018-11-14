//
//  webView.h
//  VOA_English
//
//  Created by 王强 on 17/3/14.
//  Copyright © 2017年 王强. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface webView : WKWebView<WKUIDelegate,WKNavigationDelegate>

- (instancetype)initWithFrame:(CGRect)frame WithTheHTMLString:(NSString *)str;
@end
