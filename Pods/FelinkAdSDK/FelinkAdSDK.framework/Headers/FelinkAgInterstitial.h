//
//  FelinkAgInterstitial.h
//  FelinkAdSDK
//
//  Created by 刘瑞彬 on 2019/6/21.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FelinkAdCommon.h"

@class FelinkAgInterstitial;
@protocol FelinkAgInterstitialDelegate <NSObject>


//收到广告
- (void)felinkAgInterstitialDidReceiveAd:(FelinkAgInterstitial *)ad;

//成功展示广告
- (void)felinkAgInterstitialSuccessPresentScreen:(FelinkAgInterstitial *)ad;

//广告失败
- (void)felinkAgInterstitialFail:(FelinkAgInterstitial *)ad error:(NSError *)error;

// 广告被点击
- (void)felinkAgInterstitialClicked:(FelinkAgInterstitial *)ad;

//结束广告
- (void)felinkAgInterstitialDidDismissScreen:(FelinkAgInterstitial *)ad;

//结束广告详细页
- (void)felinkAgInterstitialDidDismissDetail:(FelinkAgInterstitial *)ad;

// 广告跳到用户处理 若开发者处理该事件 返回YES；否则返回 NO，SDK会处理
- (BOOL)felinkAgInterstitialDirectClicked:(FelinkAgInterstitial *)ad data:(NSDictionary *)data;

//用户关闭广告
- (void)felinkAgInterstitialDidClose:(FelinkAgInterstitial *)ad;

@end

@interface FelinkAgInterstitial : NSObject
@property (nonatomic ,weak) id<FelinkAgInterstitialDelegate> delegate;
/**
 获取代码位id
 */
@property (nonatomic,readonly,copy) NSString* adPid;

/**
 * 广告正在请求中
 */
@property (nonatomic,readonly,assign) BOOL adRequesting;

/**
 * hidesBottomBarWhenPushed  等
 *只对风灵自己广告有效，对第三方SDK无效
 */
@property (nonatomic, strong) NSDictionary *extraProperties;

/**
 初值
 
 @param adPid 广告位
 @param timeout 请求数据超时 建议3秒
 
 */
-(instancetype)initWithAdPid:(NSString *)adPid timeout:(NSTimeInterval)timeout;

/**
 * 请求广告
 */
-(void)requestAd;

/**
 * 展示广告，在调用之前 请先调用isAdValid
 */
-(void)showFromViewController:(UIViewController *)vc;

/**
 *  插屏广告预加载是否完成
 */
@property (nonatomic, readonly) BOOL isAdValid;
/*
 * 收到广告后
 * 1.获取直投定制信息
 */
-(NSDictionary *)getCurrentAdExtInfo;
@end


