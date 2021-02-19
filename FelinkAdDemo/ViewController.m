//
//  ViewController.m
//  FelinkAdDemo
//
//  Created by 刘瑞彬 on 2019/5/14.
//  Copyright © 2019 felink. All rights reserved.
//

#import "ViewController.h"

#import "AgSplashViewController.h"
#import "AgBannerViewController.h"
#import <FelinkAdSDK/FelinkAdSDK.h>
#import "AgNativeViewController.h"
#import "AgRewardVideoController.h"
#import "AgInterstitialController.h"

@interface DataItem : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)Class classController;

-(instancetype)initWithTitle:(NSString *)title controller:(Class)controller;
@end

@implementation DataItem
-(instancetype)initWithTitle:(NSString *)title controller:(Class)controller{
    if (self = [super init]) {
        self.title = title;
        self.classController = controller;
    }
    return self;
}
@end

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray<DataItem *> *datas;
@end

@implementation ViewController
-(void)loadView{
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    view.delegate = self;
    view.dataSource = self;
    self.view = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [[NSMutableArray alloc] init];
    [_datas addObject:[[DataItem alloc] initWithTitle:@"开屏广告" controller:[AgSplashViewController class]]];
    [_datas addObject:[[DataItem alloc] initWithTitle:@"横幅广告" controller:[AgBannerViewController class]]];
    [_datas addObject:[[DataItem alloc] initWithTitle:@"信息流广告" controller:[AgNativeViewController class]]];
    [_datas addObject:[[DataItem alloc] initWithTitle:@"激励广告" controller:[AgRewardVideoController class]]];
    [_datas addObject:[[DataItem alloc] initWithTitle:@"插屏广告" controller:[AgInterstitialController class]]];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    cell.textLabel.text = [_datas objectAtIndex:indexPath.row].title;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_datas count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DataItem *dataItem = [_datas objectAtIndex:indexPath.row];
    UIViewController *controller  = [[dataItem.classController alloc] init];
    controller.title = dataItem.title;
    [self.navigationController pushViewController:controller  animated:YES];
    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
//    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:controller action:@selector(close)];
//    [self presentViewController:nav animated:YES completion:^{
//
//    }];
}


@end
