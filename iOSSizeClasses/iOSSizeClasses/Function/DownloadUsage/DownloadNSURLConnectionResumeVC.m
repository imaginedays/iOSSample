//
//  DownloadNSURLConnectionResumeVC.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2020/3/31.
//  Copyright © 2020 Robin Wong. All rights reserved.
//

#import "DownloadNSURLConnectionResumeVC.h"

@interface DownloadNSURLConnectionResumeVC ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
- (IBAction)resumeDownloadBtnPress:(UIButton *)sender;

@end

@implementation DownloadNSURLConnectionResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resumeDownloadBtnPress:(UIButton *)sender {
}
@end
