//
//  MasScrollerViewController.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/8/6.
//  Copyright © 2019 Robin Wong. All rights reserved.
//

#import "MasScrollerViewController.h"

@interface MasScrollerViewController ()
// scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
// 约束参照视图,也是容器视图
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray *contentViewArr;
@end

@implementation MasScrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexRGB(0x333333);
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat height = 300.0f;
    NSLog(@"height = %f",height);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.0f);
        make.right.mas_equalTo(-20.0f);
        make.top.equalTo(self.view).offset(100);
        make.height.mas_equalTo(height);
    }];
    
    // 设置参照视图的约束
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView).offset(10);
        make.bottom.right.equalTo(self.scrollView).offset(-10);
        
    }];
    
    self.contentViewArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 10; i++) {
        UIView *tempView = [self vueView];
        [self.contentViewArr addObject:tempView];
        [self.contentView addSubview:tempView];
    }
    
    for (int i = 0; i < self.contentViewArr.count; i++) {
        UIView *tempView = self.contentViewArr[i];
        [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.mas_equalTo(self.contentView).offset(10.0f);
            } else {
                make.left.equalTo(((UIView *)(self.contentViewArr[i - 1])).mas_right).offset(10.0f);
            }
            
            if (i == self.contentViewArr.count - 1) {
                make.right.equalTo(self.contentView);
            }
            
            make.width.mas_equalTo(self.view).multipliedBy(0.75);
            make.height.mas_equalTo(height - 20);
            
        }];
//        [self addLayerToContentView:tempView];
    }
}

- (void)addLayerToContentView:(UIView *)view {
    //渐变卡片
    CAGradientLayer * layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)HexRGB(0xFFDA44).CGColor ,(__bridge id)HexRGB(0xFFEB5B).CGColor];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    layer.cornerRadius = 10.0f;
    layer.shadowOpacity = 0.6f;
    layer.shadowOffset = CGSizeMake(0.0f, 7.0f);
    layer.shadowColor = [HexRGB(0x504121) colorWithAlphaComponent:0.13].CGColor;
    layer.shadowRadius = 10.0f;
    [view.layer addSublayer:layer];
}

#pragma mark - getters
// scrollView
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
// 约束参照视图
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = HexRGB(0xABCDEF);
    }
    return _contentView;
}

- (UIView *)vueView {
    UIView *view = [UIView new];
    view.backgroundColor =  randomColor;
    return view;
}
@end
