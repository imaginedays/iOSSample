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
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 200, 300)];
    baseView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:baseView];
    
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 5; i ++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor greenColor];
        [baseView addSubview:view];
        [array addObject:view]; //保存添加的控件
    }
    
    //水平方向控件间隔固定等间隔
    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:30 leadSpacing:10 tailSpacing:10];
    [array makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.width.equalTo(@80);
    }];
    
//    //水平方向宽度固定等间隔
//    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:70 leadSpacing:10 tailSpacing:10];
//    [array makeConstraints:^(MASConstraintMaker *make) { //数组额你不必须都是view
//        make.top.equalTo(@50);
//        make.height.equalTo(@70);
//    }];

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
