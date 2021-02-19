//
//  FelinkAgRewardObject.h
//  FelinkAdSDK
//
//  Created by 刘瑞彬 on 2019/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FelinkAgRewardObject : NSObject
@property (nonatomic, copy) NSString *userId;

//optional. reward name.
@property (nonatomic, copy) NSString *rewardName;

//optional. number of rewards.
@property (nonatomic, assign) NSInteger rewardAmount;

//optional. serialized string.
@property (nonatomic, copy) NSString *extra;
@end

NS_ASSUME_NONNULL_END
