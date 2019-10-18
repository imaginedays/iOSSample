//
//  UIKitUsageListViewController.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/3/21.
//  Copyright © 2019 黄可. All rights reserved.
//

#import "UIKitUsageListViewController.h"

#import "RWUITextFieldVC.h"
#import "RWUIScrollerViewController.h"
#import "RWXibViewController.h"

@interface UIKitUsageListViewController ()

@end

@implementation UIKitUsageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"UIKit使用";
    self.controllers = @[[[RWUITextFieldVC alloc]initWithTitle:@"UITextField"],
                         [[RWUIScrollerViewController alloc]initWithTitle:@"UIScrollerView"],
                         [[RWXibViewController alloc]initWithTitle:@"XIB使用"]
                         ];
    [super viewDidLoad];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
