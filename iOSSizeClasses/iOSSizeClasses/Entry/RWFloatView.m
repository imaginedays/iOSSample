//
//  RWFloatView.m
//  iOSSizeClasses
//
//  Created by imaginedays on 2018/9/18.
//  Copyright © 2018年 黄可. All rights reserved.
//

#import "RWFloatView.h"
#define kNavigationHeight 64

@interface RWFloatView()
@property (nonatomic, strong) UITableView *tableView;    //!< 属性名称
@property (nonatomic, assign) float defaultOffsetY;
@property (nonatomic, assign) float defaultHeight;
@end

@implementation RWFloatView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void)registerTableView:(UITableView *)tableView {
    self.tableView = tableView;
    self.defaultOffsetY = (0 - tableView.contentInset.top);
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if ([object isKindOfClass:[UITableView class]]) {
            [self updateUIWithContentOffsetY:((UITableView *)object).contentOffset.y];
        }
    }
}

- (void)updateUIWithContentOffsetY:(float)contentOffsetY {
    float height = MAX((kNavigationHeight-contentOffsetY), kNavigationHeight);
    self.frame = CGRectMake(0, 0, self.frame.size.width, height);
}

@end
