//
//  MasUseListViewController.m
//  iOSSizeClasses
//
//  Created by imaginedays on 14/12/2017.
//  Copyright © 2017 黄可. All rights reserved.
//

#import "MasUseListViewController.h"
#import "MasBasicViewController.h"
#import "RWApiManager.h"
#import "AppUtils.h"

@interface MasUseListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MasUseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"masonry基本使用";
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.controllers = @[
                         [[MasBasicViewController alloc] initWithTitle:@"masonry基本使用"]
                         ];
    
    [[RWApiManager shareManager] loginWithUserName:@"a" password:@"b" block:^(RWRequest type, NSDictionary *param) {
        switch (type) {
            case RWRequestSuccess:
                NSLog(@"%@",param[@"msg"]);
                break;
                
            default:
                break;
        }
    }];
    
    //
    [AppUtils formatterNum:@"123456789"];
    
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
    UIViewController *viewController = self.controllers[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    CGFloat velocity = [pan velocityInView:scrollView].y;
    if (velocity < -5) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else if(velocity > 5){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetToShow = 200.0;//滑动多少就完全显示
//    CGFloat alpha = 1 - (offsetToShow - scrollView.contentOffset.y) / offsetToShow;
//    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = alpha;
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetToShow = 200.0;
//    CGFloat alpha = 1 - (offsetToShow - scrollView.contentOffset.y) / offsetToShow;
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor orangeColor]colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
//}

//生成一张纯色的图片

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end
