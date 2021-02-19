//
//  AppDelegate.m
//  FelinkAdDemo
//
//  Created by 刘瑞彬 on 2019/5/14.
//  Copyright © 2019 felink. All rights reserved.
//

#import "AppDelegate.h"
#import <FelinkAdSDK/FelinkAdSDK.h>
#import "LoadingView.h"
#import "ViewController.h"
#define APP_ID  @"fb6e8f0b4507491c848eebf95dd56d06"
#define kSplashAd @"100328"



@interface AppDelegate ()
@property(nonatomic,strong)FelinkAgSplash *felinkAgSplash;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic,strong)ViewController *viewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FelinkAdSDK initAppID:APP_ID];
    [FelinkAdSDK setDebug:YES];
    NSLog(@"FelinkAdSDK version = %@",[FelinkAdSDK sdkVersion]);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _viewController = [[ViewController alloc] init];
    _window.rootViewController =[[UINavigationController alloc] initWithRootViewController:_viewController];
    [_window makeKeyAndVisible];
    
    _loadingView = [[LoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:_loadingView];
    
    
    _felinkAgSplash = [[FelinkAgSplash alloc] initWithAdPid:kSplashAd timeout:3];
    [_felinkAgSplash requestAd];
    [_felinkAgSplash showInWindow:[UIApplication sharedApplication].keyWindow view:_loadingView withBottomView:nil controller:_viewController];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
