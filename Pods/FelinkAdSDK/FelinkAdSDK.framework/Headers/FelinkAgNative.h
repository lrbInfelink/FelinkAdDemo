//
//  FelinkAgNative.h
//  FelinkAdSDK
//
//  Created by 刘瑞彬 on 2019/6/10.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FelinkAdCommon.h"
#import "FelinkAgNativeObject.h"

@class FelinkAgNative;
@protocol FelinkAgNativeDelegate <NSObject>

//收到广告
- (void)felinkAdNativeDidReceiveAd:(FelinkAgNative *)ad nativeObjects:(NSArray *)nativeObjects;
@optional

//大图完成加载 该方法不一定被回调;同一个nativeObject，可能一次调用都没有，也可能多次被调用
- (void)felinkAdNativeDidLoadMainImage:(FelinkAgNative *)ad nativeObject:(FelinkAgNativeObject *)nativeObject;

//成功展示广告
- (void)felinkAdNativeSuccessPresentScreen:(FelinkAgNative *)ad;

//广告失败
- (void)felinkAdNativeFail:(FelinkAgNative *)ad error:(NSError *)error;

// 广告被点击
- (void)felinkAdNativeClicked:(FelinkAgNative *)ad;

//结束广告详细页
- (void)felinkAdNativeDidDismissDetail:(FelinkAgNative *)ad;

// 广告跳到用户处理 若开发者处理该事件 返回YES；否则返回 NO，SDK会处理
- (BOOL)felinkAdNativeDirectClicked:(FelinkAgNative *)ad data:(NSDictionary *)data;

@end

@interface FelinkAgNative : NSObject

@property (nonatomic, weak) id<FelinkAgNativeDelegate> delegate;

/**
 *    获取代码位id
 */
@property (nonatomic, readonly, copy) NSString *adPid;

/**
  *   广告正在请求中
  */
@property (nonatomic, readonly, assign) BOOL adRequesting;

/**
 *用于点击广告后跳转
 */

@property (nonatomic, weak) UIViewController *viewController;


/**
 * hidesBottomBarWhenPushed  等
 *只对风灵自己广告有效，对第三方SDK无效
 */
@property (nonatomic, strong) NSDictionary *extraProperties;


/**
     初值
 
     @param adPid 广告位
     @param timeout 请求数据超时 建议5秒
     @param size  广告展示区域 推荐 (宽/高)  320:50    320:160     300:250
     @return <#return value description#>
     */
- (instancetype)initWithAdPid:(NSString *)adPid timeout:(NSTimeInterval)timeout size:(CGSize)size;

/**
  * 推荐请求广告不超3条
  * 最多10条
  */
-(void)requestAd:(NSInteger)adCount;
/*
 *先注册广告对象，否则广告展示、点击等无效
 */
-(void)registerWithNativeObject:(FelinkAgNativeObject *)nativeObject;

@end

