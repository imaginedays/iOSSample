//
//  MasBasicViewController.m
//  iOSSizeClasses
//
//  Created by imaginedays on 14/12/2017.
//  Copyright © 2017 黄可. All rights reserved.
//

#import "MasBasicViewController.h"
#import <JBFStaticSample/JBFStaticSample.h>
#import <JBFStaticSample/RWRibbonView.h>


@interface MasBasicViewController ()
@property (nonatomic, copy) UIView *baseView;  //!< 属性名称
@property (nonatomic, copy) RWRibbonView  *ribbonView;
@end

@implementation MasBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    NSString *rate = @"0.001";
    NSLog(@"%.2f%%",[rate doubleValue] * 100);
    
    // Creates a sample ribbon view
    _ribbonView = [[RWRibbonView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_ribbonView];
    
    [self.ribbonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
    }];
    // Need to check that it actually works :)
//    UIView *sampleView = [[UIView alloc] initWithFrame:_ribbonView.bounds];
//    sampleView.backgroundColor = [UIColor lightGrayColor];
//    [_ribbonView addSubview:sampleView];
    
    
//    _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 200, 300)];
//    _baseView.backgroundColor = [UIColor brownColor];
//    [self.view addSubview:_baseView];
//
//    [self test_];
    
//    JBFStaticSample *sample = [JBFStaticSample new];
//    [sample urlType:@"cccc" withCompletion:^(NSString *result) {
//        NSLog(@"result = %@",result);
//    }];
//
//    NSMutableArray *array = [NSMutableArray new];
//    for (int i = 0; i < 5; i ++) {
//        UIView *view = [UIView new];
//        view.backgroundColor = [UIColor greenColor];
//        [baseView addSubview:view];
//        [array addObject:view]; //保存添加的控件
//    }
//
//    //水平方向控件间隔固定等间隔
//    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:30 leadSpacing:10 tailSpacing:10];
//    [array makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(30);
//        make.width.equalTo(@80);
//    }];
    
//    //水平方向宽度固定等间隔
//    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:70 leadSpacing:10 tailSpacing:10];
//    [array makeConstraints:^(MASConstraintMaker *make) { //数组额你不必须都是view
//        make.top.equalTo(@50);
//        make.height.equalTo(@70);
//    }];

}

- (void)test_ {
    NSMutableArray *array = [NSMutableArray new];
       for (int i = 0; i < 4; i ++) {
           UIView *view = [UIView new];
           view.backgroundColor = [UIColor greenColor];
           [_baseView addSubview:view];
           [array addObject:view]; //保存添加的控件
           
           UILabel *left = [UILabel new];
           left.text = [NSString stringWithFormat:@"%d",i];
           [view addSubview:left];
           [left mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.equalTo(view);
               make.centerY.equalTo(view);
           }];
           
           UILabel *right = [UILabel new];
           right.text = [NSString stringWithFormat:@"%d",i + 1];
           [view addSubview:right];
           [right mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.equalTo(view);
               make.centerY.equalTo(view);
           }];
           
       }
       
       //水平方向控件间隔固定等间隔
       [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:30 leadSpacing:5 tailSpacing:5];
       [array mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(_baseView).offset(10);
           make.right.equalTo(_baseView).offset(-10);
//           make.height.equalTo(@40);
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
