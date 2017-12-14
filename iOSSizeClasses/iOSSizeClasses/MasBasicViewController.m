//
//  MasBasicViewController.m
//  iOSSizeClasses
//
//  Created by imaginedays on 14/12/2017.
//  Copyright © 2017 黄可. All rights reserved.
//

#import "MasBasicViewController.h"

@interface MasBasicViewController ()

@end

@implementation MasBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *superView = self.view;
    UIView *view1 = UIView.new;
    view1.backgroundColor = [UIColor greenColor];
    [superView addSubview:view1];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView).with.insets(padding);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
