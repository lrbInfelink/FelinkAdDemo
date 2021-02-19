//
//  UIWebViewController.h
//  FelinkAdDemo
//
//  Created by 刘瑞彬 on 2019/3/13.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface UIWebViewController : UIViewController
@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,readonly,strong)WKWebView *webView;
-(instancetype)initWithURLString:(NSString *)urlString;
@end


