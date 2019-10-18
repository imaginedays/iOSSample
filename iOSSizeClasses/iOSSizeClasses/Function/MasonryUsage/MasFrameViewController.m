//
//  MasFrameViewController.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/8/8.
//  Copyright © 2019 Robin Wong. All rights reserved.
//

#import "MasFrameViewController.h"

@interface MasFrameViewController ()
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong) UIView *childView;
@end

@implementation MasFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.parentView];
    [self.parentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(120,120));
        make.left.mas_equalTo(self.view).offset(100);
    }];
    
    [self.parentView addSubview:self.childView];
    [self.childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20,20));
        make.top.left.mas_equalTo(50);
    }];
    
    [self.view layoutIfNeeded];
//    NSLog(@"%@",self.childView);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews = %@",self.childView);
}

- (UIView *)parentView {
    if (!_parentView) {
        _parentView = [[UIView alloc] init];
        _parentView.backgroundColor = UIColor.grayColor;
    }
    return _parentView;
}

- (UIView *)childView {
    if (!_childView) {
        _childView = [[UIView alloc] init];
        _childView.backgroundColor = UIColor.greenColor;
    }
    return _childView;
}

@end
