//
//  AgBannerViewController.m
//  FelinkAdDemo
//
//  Created by 刘瑞彬 on 2019/3/22.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

#import "AgBannerViewController.h"

#import <FelinkAdSDK/FelinkAdSDK.h>
#import "UIWebViewController.h"
@interface AgBannerViewController () <FelinkAgBannerDelegate>
@property (nonatomic, strong) FelinkAgBanner *felinkAgBanner;
@property (nonatomic, strong) UIView *banner;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UISwitch *fitedSizeSwitch;
@property (nonatomic, assign) BOOL isUserHandler;
@end


@implementation AgBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
   [self createWithTitle:@"高度：100" targat:@selector(heightAction:)].frame = CGRectMake(10,10,self.view.frame.size.width * 0.3, 40);
    
    self.aPid = @"100327";

    [self createTextFieldWithFrame:CGRectMake(self.view.frame.size.width * 0.3, 10, self.view.frame.size.width * 0.7, 40) title:@"广告位:" value:self.aPid];
    _fitedSizeSwitch = [self createSwitchWithFrame:CGRectMake(5, 55, 160, 30) title:@"适应大小" targat:@selector(switchAction:)];
    _fitedSizeSwitch.on = YES;

    UISwitch *uiswitch = [self createSwitchWithFrame:CGRectMake(150, 55, 240, 30) title:@"开启用户处理" targat:@selector(switchUserAction:)];
    uiswitch.on = _isUserHandler;

    _segmentedControl = [self createSegmentControlWithFrame:CGRectMake(5, 90, 300, 30) titles:@[ @"服务端", @"客户端" ] targat:@selector(segmentCotrolAction:)];
    _segmentedControl.selectedSegmentIndex = 0;

    _banner = [[UIView alloc] initWithFrame:CGRectMake(5, 125, self.view.frame.size.width - 10, 0)];
    _banner.backgroundColor = [UIColor grayColor];
    _banner.layer.masksToBounds = YES;
    _banner.layer.borderWidth = 2;
    _banner.layer.borderColor = [[UIColor blueColor] CGColor];

    [self.view addSubview:_banner];

    [self createWithTitle:@"请求并展示" targat:@selector(viewAction:)].frame = CGRectMake(self.centerX - 100, 358, 200, 40);

    [self createMessage:100 y:400];

    _size = CGSizeMake(640, 320);
}
- (void)switchAction:(UISwitch *)sender {
}
- (void)segmentCotrolAction:(UISegmentedControl *)sender {
}

- (void)switchUserAction:(UISwitch *)sender {
    _isUserHandler = sender.on;
}

-(void)heightAction:(UIButton *)sender{
      _banner.frame = CGRectMake(5, 125, self.view.frame.size.width - 10, (self.view.frame.size.width - 10) *_size.height / _size.width);
}

- (void)viewAction:(UIButton *)sender {
    sender.hidden = YES;
    _felinkAgBanner = [[FelinkAgBanner alloc] initWithAdPid:self.aPid timeout:15.0 size:_size];
    _felinkAgBanner.delegate = self;

    _felinkAgBanner.sizeStyle = _segmentedControl.selectedSegmentIndex;
    _felinkAgBanner.autoUpdateBannerSize = _fitedSizeSwitch.on;

    [_felinkAgBanner requestAd];
    [_felinkAgBanner showInView:_banner controller:self];
}

//收到广告
- (void)felinkAdBannerDidReceiveAd:(FelinkAgBanner *)ad {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:[NSString stringWithFormat:@"收到广告 %@", NSStringFromCGSize(ad.bannerSize)]];
}

//成功展示广告
- (void)felinkAdBannerSuccessPresentScreen:(FelinkAgBanner *)ad {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"展示广告"];
}

//广告失败
- (void)felinkAdBannerFail:(FelinkAgBanner *)ad error:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
    self.message.text = [NSString stringWithFormat:@"%@", error];
}

// 广告被点击
- (void)felinkAdBannerClicked:(FelinkAgBanner *)ad {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"点击广告"];
}

//结束广告
- (void)felinkAdBannerDidDismissScreen:(FelinkAgBanner *)ad {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"结束广告"];
}

//结束广告详细页
- (void)felinkAdBannerDidDismissDetail:(FelinkAgBanner *)ad {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"结束广告详细页"];
}

// 广告跳到用户处理
- (BOOL)felinkAdBannerDirectClicked:(FelinkAgBanner *)ad data:(NSDictionary *)data {
    NSLog(@"%s  data=%@", __FUNCTION__, data);

    if (_isUserHandler) {
        UIWebViewController *webView = [[UIWebViewController alloc] initWithURLString:[data objectForKey:FelinkAd_Direct_deepLink]];
        [self.navigationController pushViewController:webView animated:YES];
        [self appendMessage:@"应用自己处理点击事件"];
        return YES;
    }
    [self appendMessage:@"应用自己不处理直投事件"];
    return NO;
    
}

//用户关闭广告
- (BOOL)felinkAdBannerDidClose:(FelinkAgBanner *)ad{
    NSLog(@"%s",__FUNCTION__);
    [self appendMessage:@"用户关闭广告"];
    return NO;
}
@end
