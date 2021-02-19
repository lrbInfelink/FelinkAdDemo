//
//  AgInterstitialController.m
//  FelinkAdSDK_Example
//
//  Created by 刘瑞彬 on 2019/6/21.
//  Copyright © 2019 liyouleo911. All rights reserved.
//

#import "AgInterstitialController.h"
#import "UIWebViewController.h"
#import <FelinkAdSDK/FelinkAdSDK.h>
@interface AgInterstitialController ()<FelinkAgInterstitialDelegate>
@property(nonatomic,strong)FelinkAgInterstitial *felinkAgInterstitial;
@property(nonatomic,strong)UIButton *showButton;
@end


@implementation AgInterstitialController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.aPid = @"101015";
    [self createTextFieldWithFrame:CGRectMake(10, 10, 300, 40) title:@"广告位:" value:self.aPid];
    
    [self createWithTitle:@"请求广告" targat:@selector(viewAction:)].frame = CGRectMake(self.centerX - 100, 100, 200, 40);
    
    _showButton = [self createWithTitle:@"展示广告" targat:@selector(showAction:)];
    _showButton.frame = CGRectMake(self.centerX - 100, 200, 200, 40);
    _showButton.hidden = YES;
    [self createMessage:100 y:400];
    
}

-(void)viewAction:(UIButton *)sender{
    sender.hidden = YES;
    _felinkAgInterstitial = [[FelinkAgInterstitial alloc] initWithAdPid:self.aPid timeout:15.0];
    _felinkAgInterstitial.delegate = self;
    
    [_felinkAgInterstitial requestAd];
    
}

-(void)showAction:(UIButton *)sender{
    if (_felinkAgInterstitial) {
        if(!_felinkAgInterstitial.isAdValid){
              [self appendMessage:@"广告无效 "];
            return;
        }
        sender.hidden = YES;
        [_felinkAgInterstitial showFromViewController:self];
    }
    
}



//收到广告
- (void)felinkAgInterstitialDidReceiveAd:(FelinkAgInterstitial *)ad{
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:[NSString stringWithFormat:@"收到广告"]];
    _showButton.hidden = NO;
}

//成功展示广告
- (void)felinkAgInterstitialSuccessPresentScreen:(FelinkAgInterstitial *)ad{
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"展示广告"];
}

//广告失败
- (void)felinkAgInterstitialFail:(FelinkAgInterstitial *)ad error:(NSError *)error{
    NSLog(@"%s", __FUNCTION__);
    self.message.text = [NSString stringWithFormat:@"%@", error];
}

// 广告被点击
- (void)felinkAgInterstitialClicked:(FelinkAgInterstitial *)ad{
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"点击广告"];
}

//结束广告
- (void)felinkAgInterstitialDidDismissScreen:(FelinkAgInterstitial *)ad{
    NSLog(@"%s",__FUNCTION__);
    [self appendMessage:@"结束广告"];
}

//结束广告详细页
- (void)felinkAgInterstitialDidDismissDetail:(FelinkAgInterstitial *)ad{
    NSLog(@"%s",__FUNCTION__);
    [self appendMessage:@"结束广告详细页"];
}

// 广告跳到用户处理 若开发者处理改事件 返回YES；否则返回 NO，SDK会处理
- (BOOL)felinkAgInterstitialDirectClicked:(FelinkAgInterstitial *)ad data:(NSDictionary *)data{
    UIWebViewController *webView = [[UIWebViewController alloc] initWithURLString:[data objectForKey:FelinkAd_Direct_deepLink]];
    [self.navigationController pushViewController:webView animated:YES];
    [self appendMessage:@"应用自己处理点击事件"];
    return YES;
}

//用户关闭广告
- (void)felinkAgInterstitialDidClose:(FelinkAgInterstitial *)ad{
    NSLog(@"%s",__FUNCTION__);
    [self appendMessage:@"用户关闭广告"];
}
@end
