//
//  AFNUsageViewController.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/8/14.
//  Copyright © 2019 Robin Wong. All rights reserved.
//

#import "AFNUsageViewController.h"

@interface AFNUsageViewController ()

@end

@implementation AFNUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    NSString *urlString = @"https://api.apiopen.top/getWangYiNews";
    NSDictionary *paramDict = @{
                                @"page":@"1",
                                @"count":@"10"
                                };
    [manager POST:urlString parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
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
