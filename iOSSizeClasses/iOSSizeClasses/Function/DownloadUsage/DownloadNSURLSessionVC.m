//
//  DownloadNSURLSessionVC.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2020/4/13.
//  Copyright © 2020 Robin Wong. All rights reserved.
//

#import "DownloadNSURLSessionVC.h"

@interface DownloadNSURLSessionVC ()<NSURLSessionDownloadDelegate>

@end

@implementation DownloadNSURLSessionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rw_nsurlsession_Delegate];
    
}

- (void)rw_nsurlsession_simple {
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=100&size=b9999_10000&sec=1585294299&di=dfaef358c98e52d58fdff9137e73816a&imgtype=jpg&er=1&src=http%3A%2F%2Fdpic.tiankong.com%2Frh%2F01%2FQJ6238454069.jpg"];
    
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
     NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        
        NSString *newFilePath = [documentsPath stringByAppendingPathComponent:response.suggestedFilename];
        
        [[NSFileManager defaultManager]moveItemAtPath:location.path toPath:newFilePath error:nil];
         
     }];
     
     [downloadTask resume];
}

- (void)rw_nsurlsession_Delegate {
    // https://timgsa.baidu.com/timg?image&quality=100&size=b9999_10000&sec=1585294299&di=dfaef358c98e52d58fdff9137e73816a&imgtype=jpg&er=1&src=http%3A%2F%2Fdpic.tiankong.com%2Frh%2F01%2FQJ6238454069.jpg
    // https://github.com/ArchLL/HGPersonalCenterExtend/archive/master.zip
    NSString *urlStr = @"https://timgsa.baidu.com/timg?image&quality=100&size=b9999_10000&sec=1585294299&di=dfaef358c98e52d58fdff9137e73816a&imgtype=jpg&er=1&src=http%3A%2F%2Fdpic.tiankong.com%2Frh%2F01%2FQJ6238454069.jpg";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    [downloadTask resume];
}

#pragma mark NSURLSessionDownloadTaskDelegate

/* Sent when a download task that has completed a download.  The delegate should
 * copy or move the file at the given location to a new location as it will be
 * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
 * still be called.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSString *docmentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *newFilePath = [docmentsPath stringByAppendingPathComponent:@"hahah.jpg"];
    
    NSLog(@"File downloaded to: %@",newFilePath);
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:newFilePath error:nil];
}
/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                           didWriteData:(int64_t)bytesWritten
                                      totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    NSString *progressStr = [NSString stringWithFormat:@"%.2f%%",100.0 * totalBytesWritten / totalBytesExpectedToWrite];
    NSLog(@"progress = %@",progressStr);
   
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                      didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
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
