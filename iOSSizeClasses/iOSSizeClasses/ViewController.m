//
//  ViewController.m
//  iOSSizeClasses
//
//  Created by 黄可 on 2016/12/5.
//  Copyright © 2016年 黄可. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)talkBtnAction:(UIButton *)sender;
- (IBAction)rotateBtnAction:(UIButton *)sender;
@property (nonatomic, assign) BOOL isPortrait;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    self.isPortrait = YES;
}

// 键盘改变高度通知处理
- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
    
    
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 修改下边距约束
    _bottomConstraint.constant = keyboardHeight;
    
    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}

// 键盘隐藏通知处理
- (void)keyboardWillHideNotification:(NSNotification *)notification {
    
    // 获得键盘动画时长
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 修改为以前的约束（距下边距20）
    _bottomConstraint.constant = -63;
    
    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc {
    
    // 移除键盘通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)talkBtnAction:(UIButton *)sender {
    
    [_textField becomeFirstResponder];
    
}

- (IBAction)rotateBtnAction:(UIButton *)sender {
    
    if (self.isPortrait) {
        
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
        self.isPortrait = NO;
        
    }else
    {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        self.isPortrait = YES;
    }
    
    [UIViewController attemptRotationToDeviceOrientation];

}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //当用户按下ruturn，把焦点从textField移开那么键盘就会消失了
    [textField resignFirstResponder];
    return YES;
}

@end
