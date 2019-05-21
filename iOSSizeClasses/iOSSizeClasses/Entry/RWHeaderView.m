//
//  RWHeaderView.m
//  iOSSizeClasses
//
//  Created by imaginedays on 2018/9/18.
//  Copyright © 2018年 黄可. All rights reserved.
//

#import "RWHeaderView.h"

@interface RWHeaderView ()

@property (nonatomic, strong) UIImageView *topImageView;    // !< 名称 topImageView 描述 topImageView
@end
@implementation RWHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self rw_setupViews];
    }
    return self;
}

- (void)rw_setupViews {
    [self addSubview:self.topImageView];
    [self rw_makeConstraints];
    [self addDownloadSample];
}

- (void)rw_makeConstraints {
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
#pragma mark Accorser
- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = [UIImage imageNamed:@"fengye"];
    }
    return _topImageView;
}

- (void)addDownloadSample {
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://static.cnbetacdn.com/article/2019/0521/b09f82ee2486663.jpg"]];
    
    //2.创建下载任务
    /*
     第一个参数:请求对象
     第二个参数:progress 进度回调
     downloadProgress.completedUnitCount:已经完成的大小
     downloadProgress.totalUnitCount:文件的总大小
     第三个参数:destination 自动完成文件剪切操作
     返回值:该文件应该被剪切到哪里
     targetPath:临时路径 tmp NSURL
     response:响应头
     第四个参数:completionHandler 下载完成回调
     filePath:真实路径 == 第三个参数的返回值
     error:错误信息
     */
    NSURLSessionDownloadTask *downlaodTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //计算文件的下载进度
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //文件的全路径
        NSString *fullpath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        
        NSURL *fileUrl = [NSURL fileURLWithPath:fullpath];
        
        NSLog(@"%@\n%@",targetPath,fullpath);
        return fileUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"%@",filePath);
        if (!error) {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            _topImageView.image = [UIImage imageWithData:data];
        }
    }];
    
    //3.执行Task
    [downlaodTask resume];
}

@end
