//
//  FelinkAgSplash.h
//  FelinkAdSDK
//
//  Created by 刘瑞彬 on 2019/3/7.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FelinkAdCommon.h"


@class FelinkAgSplash;
@protocol FelinkAgSplashDelegate <NSObject>
@optional

//收到广告
- (void)felinkAdSplashDidReceiveAd:(FelinkAgSplash *)ad;

//成功展示广告
- (void)felinkAdSplashSuccessPresentScreen:(FelinkAgSplash *)ad;

//广告失败
- (void)felinkAdSplashFail:(FelinkAgSplash *)ad error:(NSError *)error;

// 广告被点击
- (void)felinkAdSplashClicked:(FelinkAgSplash *)ad;

//结束广告
- (void)felinkAdSplashDidDismissScreen:(FelinkAgSplash *)ad;

//结束广告详细页
- (void)felinkAdSplashDidDismissDetail:(FelinkAgSplash *)ad;

// 广告跳到用户处理 若开发者处理改事件 返回YES；否则返回 NO，SDK会处理
- (BOOL)felinkAdSplashDirectClicked:(FelinkAgSplash *)ad data:(NSDictionary *)data;

//用户点击跳过广告 (并不所有广告跳过都被调用)
- (void)felinkAdSplashSkipped:(FelinkAgSplash *)ad;

@end

@interface FelinkAgSplash : NSObject
@property (nonatomic ,weak) id<FelinkAgSplashDelegate> delegate;

/**
 设置广告View  背景颜色
 */
@property (nonatomic ,strong) UIColor *adBackgroundColor;

/**
 在bottomView != nil 时 底部 log 区域 高度；
 gdt 还需要 bottomView高度不能为0
 bottomHeight >= bottomView高度
 */
@property (nonatomic ,assign) CGFloat bottomHeight;
/**
 获取代码位id
 */
@property (nonatomic,readonly,copy) NSString* adPid;

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
 请求广告
 */
-(void)requestAd;
/**
 //展示开屏广告 或广告将展示 window 或 keyView

 @param keyWindow window(必须的)
 @param keyView 用来展示广告 可以nil, keyView 自动移除
 @param bottomView 展示logo 可以nil
 @param controller 来push广告 可以nil
 */
- (void)showInWindow:(UIWindow *  _Nonnull)keyWindow view:(UIView *_Nullable)keyView withBottomView:(UIView * _Nullable)bottomView controller:(UIViewController * _Nullable)controller;
    
    
@end
