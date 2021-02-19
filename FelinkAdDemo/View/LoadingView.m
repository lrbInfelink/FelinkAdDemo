//
//  LoadingView.m
//  FelinkAdDemo
//
//  Created by 刘瑞彬 on 2019/3/14.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()
@property(nonatomic,strong)UIActivityIndicatorView  *indicatorView;
@end


@implementation LoadingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.image =[self getLaunchImage];
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview: _indicatorView];
        [_indicatorView startAnimating];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.center = self.center;
        [self setUserInteractionEnabled:YES];
    }
    return self;
}


-(UIImage *)getLaunchImage{
    UIImage *defaultLoadingImage = [UIImage imageNamed:@"loading_default_image"];
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (!defaultLoadingImage) {
        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
        NSArray *launchImages = [infoPlist objectForKey:@"UILaunchImages"];
        for (NSDictionary *launchImageInfo in launchImages) {
            CGSize imageSize = CGSizeFromString([launchImageInfo objectForKey:@"UILaunchImageSize"]);
            if (imageSize.width == size.width && imageSize.height == size.height) {
                NSString *lastImageName = [launchImageInfo objectForKey:@"UILaunchImageName"];
                defaultLoadingImage = [UIImage imageNamed:lastImageName];
                if (defaultLoadingImage) {
                    return defaultLoadingImage;
                }
            }
        }
    }
    return [UIImage imageNamed:@"LaunchImage"];
}
-(void)stopIndicator{
    if ([_indicatorView isAnimating]) {
        [_indicatorView stopAnimating];
    }
     [_indicatorView removeFromSuperview];
}

@end
