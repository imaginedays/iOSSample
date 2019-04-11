//
//  RWStepTabView.m
//  iOSSizeClasses
//
//  Created by imaginedays on 2019/3/27.
//  Copyright © 2019 黄可. All rights reserved.
//

#import "RWStepTabView.h"

@interface RWItemView ()
@property (nonatomic, strong) UILabel *titleLabel;  // !< titleLabel
@property (nonatomic, strong) UILabel *stepNumLabel;  //!< 属性名称
@property (nonatomic, strong) UIView *stepBackLine;  //!< 属性名称
@property (nonatomic, strong) UIView *stepFrontLine;  //!< 属性名称


/**
 状态字符串
 @"0,0,0,1"
 第一位 是否为第一项 0 不是 1是
 第三位 是否为最后一项 0 不是 1 是
 第四位 数字下标
 第五位 标题

 @param statusStr <#statusStr description#>
 */
- (void)setupItemStatusStr:(NSString *)statusStr;
- (void)rw_delightStepItem;
@end

@implementation RWItemView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupItemStatusStr:(NSString *)statusStr {
    NSArray *splitArr = [statusStr componentsSeparatedByString:@","];
    
    // 设置是否选中
    BOOL isFirst = [splitArr[0] boolValue];
    BOOL isLast = [splitArr[1] boolValue];
    int num = [splitArr[2] intValue];
    NSString *contentStr = splitArr[3];
    
    if (isFirst) {
        self.stepBackLine.hidden = YES;
    }
    
    self.stepNumLabel.text = [NSString stringWithFormat:@"%d",num];
   
    if (isLast) {
        self.stepFrontLine.hidden = YES;
    }
    
    self.titleLabel.text = contentStr;
    
}

- (void)rw_delightStepItem {
    
    if (!self.stepBackLine.isHidden) {
        self.stepBackLine.backgroundColor = [self lineHighlight];
    }
    
    if (!self.stepFrontLine.isHidden) {
        self.stepFrontLine.backgroundColor = [self lineHighlight];
    }
    
    // 数字
    self.stepNumLabel.textColor = HexRGB(0x333333);
    self.stepNumLabel.layer.backgroundColor = HexRGB(0xFFDA44).CGColor;
    
    // 文字
    self.titleLabel.textColor = HexRGB(0x333333);
    
}

- (void)setupViews {
    [self addSubview:self.stepBackLine];
    [self addSubview:self.stepFrontLine];
    [self addSubview:self.stepNumLabel];
    [self addSubview:self.titleLabel];
    
    [self rw_makeConstrants];
}

- (void)rw_makeConstrants {
    [self.stepNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.height.equalTo(@18);
    }];
    
    [self.stepBackLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        make.height.equalTo(@(0.5));
        make.right.equalTo(self.stepNumLabel.mas_left);
    }];
    
    [self.stepFrontLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.stepNumLabel.mas_right);
        make.height.equalTo(@(0.5));
        make.right.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.stepNumLabel.mas_bottom).offset(5);
    }];
}
- (void)setupHightItemView {
    
}
#pragma mark - Accessor
- (UIView *)stepBackLine {
    if (!_stepBackLine) {
        _stepBackLine = [[UIView alloc] init];
        _stepBackLine.backgroundColor = [self lineNormal];
    }
    return _stepBackLine;
}

- (UIView *)stepFrontLine {
    if (!_stepFrontLine) {
        _stepFrontLine = [[UIView alloc] init];
        _stepFrontLine.backgroundColor = [self lineNormal];
    }
    return _stepFrontLine;
}


- (UILabel *)stepNumLabel {
    if (!_stepNumLabel) {
        _stepNumLabel = [[UILabel alloc] init];
        _stepNumLabel.font = [UIFont systemFontOfSize:12.0f];
        _stepNumLabel.textColor = [UIColor whiteColor];
        _stepNumLabel.textAlignment = NSTextAlignmentCenter;
        _stepNumLabel.clipsToBounds = YES;
        _stepNumLabel.layer.cornerRadius = 9.0f;
        _stepNumLabel.layer.backgroundColor = [HexRGB(0xDFE1E6) CGColor];
    }
    return _stepNumLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel.textColor = HexRGB(0x999999);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIColor *)lineHighlight {
    return HexRGB(0xFFDA44);
}

- (UIColor *)lineNormal {
    return HexRGB(0xDFE1E6);
}

@end

@interface RWStepTabView () {
    CGFloat itemWidth;
}
@property (nonatomic, copy) NSMutableArray<RWItemView *> *imageArray;
@end

@implementation RWStepTabView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageArray = [NSMutableArray arrayWithCapacity:0];
        [self rw_setupViews];
    }
    return self;
}

- (void)rw_setupViews {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setupStepWithStepName:(NSArray *)titleArr {
    
    if (titleArr && titleArr.count > 0) {
        itemWidth = RW_SCREEN_WIDTH / titleArr.count ;
        for (int i = 0; i < titleArr.count; i++) {
            RWItemView *item = [[RWItemView alloc]initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, self.frame.size.height)];
            [item setupItemStatusStr:[NSString stringWithFormat:@"%d,%d,%d,%@",((i == 0) ? YES:NO),((i == titleArr.count - 1) ? YES:NO),i + 1,titleArr[i]]];
            [self addSubview:item];
            [_imageArray addObject:item];
        }
    }
}

- (void)setupStepWithIndex:(int)index {
    if (_imageArray && _imageArray.count > 0) {
        if (index > _imageArray.count) {
            return;
        }
        
        [_imageArray enumerateObjectsUsingBlock:^(RWItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx <= index) {
                [obj rw_delightStepItem];
            }
        }];
    }
}

@end
