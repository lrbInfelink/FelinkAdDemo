//
//  FelinkAgBanner.h
//  FelinkAdSDK
//
//  Created by 刘瑞彬 on 2019/3/13.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FelinkAdCommon.h"

@class FelinkAgBanner;
@protocol FelinkAgBannerDelegate <NSObject>

@optional

//广告控件需要到屏幕上(使用广电通横幅广告必须实现)
- (void)felinkAdBannerNeedAddScreen:(FelinkAgBanner *)ad;

//收到广告
- (void)felinkAdBannerDidReceiveAd:(FelinkAgBanner *)ad;

//成功展示广告
- (void)felinkAdBannerSuccessPresentScreen:(FelinkAgBanner *)ad;

//广告失败
- (void)felinkAdBannerFail:(FelinkAgBanner *)ad error:(NSError *)error;

// 广告被点击
- (void)felinkAdBannerClicked:(FelinkAgBanner *)ad;

//结束广告
- (void)felinkAdBannerDidDismissScreen:(FelinkAgBanner *)ad;

//结束广告详细页
- (void)felinkAdBannerDidDismissDetail:(FelinkAgBanner *)ad;

// 广告跳到用户处理 若开发者处理改事件 返回YES；否则返回 NO，SDK会处理
- (BOOL)felinkAdBannerDirectClicked:(FelinkAgBanner *)ad data:(NSDictionary *)data;

//用户关闭广告  若开发者处理该事件 返回YES；否则返回 NO，SDK会处理
- (BOOL)felinkAdBannerDidClose:(FelinkAgBanner *)ad;
@end


@interface FelinkAgBanner : NSObject
@property (nonatomic ,weak) id<FelinkAgBannerDelegate> delegate;

/**
 获取代码位id
 */
@property (nonatomic,readonly,copy) NSString* adPid;

/**
 *  banner 是否可以使用定位，默认YES
 */
@property (nonatomic,assign) BOOL enableLocation;

/**
 *  banner 填充方式
 */
@property (nonatomic,assign) FelinkAdSizeStyle sizeStyle;

/**
 *  bannerView 高度是否适应广告大小，默认YES
 */
@property (nonatomic,assign) BOOL autoUpdateBannerSize;

/**
 *  banner 真实大小
 */
@property (nonatomic,readonly,assign) CGSize bannerSize;

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
 @param timeout 请求数据超时 建议5秒
 @param size  广告展示区域 推荐 (宽/高)   320:50    320:160     300:250
 @return <#return value description#>
 */
-(instancetype)initWithAdPid:(NSString *)adPid timeout:(NSTimeInterval)timeout size:(CGSize)size;

/**
 请求广告
 */
-(void)requestAd;
/**
 应用启动时展示开屏广告

 @param bannerView <#keyView description#>
 @param controller <#controller description#>
 */
- (void)showInView:(UIView *)bannerView controller:(UIViewController *)controller;


@end


