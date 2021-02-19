//
//  AgNativeViewController.m
//  FelinkAdSDK_Example
//
//  Created by 刘瑞彬 on 2019/6/10.
//  Copyright © 2019 liyouleo911. All rights reserved.
//

#import "AgNativeViewController.h"
#import <FelinkAdSDK/FelinkAdSDK.h>
#import <Masonry/Masonry.h>
#import "UIWebViewController.h"
#import <YYImage/YYImage.h>
#import <YYWebImage/YYWebImage.h>
@interface AgNativeViewController () <UITableViewDataSource, UITableViewDelegate, FelinkAgNativeDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FelinkAgNative *felinkAgNative;

@property (nonatomic, strong) NSMutableDictionary<NSString *, UIView *> *adViews;
@property (nonatomic, assign) NSInteger adCount;
@property(nonatomic,strong)UITextField *pid_textField;
@property(nonatomic,strong)UITextField *adCount_textField;
@property(nonatomic,strong) UISwitch *customAdViewSwitch;
@end

@implementation AgNativeViewController
- (void)loadView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    self.view = self.tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    _adCount = 3;
    self.aPid = @"100446";
   _pid_textField =  [self createTextFieldWithFrame:CGRectMake(20, 10, 300, 40) title:@"广告位:" value:self.aPid view:headerView];
    [self createWithTitle:@"请求广告" targat:@selector(viewAction:) view:headerView].frame = CGRectMake(5, 5, 100, 40);
    
    _customAdViewSwitch = [self createSwitchWithFrame: CGRectMake(0, 55, 160, 30) title:@"自定义底板" targat:@selector(switchAction:) view:headerView];
    _customAdViewSwitch.on = NO;
    
   _adCount_textField = [self createTextFieldWithFrame:CGRectMake(160, 55, 160, 40) title:@"广告数量:" value:[NSString stringWithFormat:@"%ld",self.adCount] view:headerView];
    [self createMessage:50 y:100 view:headerView];

    
    
    self.tableView.tableHeaderView = headerView;
    _adViews = [[NSMutableDictionary<NSString *, UIView *> alloc] init];
}
-(void)switchAction:(UISwitch *)sender{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (_pid_textField == textField) {
         self.aPid = textField.text;
    }else  if (_adCount_textField == textField) {
        self.adCount = [textField.text integerValue];
    }
   
}

- (void)viewAction:(UIButton *)sender {
    
    sender.hidden = YES;
    _felinkAgNative = [[FelinkAgNative alloc] initWithAdPid:self.aPid timeout:15.0 size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 150)];
    _felinkAgNative.delegate = self;
    _felinkAgNative.viewController = self;
    [_felinkAgNative requestAd:self.adCount];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_adViews != nil && [_adViews count] > 0) {
        NSString *adIdentifier = [NSString stringWithFormat:@"%ld_%ld", indexPath.section, indexPath.row];
        UIView *adView = [_adViews objectForKey:adIdentifier];

        if (adView != nil) {
            return adView.frame.size.height;
        }
    }
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 16 + [_adViews count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_adViews != nil && [_adViews count] > 0) {
        NSString *adIdentifier = [NSString stringWithFormat:@"%ld_%ld", indexPath.section, indexPath.row];
        UIView *adView = [_adViews objectForKey:adIdentifier];

        if (adView != nil) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adIdentifier];
                 [cell.contentView addSubview:adView];
            }else{
                  [self performSelector:@selector( startImageView:) withObject:cell.contentView afterDelay:1.0];
            }

//            NSArray *subview = [cell.contentView subviews];
//            for (UIView *view in subview) {
//                [view removeFromSuperview];
//            }

            //[cell.contentView addSubview:adView];
            return cell;
        }
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.layoutMargins = UIEdgeInsetsMake(5, 5, 5, 5);
    cell.textLabel.text = @"强降雨南下至华南 广东“龙舟水”进入多发期;";
    cell.detailTextLabel.text = @"中国天气网";
    cell.imageView.image = [UIImage imageNamed:@"info1"];
 
    return cell;
}

-(void)startImageView:(UIView *)parentview{
        NSArray *subview = [parentview subviews];
        for (UIView *view in subview) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [(UIImageView *)view  setImage:[(UIImageView *)view image]];
            }else{
                [self startImageView:view];
            }
        }
}

- (void)addAdCell:(FelinkAgNativeObject *)nativeObject {
    
    if (![nativeObject isAdValid]) {
        [self appendMessage:[NSString stringWithFormat:@"广告无效或过期"]];
        return;
    }
    if (![[_adViews allValues] containsObject:nativeObject.adView]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 + [_adViews count] * 2 inSection:0];
        NSString *adIdentifier = [NSString stringWithFormat:@"%ld_%ld", indexPath.section, indexPath.row];
        [_adViews setObject:nativeObject.adView forKey:adIdentifier];
        [self.tableView insertRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
    }

}




//收到广告
- (void)felinkAdNativeDidReceiveAd:(FelinkAgNative *)ad nativeObjects:(NSArray *)nativeObjects {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:[NSString stringWithFormat:@"收到广告"]];

    if (nativeObjects) {
        for (FelinkAgNativeObject *nativeObject in nativeObjects) {
            NSLog(@"DirectAppInfo = %@",[nativeObject getDirectAppInfo]);
            if (_customAdViewSwitch.on) {
                nativeObject.adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
                nativeObject.adView.backgroundColor = [UIColor redColor];
            }

            if(nativeObject.materialType == FelinkAdMaterialType_VIDEO){
                //视频 标题+大图+广告商图标+广告标语
                [self initStyle2:nativeObject];
                [ad registerWithNativeObject:nativeObject];
                [self layoutStyle2:nativeObject];
                
                //大图完成加载 时调用
                //[self addAdCell:nativeObject];
                
                if(nativeObject.videoView != nil){
                    [self addAdCell:nativeObject];
                }
            }else if(nativeObject.morePictures!=nil && [nativeObject.morePictures count]>2){
                  //多图
                [self initStyle4:nativeObject];
                [ad registerWithNativeObject:nativeObject];
                [self layoutStyle4:nativeObject];
                [self addAdCell:nativeObject];
                
            }else if (nativeObject.index == 1) {
               //标题+图标+广告标语
                [self initStyle1:nativeObject];
                [ad registerWithNativeObject:nativeObject];
                [self layoutStyle1:nativeObject];
                [self addAdCell:nativeObject];
                
            } else if (nativeObject.index == 2) {

                
                //所有元素
                [self allInfo:nativeObject];
                [ad registerWithNativeObject:nativeObject];
                nativeObject.adView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,340);
                nativeObject.adLogoView.frame = CGRectMake(286, 318, 24, 12);
                //大图完成加载 时调用
                //[self addAdCell:nativeObject];
                if(nativeObject.videoView != nil){
                    [self addAdCell:nativeObject];
                }
                
            }  else {
                //标题+大图+广告商图标+广告标语+描述 （有元素存在时显示）
                [self initStyle3:nativeObject];
                [ad registerWithNativeObject:nativeObject];
                [self layoutStyle3:nativeObject];
                [self addAdCell:nativeObject];
            }

      }
    }
}

//成功展示广告
- (void)felinkAdNativeSuccessPresentScreen:(FelinkAgNative *)ad {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"展示广告"];
}

//广告失败
- (void)felinkAdNativeFail:(FelinkAgNative *)ad error:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
    self.message.text = [NSString stringWithFormat:@"%@", error];
}

//大图完成加载
- (void)felinkAdNativeDidLoadMainImage:(FelinkAgNative *)ad nativeObject:(FelinkAgNativeObject *)nativeObject{
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"大图完成加载"];
    [self addAdCell:nativeObject];
}
// 广告被点击
- (void)felinkAdNativeClicked:(FelinkAgNative *)ad {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"点击广告"];
}

//结束广告
- (void)felinkAdNativeDidDismissScreen:(FelinkAgNative *)ad {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"结束广告"];
}

//结束广告详细页
- (void)felinkAdNativeDidDismissDetail:(FelinkAgNative *)ad {
    NSLog(@"%s", __FUNCTION__);
    [self appendMessage:@"结束广告详细页"];
}

// 广告跳到用户处理 若开发者处理改事件 返回YES；否则返回 NO，SDK会处理
- (BOOL)felinkAdNativeDirectClicked:(FelinkAgNative *)ad data:(NSDictionary *)data {
    NSLog(@"%s  data=%@",__FUNCTION__,data);
    
    UIWebViewController *webView = [[UIWebViewController alloc] initWithURLString:[data objectForKey:FelinkAd_Direct_deepLink]];
    [self.navigationController pushViewController:webView animated:YES];
    [self appendMessage:@"应用自己处理点击事件"];
    return YES;
}


//************************************ 通用方法 *******************************/
- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    return label;
}

- (CGFloat)imageHeight:(UIImage *)image defaultWidth:(CGFloat)width defaultheight:(CGFloat)height {
    if (image == nil) {
        return height;
    }
    return image.size.height *  width /image.size.width;
}

- (void)downloadImageWithURL:(NSURL *)url imageView:(UIImageView *)imageView {
        [(YYAnimatedImageView *)imageView yy_setImageWithURL:url placeholder:nil options:YYWebImageOptionProgressiveBlur |YYWebImageOptionShowNetworkActivity progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            if (stage == YYWebImageStageFinished) {

            }

        }];
}


//************************************   推荐 style 1 标题+图标+广告标语*******************************/
//style 1
- (void)initStyle1:(FelinkAgNativeObject *)nativeObject {
    nativeObject.titleLabel = [self createLabel];
    nativeObject.iconView = [[UIImageView alloc] init];
    nativeObject.adLogoView = [[UIImageView alloc] init];
}
- (void)layoutStyle1:(FelinkAgNativeObject *)nativeObject  {
    UIView *adView = nativeObject.adView;
    UIView *iconView = nativeObject.iconView;
    if (iconView != nil && iconView.superview != nil) {
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(adView).mas_offset(15);
            make.top.equalTo(adView).mas_offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
    }

    if (nativeObject.titleLabel != nil && nativeObject.titleLabel.superview != nil) {
        [nativeObject.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iconView == nil) {
                make.left.equalTo(adView).mas_offset(15);
            } else {
                if (iconView.superview == nil) {
                     make.left.equalTo(adView).mas_offset(15);
                }else{
                    make.left.equalTo(nativeObject.iconView.mas_right).mas_offset(10);
                }
                
            }
            make.right.equalTo(adView);
            make.top.equalTo(adView).mas_offset(10);
        }];
    }
    if (nativeObject.adLogoView != nil && nativeObject.adLogoView.superview != nil) {
        [nativeObject.adLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(adView).mas_offset(-10);;
            make.bottom.equalTo(adView);
            make.width.mas_equalTo(24);
            make.height.mas_equalTo(12);
        }];
    }
     adView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
}


//************************************ 推荐style 2  标题+大图+广告商图标+广告标语*******************************/

- (void)initStyle2:(FelinkAgNativeObject *)nativeObject{
    nativeObject.titleLabel = [self createLabel];
     CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    if (nativeObject.imageWidth > 0 && nativeObject.imageHeight > 0) {
        nativeObject.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width,  nativeObject.imageHeight * width / nativeObject.imageWidth)];
    }else{
        nativeObject.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
    }

    nativeObject.adLogoView = [[UIImageView alloc] init];
    nativeObject.logoView = [[UIImageView alloc] init];
}

- (void)layoutStyle2:(FelinkAgNativeObject *)nativeObject {
    UIView *adView = nativeObject.adView;
    UILabel *titleLabel = nativeObject.titleLabel;
    CGFloat titleLabel_height = 10;
    if (titleLabel != nil && titleLabel.superview != nil) {
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(adView).mas_offset(10);
            make.right.equalTo(adView).mas_offset(-10);
            make.top.equalTo(adView).mas_offset(10);
        }];
        titleLabel_height = [nativeObject.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : titleLabel.font } context:nil].size.height;
    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    CGFloat imageView_height = 120;
    if (nativeObject.imageWidth > 0 && nativeObject.imageHeight > 0) {
        imageView_height = nativeObject.imageHeight * width / nativeObject.imageWidth;
    }
    UIView *middleView = nil;
    switch (nativeObject.materialType) {
        case FelinkAdMaterialType_NORMAL:{
            UIImageView *imageView = nativeObject.imageView;
            if (imageView != nil && imageView.superview != nil) {
               
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(adView).mas_offset(10);
                    if (titleLabel == nil) {
                        make.top.equalTo(adView).mas_offset(10);
                    } else {
                        make.top.equalTo(titleLabel.mas_bottom).mas_offset(5);
                    }
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(imageView_height);
                }];
                

                middleView = imageView;
            }
            break;
        }
            
        case FelinkAdMaterialType_VIDEO:{
            UIView *videoView = nativeObject.videoView;
            if (videoView != nil && videoView.superview != nil) {
                [videoView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(adView).mas_offset(10);
                    if (titleLabel == nil) {
                        make.top.equalTo(adView).mas_offset(10);
                    } else {
                        make.top.equalTo(titleLabel.mas_bottom).mas_offset(5);
                    }
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(imageView_height);
                }];
                
                middleView = videoView;
            }
            break;
        }
            
        case FelinkAdMaterialType_HTML:{
            //logoView 和 adLogoView 不需要
        }
            
        default:
            break;
    }
    


    if (nativeObject.logoView != nil && nativeObject.logoView.superview != nil) {
        CGFloat width = 18;
        CGFloat height = [self imageHeight:nativeObject.logoView.image defaultWidth:18 defaultheight:18];
        [nativeObject.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (middleView == nil) {
                make.left.equalTo(adView);
                make.bottom.equalTo(adView);
            } else {
                make.left.equalTo(middleView);
                make.bottom.equalTo(middleView);
            }

            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }

    if (nativeObject.adLogoView != nil && nativeObject.adLogoView.superview != nil) {
        CGFloat width = 24;
        CGFloat height = [self imageHeight:nativeObject.adLogoView.image defaultWidth:24 defaultheight:12];
        [nativeObject.adLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (middleView == nil) {
                make.right.equalTo(adView);
                make.bottom.equalTo(adView);
            } else {
                make.right.equalTo(middleView);
                make.bottom.equalTo(middleView);
            }

            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }

    adView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, imageView_height + titleLabel_height + 15 + 10);
}


//************************************ style 3*******************************/

- (void)initStyle3:(FelinkAgNativeObject *)nativeObject {
    nativeObject.adLogoView = [[UIImageView alloc] init];
    nativeObject.logoView = [[UIImageView alloc] init];
}

- (void)layoutStyle3:(FelinkAgNativeObject *)nativeObject {
    UIView *adView = nativeObject.adView;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    UILabel *titleLabel = nil;
    if (nativeObject.title != nil) {

        titleLabel = [self createLabel];
        [adView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(adView).mas_offset(10);
            make.width.mas_equalTo(width);
            make.top.equalTo(adView).mas_offset(10);
        }];
        titleLabel.text = nativeObject.title;
    }


    UIImageView *imageView = nil;
    if (nativeObject.mainImageURLString != nil) {

        imageView = [[YYAnimatedImageView alloc] init];
        [adView addSubview:imageView];

        CGFloat imageView_height = 120;
        if (nativeObject.imageWidth > 0 && nativeObject.imageHeight > 0) {
            imageView_height = nativeObject.imageHeight * width / nativeObject.imageWidth;
        }
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(adView).mas_offset(10);
           // make.right.equalTo(adView).mas_offset(10);
            if (titleLabel == nil) {
                make.top.equalTo(adView).mas_offset(10);
            } else {
                make.top.equalTo(titleLabel.mas_bottom).mas_offset(5);
            }
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(imageView_height);
        }];
       // [imageView sd_setImageWithURL:[NSURL URLWithString:nativeObject.mainImageURLString]];
        [self downloadImageWithURL:[NSURL URLWithString:nativeObject.mainImageURLString] imageView:imageView];
    }


    if (nativeObject.logoView) {
        [adView addSubview:nativeObject.logoView];
        CGFloat width = 18;
        CGFloat height = 18;
        [nativeObject.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (imageView == nil) {
                make.left.equalTo(adView);
                make.bottom.equalTo(adView);
            } else {
                make.left.equalTo(imageView);
                make.bottom.equalTo(imageView);
            }

            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }

    if (nativeObject.adLogoView) {
        [adView addSubview:nativeObject.adLogoView];
        CGFloat width = 24;
        CGFloat height = 12;
        [nativeObject.adLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (imageView == nil) {
                make.right.equalTo(adView);
                make.bottom.equalTo(adView);
            } else {
                make.right.equalTo(imageView);
                make.bottom.equalTo(imageView);
            }

            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }

    UILabel *descLabel = nil;
    if (nativeObject.desc != nil) {
        descLabel = [self createLabel];
        [adView addSubview:descLabel];

        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(adView).mas_offset(10);
            make.width.mas_equalTo(width);
            if (imageView == nil) {
                if (titleLabel == nil) {
                    make.top.equalTo(adView.mas_bottom).mas_offset(10);
                } else {
                    make.top.equalTo(titleLabel.mas_bottom).mas_offset(10);
                }
            } else {
                make.top.equalTo(imageView.mas_bottom).mas_offset(10);
            }
            //make.bottom.equalTo(adView).mas_offset(-10);
        }];
        descLabel.text = nativeObject.desc;
    }
    
    UIView *b=[[UIView alloc] init];
     [adView addSubview:b];
    [b mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (descLabel!= nil) {
              make.top.equalTo(descLabel.mas_bottom);
        }else if (imageView!= nil) {
            make.top.equalTo(imageView.mas_bottom);
        }
         make.bottom.equalTo(adView).mas_offset(-10);
    }];
    CGSize size = [adView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    adView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, size.height);
}

//************************************ style 4  多图 *******************************/

- (void)initStyle4:(FelinkAgNativeObject *)nativeObject {
    nativeObject.adLogoView = [[UIImageView alloc] init];
}

- (void)layoutStyle4:(FelinkAgNativeObject *)nativeObject {
    UIView *adView = nativeObject.adView;
    
    UILabel *titleLabel = nil;
    if (nativeObject.title != nil) {
        
        titleLabel = [self createLabel];
        [adView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(adView).mas_offset(10);
            make.right.equalTo(adView).mas_offset(-10);
            make.top.equalTo(adView).mas_offset(10);
        }];
        titleLabel.text = nativeObject.title;
    }
    
    
    UIView *imageViews = nil;
    if (nativeObject.morePictures != nil) {
       
        imageViews = [[UIView alloc] init];
        [adView addSubview:imageViews];
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
        CGFloat imageView_height = 120;
        [imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(adView).mas_offset(10);
            make.right.equalTo(adView).mas_offset(-10);
            if (titleLabel == nil) {
                make.top.equalTo(adView).mas_offset(10);
            } else {
                make.top.equalTo(titleLabel.mas_bottom).mas_offset(5);
            }
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(imageView_height);
        }];
        
        if ([nativeObject.morePictures count] > 0) {
            UIImageView *imageView= [[UIImageView alloc] init];
            [imageViews addSubview:imageView];

            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageViews);
                make.top.equalTo(imageViews);
                make.bottom.equalTo(imageViews);
                make.width.equalTo(imageViews).multipliedBy(0.3);
            }];
            [self downloadImageWithURL:[NSURL URLWithString:[nativeObject.morePictures objectAtIndex:0]] imageView:imageView];
            
        }
        
         if ([nativeObject.morePictures count] > 1) {
             UIImageView *imageView= [[UIImageView alloc] init];
             [imageViews addSubview:imageView];
             
             [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.center.equalTo(imageViews);
                 make.top.equalTo(imageViews);
                 make.bottom.equalTo(imageViews);
                 make.width.equalTo(imageViews).multipliedBy(0.3);
             }];
             [self downloadImageWithURL:[NSURL URLWithString:[nativeObject.morePictures objectAtIndex:1]] imageView:imageView];
             
        }
        
        if ([nativeObject.morePictures count] > 2) {
            UIImageView *imageView= [[UIImageView alloc] init];
            [imageViews addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(imageViews);
                make.top.equalTo(imageViews);
                make.bottom.equalTo(imageViews);
                make.width.equalTo(imageViews).multipliedBy(0.3);
            }];
            [self downloadImageWithURL:[NSURL URLWithString:[nativeObject.morePictures objectAtIndex:2]] imageView:imageView];
            
        }
        
      
    }
    
    

    
    if (nativeObject.adLogoView != nil) {
        [adView addSubview:nativeObject.adLogoView];
        CGFloat width = 24;
        CGFloat height = 12;
        [nativeObject.adLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(adView);
            make.bottom.equalTo(adView);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
    }
    
    if (nativeObject.desc != nil) {
        UILabel *descLabel = [self createLabel];
        [adView addSubview:descLabel];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(adView).mas_offset(10);
            make.right.equalTo(adView).mas_offset(10);
            if (imageViews == nil) {
                if (titleLabel == nil) {
                    make.top.equalTo(adView.mas_top).mas_offset(10);
                } else {
                    make.top.equalTo(titleLabel.mas_bottom).mas_offset(10);
                }
            } else {
                make.top.equalTo(imageViews.mas_bottom).mas_offset(10);
            }
            make.bottom.equalTo(adView).mas_offset(-10);
        }];
        descLabel.text = nativeObject.desc;
    }
    CGSize size = [adView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    adView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, size.height);
}

//************************************ style all 推荐*******************************/

- (void)allInfo:(FelinkAgNativeObject *)nativeObject  {

    UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 15, 212, 20)];
    brandLabel.font = [UIFont fontWithName:brandLabel.font.familyName size:15];
    nativeObject.sourceLabel = brandLabel;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 200, 10)]; //(85, 60, 200, 10)
    titleLabel.font = [UIFont fontWithName:titleLabel.font.familyName size:12];
    nativeObject.titleLabel = titleLabel;


    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 40, 200, 10)];
    textLabel.font = [UIFont fontWithName:textLabel.font.familyName size:12];
    nativeObject.descLabel = textLabel;

    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 60, 60)];
    nativeObject.iconView = iconImageView;


    UIImageView *mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 300, 250)];
    nativeObject.imageView = mainImageView;
    
    UIImageView *baiduLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 310, 18, 18)];
    nativeObject.logoView = baiduLogoView;
    
    UIImageView *adLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(286, 318, 24, 12)];
    nativeObject.adLogoView = adLogoView;
}

@end

