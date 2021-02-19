//
//  BaseViewController.m
//  felinkDemo
//
//  Created by 刘瑞彬 on 2019/3/6.
//  Copyright © 2019年 刘瑞彬. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITextFieldDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.centerX = self.view.center.x;

}

-(void)createMessage:(CGFloat)height{
    
    CGRect frame = self.view.frame;
    frame.origin.y = frame.size.height - height;
    frame.size.height = height;
    _message =[[UITextView alloc] initWithFrame:frame];
    _message.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:_message];
}

-(void)createMessage:(CGFloat)height y:(CGFloat)y{
    [self createMessage:height y:y view:self.view];
}

-(void)createMessage:(CGFloat)height y:(CGFloat)y view:(UIView *)view{
    
    CGRect frame = self.view.frame;
    frame.origin.y = y;
    frame.size.height = height;
    _message =[[UITextView alloc] initWithFrame:frame];
    _message.backgroundColor =[UIColor lightGrayColor];
    _message.editable = NO;
    [view addSubview:_message];
}

-(void)appendMessage:(NSString *)text{
    if (_message != nil) {
        if (_message.text == nil || _message.text.length == 0) {
            _message.text = text;
        }else{
            _message.text = [NSString stringWithFormat:@"%@ ; %@",_message.text,text];
        }
        
    }
}
-(UIButton *)createWithTitle:(NSString *)title targat:(SEL)selector view:(UIView *)view{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor =[UIColor grayColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return button;
}
-(UIButton *)createWithTitle:(NSString *)title targat:(SEL)selector{
    return [self createWithTitle:title targat:selector view:self.view];
}

-(UITextField *)createTextFieldWithFrame:(CGRect)frame  title:(NSString *)title value:(NSString *)value view:(UIView *)view{
    frame.size.width = frame.size.width/2;
    
    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textAlignment = NSTextAlignmentRight;
    [view addSubview:label];
    
    frame.origin.x =  frame.origin.x + frame.size.width;
    UITextField *textField =[[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.returnKeyType = UIReturnKeyDefault;
    textField.delegate = self;
    textField.text = value;
    [view addSubview:textField];
    return textField;
}
-(UITextField *)createTextFieldWithFrame:(CGRect)frame  title:(NSString *)title value:(NSString *)value{
    return [self createTextFieldWithFrame:frame title:title value:value view:self.view];
}
-(UISwitch *)createSwitchWithFrame:(CGRect)frame title:(NSString *)title targat:(SEL)selector{
   return [self createSwitchWithFrame:frame title:title targat:selector view:self.view];
}

-(UISwitch *)createSwitchWithFrame:(CGRect)frame title:(NSString *)title targat:(SEL)selector view:(UIView *)view{
    UIView *panel = [[UIView alloc] initWithFrame:frame];
    UISwitch *uiswitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 150, frame.size.height)];
    [panel addSubview:uiswitch];
    [uiswitch addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, frame.size.width - 60, frame.size.height)];
    [panel addSubview:label];
    label.text = title;
    [view addSubview:panel];
    return uiswitch;
}

-(UISegmentedControl *)createSegmentControlWithFrame:(CGRect)frame titles:(NSArray *)titles targat:(SEL)selector{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:titles];
    segmentControl.frame = frame;
    [segmentControl addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
    return segmentControl;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//按下Done按钮的调用方法，我们让键盘消失

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}
//当textField编辑结束时调用的方法

-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.aPid = textField.text;
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:^(){
        
    }];
}

@end
