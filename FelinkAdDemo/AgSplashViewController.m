//
//  AgSplashViewController.m
//  FelinkAdDemo
//
//  Created by 刘瑞彬 on 2019/3/7.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

#import "AgSplashViewController.h"
#import <FelinkAdSDK/FelinkAdSDK.h>
#import "UIWebViewController.h"
#import "LoadingView.h"
@interface AgSplashViewController ()<FelinkAgSplashDelegate>
@property(nonatomic,strong)FelinkAgSplash *felinkAgSplash;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic,assign)BOOL isUserHandler;
@end

@implementation AgSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.aPid = @"100328";
    _isUserHandler = YES;
   
    
    [self createTextFieldWithFrame:CGRectMake(10, 10, 300, 40) title:@"广告位:" value:self.aPid];
    UISwitch *uiswitch = [self createSwitchWithFrame: CGRectMake(self.centerX - 120, 60, 240, 30) title:@"开启用户处理" targat:@selector(switchAction:)];
    uiswitch.on = _isUserHandler;
    [self createWithTitle:@"不带logo和loading 开屏" targat:@selector(windowAction:)].frame = CGRectMake(self.centerX - 120, 150, 240, 40);
    
    [self createWithTitle:@"带logo和loading 开屏" targat:@selector(viewAction:)].frame = CGRectMake(self.centerX - 120, 250, 240, 40);
    [self createMessage:200];
}
                           
 -(void)switchAction:(UISwitch *)sender{
     _isUserHandler = sender.on;
 }

-(void)viewAction:(UIButton *)sender{
     self.message.text = @"";
    sender.hidden = YES;
    
    self.felinkAgSplash = [[FelinkAgSplash alloc] initWithAdPid: self.aPid timeout:3.0];
    _felinkAgSplash.delegate = self;

    UIImageView *logo =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logo.backgroundColor =[UIColor whiteColor];


    _loadingView = [[LoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:_loadingView];
    [_felinkAgSplash requestAd];
    
    
    [_felinkAgSplash showInWindow:[UIApplication sharedApplication].keyWindow view:_loadingView withBottomView:logo controller:self];
    _loadingView = nil;
}

-(void)actionLogo{
    _loadingView.hidden = YES;
    [_loadingView removeFromSuperview];
    _loadingView = nil;
}


-(void)windowAction:(UIButton *)sender{
    self.message.text = @"";
      sender.hidden = YES;
    self.felinkAgSplash = [[FelinkAgSplash alloc] initWithAdPid: self.aPid timeout:3.0];
    _felinkAgSplash.delegate = self;
  
    [_felinkAgSplash requestAd];

    [_felinkAgSplash showInWindow:[UIApplication sharedApplication].keyWindow view:nil withBottomView:nil controller:nil];
    
}


//收到广告
- (void)felinkAdSplashDidReceiveAd:(FelinkAgSplash *)ad{
      NSLog(@"%s",__FUNCTION__);
      [self appendMessage:[NSString stringWithFormat:@"收到广告 %@",ad.adPid]];
}

//成功展示广告
- (void)felinkAdSplashSuccessPresentScreen:(FelinkAgSplash *)ad{
      NSLog(@"%s",__FUNCTION__);
      [self appendMessage:@"展示广告"];
}

//广告失败
- (void)felinkAdSplashFail:(FelinkAgSplash *)ad error:(NSError *)error{
      NSLog(@"%s",__FUNCTION__);
      self.message.text = [NSString stringWithFormat:@"%@",error];
}

// 广告被点击
- (void)felinkAdSplashClicked:(FelinkAgSplash *)ad{
      NSLog(@"%s",__FUNCTION__);
      [self appendMessage:@"点击广告"];
}

//结束广告
- (void)felinkAdSplashDidDismissScreen:(FelinkAgSplash *)ad{
      NSLog(@"%s",__FUNCTION__);
    [self appendMessage:@"结束广告"];
}

//结束广告详细页
- (void)felinkAdSplashDidDismissDetail:(FelinkAgSplash *)ad{
      NSLog(@"%s",__FUNCTION__);
    [self appendMessage:@"结束广告详细页"];
}

// 广告跳到用户处理 若开发者处理改事件 返回YES；否则返回 NO，SDK会处理
- (BOOL)felinkAdSplashDirectClicked:(FelinkAgSplash *)ad data:(NSDictionary *)data{
    NSLog(@"%s",__FUNCTION__);
    if(_isUserHandler){
        UIWebViewController *webView = [[UIWebViewController alloc] initWithURLString:[data objectForKey:FelinkAd_Direct_deepLink]];
        [self.navigationController pushViewController:webView animated:YES];
        [self appendMessage:@"应用自己处理点击事件"];
        return YES;
    }
    [self appendMessage:@"应用自己不处理直投事件"];
    return NO;
}

//用户点击跳过
- (void)felinkAdSplashSkipped:(FelinkAgSplash *)ad{
    NSLog(@"%s",__FUNCTION__);
    [self appendMessage:@"用户点击跳过"];
}
@end
