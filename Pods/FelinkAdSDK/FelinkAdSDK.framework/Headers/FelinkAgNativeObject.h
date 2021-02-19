//
//  FelinkAgNativeObject.h
//  FelinkAdSDK
//
//  Created by 刘瑞彬 on 2019/6/13.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FelinkAdCommon.h"

@interface FelinkAgNativeObject : NSObject
//获取该原生广告是否为三小图广告，当为三小图广告时，可以通过morePictures获取三张图片资源供渲染
@property (assign, nonatomic) FelinkAdMaterialType materialType;

@property (assign,readonly,nonatomic)  NSInteger index;

/**
 * 标题 text
 */
@property (copy, nonatomic)  NSString *title;
/**
 * 描述 text
 */
@property (copy, nonatomic)  NSString *desc;
/**
 * 小图 url
 */
@property (copy, nonatomic) NSString *iconImageURLString;
/**
 * 大图 url
 */
@property (copy, nonatomic) NSString *mainImageURLString;

/**
 * 品牌名称，若广告返回中无品牌名称则为空
 */
@property (copy, nonatomic)  NSString *brandName;

/**
 * 多图信息流的image url array
 */
@property (strong, nonatomic) NSArray *morePictures;

/**
  mainImage 素材宽度
 */
@property (nonatomic, assign) NSInteger imageWidth;

/**
 mainImage 素材高度
 */
@property (nonatomic, assign) NSInteger imageHeight;


/******************************以下控件 根据用户需求，初值化需求控件，SDK将自动填充内容****************************************/

/**
 * 必须被使用
 * 所有跟广告相关控件必须加到这个View 上
 * 如没有初值，将在 -(void)registerWithNativeObject:(FelinkAgNativeObject *)nativeObject;中 自动初值化
 * 自己初值化对象可能被篡改，展示时必须使用FelinkAgNativeObject.adView
 */
@property (nonatomic, strong) UIView *adView;
/**
 * 标题
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 * 描述 text
 */
@property (nonatomic, strong) UILabel *descLabel;
/**
 * 品牌名称，若广告返回中无品牌名称则为空
 */
@property (nonatomic, strong) UILabel *sourceLabel;

/**
 * 小图
 */
@property (nonatomic, strong) UIImageView *iconView;

/**
 * 大图
 * 如果有视频时 将被隐藏
 */
@property (nonatomic, strong) UIImageView *imageView;
/**
 * 如果有视频时，同时初值imageView， SDK自动初值
 * 用户初值时 对象不被接受
 */
@property (nonatomic, strong) UIView *videoView;

/**
 * 广告供应商图标
 * 可能对象将被篡改  使用时注意
 */
@property (nonatomic, strong) UIImageView *logoView;

/**
 * 广告图标
 * 可能对象将被篡改  使用时注意
 */
@property (nonatomic, strong) UIImageView *adLogoView;
/*
 *
 * 如果是风灵广告，返回相关信息
 */
-(NSDictionary *)getDirectAppInfo;
/*
 * 在展示广告前检查广告是否有效
 * 广告有效时间30分钟内
 */
-(BOOL)isAdValid;


@end


