//
//  DownloadNSDataViewController.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2020/3/20.
//  Copyright © 2020 Robin Wong. All rights reserved.
//

#import "DownloadNSDataViewController.h"

@interface DownloadNSDataViewController ()
@property (nonatomic, strong) UIImageView *horseImageView;
@property (nonatomic, strong) UIButton *downloadButton;    // !< downloadButton
@end

@implementation DownloadNSDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.horseImageView];
    [self.view addSubview:self.downloadButton];
    
    [self.horseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view).offset(-120);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(100);
    }];
    
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}

- (void)jbf_downloadButtonClick {
    NSString *urlStr = @"https://timgsa.baidu.com/timg?image&quality=100&size=b9999_10000&sec=1585294299&di=dfaef358c98e52d58fdff9137e73816a&imgtype=jpg&er=1&src=http%3A%2F%2Fdpic.tiankong.com%2Frh%2F01%2FQJ6238454069.jpg";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (data) {
           _horseImageView.image = [UIImage imageWithData:data];
       }
}

- (UIImageView *)horseImageView {
    if (!_horseImageView) {
        _horseImageView = [[UIImageView alloc] init];
        _horseImageView.image = [UIImage imageNamed:@"horse"];
    }
    return _horseImageView;
}


- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _downloadButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _downloadButton.titleLabel.textColor = HexRGB(0xE3535);
        _downloadButton.backgroundColor = HexRGB(0x666666);
        _downloadButton.titleLabel.text = @"下载";
        [_downloadButton addTarget:self action:@selector(jbf_downloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
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
