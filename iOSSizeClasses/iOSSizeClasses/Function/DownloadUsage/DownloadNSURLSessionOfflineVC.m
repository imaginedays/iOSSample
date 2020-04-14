//
//  DownloadNSURLSessionOfflineVC.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2020/4/13.
//  Copyright © 2020 Robin Wong. All rights reserved.
//

#import "DownloadNSURLSessionOfflineVC.h"

@interface DownloadNSURLSessionOfflineVC ()<NSURLSessionDataDelegate>

/** NSURLSession断点下载（支持离线）需用到的属性 **********/
/** 文件的总长度 */
@property (nonatomic, assign) NSInteger fileLength;
/** 当前下载长度 */
@property (nonatomic, assign) NSInteger currentLength;
/** 文件句柄对象 */
@property (nonatomic, strong) NSFileHandle *fileHandle;


// session
@property (nonatomic, copy) NSURLSession *session;  //!< 属性名称
//// 下载任务
//@property (nonatomic, copy) NSURLSessionDownloadTask *downloadTask;  //!< 属性名称

/** 下载任务 */
@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;

@property (nonatomic, copy) NSData *resumeData;  //!< 属性名称

@end

@implementation DownloadNSURLSessionOfflineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)offlineResumeDownloadBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"master.zip"];
        
        NSInteger currentLength = [self fileLengthForPath:path];
        if (currentLength > 0) {
            self.currentLength = currentLength;
        }
        [self.downloadTask resume];
    } else {
        [self.downloadTask suspend];
        self.downloadTask = nil;
    }
}

- (NSInteger)fileLengthForPath:(NSString *)path {
    NSInteger fileLength = 0;
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDic) {
            fileLength = [fileDic fileSize];
        }
    }
    return fileLength;
}

#pragma mark NSURLSessionDataDelegate
/* The task has received a response and no further messages will be
 * received until the completion block is called. The disposition
 * allows you to cancel a request or to turn a data task into a
 * download task. This delegate message is optional - if you do not
 * implement it, you can get the response as a property of the task.
 *
 * This method will not be called for background upload tasks (which cannot be converted to download tasks).
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
                                 didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    self.fileLength = response.expectedContentLength + self.currentLength;
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@""];
    
    NSLog(@"File download to %@",path);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        [manager createFileAtPath:path contents:nil attributes:nil];
    }
    
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    
    completionHandler(NSURLSessionResponseAllow);
    
}

/* Sent when data is available for the delegate to consume.  It is
 * assumed that the delegate will retain and not copy the data.  As
 * the data may be discontiguous, you should use
 * [NSData enumerateByteRangesUsingBlock:] to access it.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    [self.fileHandle seekToEndOfFile];
    
    [self.fileHandle writeData:data];
    
    self.currentLength += data.length;
    
    NSLog(@"%ld",self.currentLength);
    
//    __weak typeof(self) weakSelf = self;
//    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
//    [mainQueue addOperationWithBlock:^{
//        <#code#>
//    }];
    
    NSString *progress = [NSString stringWithFormat:@"当前下载进度:%.2f%%",100.0 * self.currentLength / self.fileLength];
    NSLog(@"%@",progress);
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    [self.fileHandle  closeFile];
    self.fileHandle = nil;
    
    self.currentLength = 0;
    self.fileLength = 0;
}


///  恢复下载
/// @param sender <#sender description#>
//- (void)resumeDownloadBtnClick:(UIButton *)sender {
//    sender.selected = !sender.selected;
//
//    if (self.downloadTask == nil) {
//        if (self.resumeData) {
//            self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
//            [self.downloadTask resume];
//            self.resumeData = nil;
//        } else {
//            NSURL *url = [NSURL URLWithString:@""];
//            self.downloadTask = [self.session downloadTaskWithURL:url];
//            [self.downloadTask resume];
//        }
//    } else {
//        [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
//            self.resumeData = resumeData;
//            self.downloadTask = nil;
//        }];
//    }
//}

- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (NSURLSessionDataTask *)downloadTask {
    if (!_downloadTask) {
        NSURL *url = [NSURL URLWithString:@""];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",self.currentLength];
        [request addValue:range forHTTPHeaderField:@"Range"];
        
        _downloadTask = [self.session dataTaskWithRequest:request];
    }
    return _downloadTask;
}

@end
