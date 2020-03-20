//
//  DownloadNSURLConnectionBigFileVC.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2020/3/20.
//  Copyright © 2020 Robin Wong. All rights reserved.
//

#import "DownloadNSURLConnectionBigFileVC.h"

@interface DownloadNSURLConnectionBigFileVC ()<NSURLConnectionDataDelegate>
@property (nonatomic, strong) UIButton *downloadButton;

@property (nonatomic, assign) NSInteger  fileLength;  //!< 文件总长度
@property (nonatomic, assign) NSInteger  currentLength;  //!< 当前下载长度
@property (nonatomic, strong) NSFileHandle *fileHandle;  //!< 文件句柄对象
@property (nonatomic, copy) NSString *progress;  //!< 进度
@property (nonatomic, strong) UILabel *progressLabel;    // !< progressLabel
@property (nonatomic, strong) UIProgressView * progressView;

@end

@implementation DownloadNSURLConnectionBigFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.progressLabel];
    [self.view addSubview:self.downloadButton];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(5);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.progressView.mas_bottom).offset(30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.progressLabel.mas_bottom).offset(100);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}


- (void)jbf_downloadButtonClick {
    
    // http://okzy.xzokzyzy.com/20200307/12973_ad06a1e6/苏莱曼山.mp4
  // http://m7.music.126.net/20200320172234/79bbb7371f0d2893d634bd4e8d1c886e/ymusic/560f/075e/535f/ae15cebedc04c39f79f6d5ac577f2977.mp3
    
    // https://github.com/ArchLL/HGPersonalCenterExtend/archive/master.zip
    NSString *urlStr = @"https://github.com/ArchLL/HGPersonalCenterExtend/archive/master.zip";
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

/**
 * 接收到响应的时候就会调用
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.fileLength = response.expectedContentLength;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
    
    NSLog(@"file download to: %@",path);
    
    // 创建一个空的文件到沙盒中
    [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    
    // 创建文件句柄
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
}

/**
 * 接收到具体数据的时候会调用，会频繁调用
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // 将接受到的数据写入到文件最后
    [self.fileHandle seekToEndOfFile];
    [self.fileHandle writeData:data];
    
    // 拼接文件长度
    self.currentLength += data.length;
    
    if (self.fileLength >  0) {
        NSDecimalNumber *a = [[NSDecimalNumber alloc]initWithInteger:self.currentLength];
        NSDecimalNumber *b = [[NSDecimalNumber alloc]initWithInteger:self.fileLength];
        NSDecimalNumber *c = [a decimalNumberByDividingBy:b];
        NSLog(@"%.2f%%",c.floatValue * 100);
        self.progress = [NSString stringWithFormat:@"%.2f%%",c.floatValue * 100];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressLabel.text = self.progress;
            self.progressView.progress = c.floatValue;
        });
        
    }
}

/**
 * 下载完文件之后调用
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.fileHandle closeFile];
    self.fileHandle = nil;
    
    self.currentLength = 0;
    self.fileLength = 0;
}

/**
 *  请求失败时调用（请求超时、网络异常）
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError = %@",error.localizedDescription);
}

- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _downloadButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_downloadButton setTitleColor:HexRGB(0x000000) forState:UIControlStateNormal];
        _downloadButton.titleLabel.text = @"下载";
        _downloadButton.backgroundColor = HexRGB(0xE53935);
        [_downloadButton addTarget:self action:@selector(jbf_downloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.font = [UIFont systemFontOfSize:14.0f];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.textColor = HexRGB(0x333333);
    }
    return _progressLabel;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView  = [[UIProgressView alloc]initWithFrame:CGRectZero];
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
        _progressView.progress = 0;
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor lightGrayColor];
    }
    return _progressView;
}

@end
