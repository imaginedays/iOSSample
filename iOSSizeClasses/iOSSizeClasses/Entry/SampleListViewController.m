//
//  SampleListViewController.m
//  iOSSizeClasses
//
//  Created by imaginedays on 14/12/2017.
//  Copyright © 2017 黄可. All rights reserved.
//

#import "SampleListViewController.h"
#import "ViewController.h"
#import "MasUseListViewController.h"
#import "UIKitUsageListViewController.h"
#import "FlutterSampleViewController.h"
#import "AFNUsageViewController.h"
#import "RWRACObjCViewController.h"
#import "DownloadViewController.h"


#import "RWHeaderView.h"
#import "RWFooterView.h"
#import "RWFloatView.h"
#import <MJRefresh/MJRefreshHeader.h>

#define kFloatViewHeight 200
#define kNavigationHeight 64

@interface SampleListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RWHeaderView *headerView;
@property (nonatomic, strong) RWFooterView *footerView;
@property (nonatomic, strong) RWFloatView *floatView;

@end

@implementation SampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
    [self setupTableView];
//    [self setupFloatView];
    self.controllers = @[
                         [[ViewController alloc] initWithTitle:@"SizeClasses" andIdentifierStr:@"ViewController"],
                         [[MasUseListViewController alloc] initWithTitle:@"masonry使用列表"],
                         [[UIKitUsageListViewController alloc] initWithTitle:@"UIKit使用列表"],
                         [[FlutterSampleViewController alloc]initWithTitle:@"Flutter"],
                         [[AFNUsageViewController alloc]initWithTitle:@"AFNetworking"],
                         [[RWRACObjCViewController alloc]initWithTitle:@"RACObjC Usage"],
                         [[DownloadViewController alloc]initWithTitle:@"Download"],
                         ];
    
//    [self test];
        [self testBlock];
}

- (void)setupFloatView {
    self.floatView = [[RWFloatView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kFloatViewHeight)];
    [self.floatView registerTableView:self.tableView];
    self.floatView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.floatView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kNavigationHeight, self.view.bounds.size.width, self.view.bounds.size.height - kNavigationHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (RWHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[RWHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    }
    return _headerView;
}

- (RWFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[RWFooterView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    }
    return _footerView;
}

#pragma mark - UITableViewDataSource

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controllers.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RWBaseViewController *viewController = self.controllers[indexPath.row];
    if (viewController.identifierStr && viewController.identifierStr.length > 0) {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        viewController = [mainStory instantiateViewControllerWithIdentifier:viewController.identifierStr];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }

    NSString *urlStr = [NSString stringWithFormat:@"RoutesOne://push/%@",NSStringFromClass(viewController.class)];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
}

- (void)test {
    NSArray *array = @[@1, @2, @3, @4, @5];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        dispatch_apply(array.count, queue, ^(size_t index) {
            NSLog(@"%zu: %@", index, array[index]);
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"done");
        });
    });
}

- (void)testBlock {
    __block int i = 1024;//此时i在栈上
    int j = 1;//此时j在栈上
    void (^blk)(void);
    blk = ^{printf("%d, %d\n", i, j); };//此时，blk已经初始化，它会拷贝没有__block标记的常规变量自己所持有的一块内存区，这块内存区现在位于栈上，而对于具有__block标记的变量，其地址会被拷贝置前述的内存区中
    blk();//1024, 1
//    void(^blkInHeap)(void) = Block_copy(blk);//复制block后，block所持有的内存区会被拷贝至堆上，此时，我们可以说，这个block现在位于堆上
//    blkInHeap();//1024,1
    i++;
    j++;
    blk();//1025,1
//    blkInHeap();//1025,1
}

#pragma mark Accorsor


@end
