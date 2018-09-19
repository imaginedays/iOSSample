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
                         [[MasUseListViewController alloc] initWithTitle:@"masonry使用列表"]
                         ];
    [self dispatchSignal];
}


- (void)dispatchSignal {
    //crate的value表示，最多几个资源可访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    
    //任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    
    //任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
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
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (RWHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[RWHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _headerView.backgroundColor = UIColor.grayColor;
    }
    return _headerView;
}

- (RWFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[RWFooterView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        _footerView.backgroundColor = UIColor.orangeColor;
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
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
