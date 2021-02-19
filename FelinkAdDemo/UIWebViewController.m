//
//  UIWebViewController.m
//  FelinkAdDemo
//
//  Created by 刘瑞彬 on 2019/3/13.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

#import "UIWebViewController.h"

@implementation UIWebViewController

-(instancetype)initWithURLString:(NSString *)urlString{
    if (self = [super init]) {
        self.urlString = urlString;
    }
    return self;
}

-(void)loadView{
    _webView = [[WKWebView alloc] init];
    self.view = _webView;
    self.title = @"App 自己";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    [request setTimeoutInterval:30.0];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [_webView loadRequest:request];
    
}
@end
