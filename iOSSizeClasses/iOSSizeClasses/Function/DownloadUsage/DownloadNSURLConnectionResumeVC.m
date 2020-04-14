//
//  DownloadNSURLConnectionResumeVC.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2020/3/31.
//  Copyright © 2020 Robin Wong. All rights reserved.
//

#import "DownloadNSURLConnectionResumeVC.h"

@interface DownloadNSURLConnectionResumeVC ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, copy) NSString *progress;  //!< 进度
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (nonatomic, assign) NSInteger  fileLength;  //!< 文件总长度
@property (nonatomic, assign) NSInteger  currentLength;  //!< 当前下载长度
@property (nonatomic, strong) NSFileHandle *fileHandle;  //!< 文件句柄对象
@property (nonatomic, strong) NSURLConnection *connection;  //!< 属性名称
@property (nonatomic, copy) NSString *urlStr;  //!< 属性名称
@property (nonatomic, copy) NSString *subNameStr;
- (IBAction)resumeDownloadBtnPress:(UIButton *)sender;

@end

@implementation DownloadNSURLConnectionResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文件下载断点续传-NSURLConnection";
    _urlStr = @"https://github.com/ArchLL/HGPersonalCenterExtend/archive/master.zip";
    _subNameStr = @"master.zip";

}

- (IBAction)resumeDownloadBtnPress:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        // 沙盒文件路径
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:_subNameStr];
        
        // 判断已下载文件的大小
        NSInteger currentLength = [self fileLengthForPath:path];
        if (currentLength > 0) {
            self.currentLength = currentLength;
        }
        
        // 创建下载URL
        NSURL *url = [NSURL URLWithString:_urlStr];
        
        // 创建request请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // 设置http 请求头中的Range
        NSString *range = [NSString stringWithFormat:@"bytes=%ld-",self.currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        // 下载
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
        
    } else {
        [self.connection cancel];
        self.connection = nil;
    }
}

// 获取已下载文件的大小
- (NSInteger)fileLengthForPath:(NSString *)path {
    NSInteger fileLength = 0;
    // default is not thread safe
    NSFileManager *manager = [[NSFileManager alloc]init];
    if ([manager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [manager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileLength = [fileDict fileSize];
        }
    }
    return fileLength;
}

#pragma mark NSURLConnectionDelegate METHOD

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.fileLength = response.expectedContentLength + self.currentLength;
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:_subNameStr];
    
    NSLog(@"File downloaded to: %@",path);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:path]) {
        [manager createFileAtPath:path contents:nil attributes:nil];
    }
    
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.fileHandle seekToEndOfFile];
    
    [self.fileHandle writeData:data];
    
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.fileHandle closeFile];
    self.fileHandle = nil;
    
    self.currentLength = 0;
    self.fileLength = 0;
}

@end
