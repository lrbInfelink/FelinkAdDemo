//
//  FelinkCommon.h
//  felinkSDK
//
//  Created by 刘瑞彬 on 2019/3/4.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

/**
 *  广告展示失败类型枚举
 */
typedef enum _FelinkAdFailReason {
    //其它错误
    FelinkAdFailReason_NONE = 0,
    
    //应用程序ID 没有设置
    FelinkAdFailReason_AppID = 100,
    
    //网络或其它异常
    FelinkAdFailReason_NETWORK = 101,
    
    
    //超时
    FelinkAdFailReason_TIMEOUT = 103,
    
    //请求异常
    FelinkAdFailReason_EXCEPTION = 102,
    
    //没有推广返回
    FelinkAdFailReason_NONE_AD = 104,
    //没有配置广告主
    FelinkAdFailReason_NONE_ADHOST = 105,
    
    //广告尺寸异常，不显示广告
    FelinkAdFailReason_FRAME = 106
    
} FelinkAdFailReason;



/**
 *  banner广告展示样式 （以宽度为基准）
 */
typedef NS_ENUM(NSInteger, FelinkAdSizeStyle) {
    //服务端制定
    FelinkAdSizeStyle_Server = 0,
    //客户端制定
    FelinkAdSizeStyle_Client = 1,
};

typedef NS_ENUM(NSInteger, FelinkAdMaterialType) {
    // 一般图文或图片广告
    FelinkAdMaterialType_NORMAL = 0,
    // 视频广告，需开发者增加播放器支持
    FelinkAdMaterialType_VIDEO = 1,
    // 浏览器 也是模版
    FelinkAdMaterialType_HTML = 2,
};

#define FelinkAd_Direct_adid       @"adid"
#define FelinkAd_Direct_deepLink   @"deepLink"
#define FelinkAd_Direct_clickUrl   @"clickUrl"
#define FelinkAd_Direct_extFields  @"extFields"
