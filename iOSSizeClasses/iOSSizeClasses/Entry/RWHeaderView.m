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
        _topImageView.image = [UIImage imageNamed:@"bg_top"];
    }
    return _topImageView;
}

@end
