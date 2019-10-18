//
//  FlutterSampleViewController.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/8/14.
//  Copyright © 2019 Robin Wong. All rights reserved.
//

#import "FlutterSampleViewController.h"
#import <Flutter/Flutter.h>

@interface FlutterSampleViewController ()
@property (nonatomic, strong) UIButton *goFlutterVCButton;    // !< goFlutterVCButton
@end

@implementation FlutterSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.goFlutterVCButton];
    [self.goFlutterVCButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.mas_equalTo(50.0f);
        make.height.mas_equalTo(80.0f);
    }];
}


- (UIButton *)goFlutterVCButton {
    if (!_goFlutterVCButton) {
        _goFlutterVCButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goFlutterVCButton setImage:[UIImage imageNamed:@"2-read-mode"] forState:UIControlStateNormal];
        [_goFlutterVCButton addTarget:self action:@selector(goFlutterViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goFlutterVCButton;
}

- (void)goFlutterViewController {
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] init];
    [flutterViewController setInitialRoute:@"route1"];
    [self presentViewController:flutterViewController animated:false completion:nil];
    
//    [FlutterRouter.sharedRouter openPage:@"first" params:@{} animated:YES completion:^(BOOL f){
//
//        [FlutterBoostPlugin.sharedInstance onResultForKey:@"result_id_100" resultData:@{} params:@{}];
//
//    }];
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
