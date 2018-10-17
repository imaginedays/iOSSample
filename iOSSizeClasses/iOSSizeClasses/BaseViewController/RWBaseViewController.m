//
//  RWBaseViewController.m
//  iOSSizeClasses
//
//  Created by imaginedays on 14/12/2017.
//  Copyright © 2017 黄可. All rights reserved.
//

#import "RWBaseViewController.h"

@interface RWBaseViewController ()

@end

@implementation RWBaseViewController

- (instancetype)initWithTitle:(NSString *)title andIdentifierStr:(NSString *) identifierStr {
    if (self = [super init]) {
        self.title = title;
        self.identifierStr = identifierStr;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        self.title = title;
        self.identifierStr = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
