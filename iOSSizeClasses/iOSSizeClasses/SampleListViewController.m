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


@interface SampleListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.controllers = @[
                         [[ViewController alloc] initWithTitle:@"SizeClasses" andIdentifierStr:@"ViewController"],
                         [[MasUseListViewController alloc] initWithTitle:@"masonry使用列表"]
                         ];
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
    RWBaseViewController *viewController = self.controllers[indexPath.row];
    if (viewController.identifierStr && viewController.identifierStr.length > 0) {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        viewController = [mainStory instantiateViewControllerWithIdentifier:viewController.identifierStr];
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
