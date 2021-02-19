//
//  FelinkAgRewardVideoController.m
//  FelinkAdSDK_Example
//
//  Created by 刘瑞彬 on 2019/6/17.
//  Copyright © 2019 liyouleo911. All rights reserved.
//

#import "AgRewardVideoController.h"
#import <FelinkAdSDK/FelinkAdSDK.h>
@interface AgRewardVideoController ()<FelinkAgRewardVideoDelegate>
@property(nonatomic,strong)FelinkAgRewardVideo *felinkAgRewardVideo;
@property(nonatomic,strong)UIButton *showButton;
@end

@implementation AgRewardVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.aPid = @"101016";
    [self createTextFieldWithFrame:CGRectMake(10, 10, 300, 40) title:@"广告位:" value:self.aPid];
    
    [self createWithTitle:@"预加载视频" targat:@selector(viewAction:)].frame = CGRectMake(self.centerX - 100, 100, 200, 40);
    
    _showButton = [self createWithTitle:@"观看激励视频" targat:@selector(showAction:)];
    _showButton.frame = CGRectMake(self.centerX - 100, 200, 200, 40);
    _showButton.hidden = YES;
    [self createMessage:100 y:400];
    
}

-(void)viewAction:(UIButton *)sender{
     sender.hidden = YES;
    _felinkAgRewardVideo = [[FelinkAgRewardVideo alloc] initWithAdPid:self.aPid timeout:15.0];
    _felinkAgRewardVideo.delegate = self;
        
    [_felinkAgRewardVideo requestAd];

    
}

-(void)showAction:(UIButton *)sender{
    if (_felinkAgRewardVideo) {
        if(!_felinkAgRewardVideo.isAdValid){
            [self appendMessage:@"广告无效 "];
            return;
        }
        sender.hidden = YES;
        [_felinkAgRewardVideo showFromViewController:self];
    }

}

//收到广告
- (void)felinkAgRewardVideoDidReceiveAd:(FelinkAgRewardVideo *)ad{
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:[NSString stringWithFormat:@"收到广告"]];
    _showButton.hidden = NO;
}

//广告失败
- (void)felinkAgRewardVideoFail:(FelinkAgRewardVideo *)ad error:(NSError *)error{
    NSLog(@"%s", __FUNCTION__);
    self.message.text = [NSString stringWithFormat:@"%@", error];
}


//视频播放页即将打开
- (void)felinkAgRewardVideoSuccessPresentScreen:(FelinkAgRewardVideo *)ad{
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"展示广告"];
}


//广告完成播放
- (void)felinkAgRewardVideoDidFinish:(FelinkAgRewardVideo *)ad{
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"视频播放完"];
}

//用户点击下载/查看详情
- (void)felinkAgRewardVideoDidClick:(FelinkAgRewardVideo *)ad{
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"点击广告"];
}

//用户点击关闭
- (void)felinkAgRewardVideoDidClose:(FelinkAgRewardVideo *)ad{
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"用户关闭广告"];
}
//用户获取奖励
- (void)felinkAgRewardServerRewardDidSucceed:(FelinkAgRewardVideo *)ad reward:(FelinkAgRewardObject *)reward{
        NSLog(@"%s", __FUNCTION__);
     [self appendMessage:[NSString stringWithFormat:@"获取奖励 %ld", reward.rewardAmount]];
}

@end
