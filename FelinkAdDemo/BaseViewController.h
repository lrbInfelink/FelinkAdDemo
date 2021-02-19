//
//  BaseViewController.h
//  felinkDemo
//
//  Created by 刘瑞彬 on 2019/3/6.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property(nonatomic,strong)UITextView *message;
@property(nonatomic,copy)NSString *aPid;
@property(nonatomic,assign)CGFloat centerX;
-(UIButton *)createWithTitle:(NSString *)title targat:(SEL)selector view:(UIView *)view;
-(UIButton *)createWithTitle:(NSString *)title targat:(SEL)selector;
-(void)createMessage:(CGFloat)height;
-(void)createMessage:(CGFloat)height y:(CGFloat)y view:(UIView *)view;
-(void)createMessage:(CGFloat)height y:(CGFloat)y;
-(void)appendMessage:(NSString *)text;
-(UISwitch *)createSwitchWithFrame:(CGRect)frame title:(NSString *)title targat:(SEL)selector view:(UIView *)view;
-(UISwitch *)createSwitchWithFrame:(CGRect)frame title:(NSString *)title targat:(SEL)selector;
-(UISegmentedControl *)createSegmentControlWithFrame:(CGRect)frame titles:(NSArray *)titles targat:(SEL)selector;
-(UITextField *)createTextFieldWithFrame:(CGRect)frame  title:(NSString *)title value:(NSString *)value view:(UIView *)view;
-(UITextField *)createTextFieldWithFrame:(CGRect)frame  title:(NSString *)title value:(NSString *)value;
@end


