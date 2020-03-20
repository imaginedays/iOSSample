//
//  DownloadViewController.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2020/3/20.
//  Copyright © 2020 Robin Wong. All rights reserved.
//

#import "DownloadViewController.h"

#import "DownloadNSDataViewController.h"
#import "DownloadNSURLConnectionVC.h"

@interface DownloadViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"文件下载";
    
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
//
//    NSDictionary *title1 = @{@"title":@"文件下载断点续传-NSData"};
//    [arr addObject:title1];
//
//    NSDictionary *title2 = @{@"title":@"文件下载断点续传-NSURLConnection"};
//    [arr addObject:title2];
//
//    NSDictionary *title3 = @{@"title":@"文件下载断点续传-NSURLSession"};
//    [arr addObject:title3];
//
//    NSDictionary *title4 = @{@"title":@"文件下载断点续传-AFNetworking"};
//    [arr addObject:title4];
    
     self.controllers = @[
                            [[DownloadNSDataViewController alloc] initWithTitle:@"文件下载断点续传-NSData"],
                            [[DownloadNSURLConnectionVC alloc]initWithTitle:@"文件下载断点续传-NSURLConnection"]
                            ];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"CellIdentifier";
    UIViewController *viewController = self.controllers[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    cell.textLabel.text = viewController.title;
    return cell;
}

#pragma mark - UITableViewDelegate Method
// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}


// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = self.controllers[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Accessor
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] init];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _tableView.showsHorizontalScrollIndicator = NO;
//        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//
//        _tableView.estimatedRowHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
//
//        if (@available(iOS 11.0, *)) {
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
//
//        // 注册cell
//         [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
//    }
//    return _tableView;
//}

@end
