//
//  FelinkAgRewardVideo.h
//  FelinkAdSDK
//
//  Created by 刘瑞彬 on 2019/6/17.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FelinkAdCommon.h"
#import "FelinkAgRewardObject.h"

@class FelinkAgRewardVideo;
@protocol FelinkAgRewardVideoDelegate <NSObject>
@optional

//收到广告
- (void)felinkAgRewardVideoDidReceiveAd:(FelinkAgRewardVideo *)ad;

//广告失败
- (void)felinkAgRewardVideoFail:(FelinkAgRewardVideo *)ad error:(NSError *)error;


//视频播放页即将打开
- (void)felinkAgRewardVideoSuccessPresentScreen:(FelinkAgRewardVideo *)ad;


//广告完成播放
- (void)felinkAgRewardVideoDidFinish:(FelinkAgRewardVideo *)ad;

//用户点击下载/查看详情
- (void)felinkAgRewardVideoDidClick:(FelinkAgRewardVideo *)ad;

//用户点击关闭
- (void)felinkAgRewardVideoDidClose:(FelinkAgRewardVideo *)ad;

//用户获取奖励
- (void)felinkAgRewardServerRewardDidSucceed:(FelinkAgRewardVideo *)ad reward:(FelinkAgRewardObject *)reward;
@end

@interface FelinkAgRewardVideo : NSObject
@property (nonatomic, weak) id<FelinkAgRewardVideoDelegate> delegate;
/**
 获取代码位id
 */
@property (nonatomic, readonly, copy) NSString *adPid;

/**
 * 广告正在请求中
 */
@property (nonatomic,readonly,assign) BOOL adRequesting;
/**
 初值
 
 @param adPid 广告位
 @param timeout 请求数据超时 建议5秒
 @return <#return value description#>
 */
- (instancetype)initWithAdPid:(NSString *)adPid timeout:(NSTimeInterval)timeout;

/**
 请求广告
 */
-(void)requestAd;

/**
 展示广告
 */
-(void)showFromViewController:(UIViewController *)vc;

/**
 *  激励视频广告预加载是否完成,激励视频广告的展示存在有效期，单次检索后须在一定时间内展示在页面上
 */
@property (nonatomic, readonly) BOOL isAdValid;
@end

