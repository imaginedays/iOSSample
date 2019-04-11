//
//  RWUIScrollerViewController.m
//  iOSSizeClasses
//
//  Created by imaginedays on 2019/3/27.
//  Copyright © 2019 黄可. All rights reserved.
//

#import "RWUIScrollerViewController.h"
#import "RWStepTabView.h"
#import "RWPageView.H"

@interface RWUIScrollerViewController ()
@property (nonatomic, strong) RWPageView *step1ContentView;
@property (nonatomic, strong) UIScrollView *homeScrollView;
@property (nonatomic, strong) RWStepTabView *stepView;
@property (nonatomic, strong) UIButton *stepButton;  // !< stepButton
@property (nonatomic, copy)NSArray *titleArr;
@property (nonatomic, strong) UILabel *testLabel;
@end

@implementation RWUIScrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rw_setupViews];
}

- (void)rw_setupViews {
    self.stepView = [[RWStepTabView alloc]initWithFrame:CGRectMake(0, 100, RW_SCREEN_WIDTH, 50)];
    self.titleArr = @[@"Begin",@"A",@"B",@"C",@"Finish"];
    [self.stepView setupStepWithStepName:self.titleArr];
    [self.stepView setupStepWithIndex:1];
    
    [self.view addSubview:self.stepView];
    [self.view addSubview:self.testLabel];
//    [self.view addSubview:self.homeScrollView];
//    [self.view addSubview:self.stepButton];
    [self loadHtmlTOLabel];
    [self rw_makeConstraints];
}

- (void)loadHtmlTOLabel {
    //返回的HTML文本
    NSString *htmlStr = @"Enter <a href=\"https://app-gearbest.com.trunk.s1.egomsl.com/my-coupon.html\" target=\"_blank\"><b>\"My Coupon\"</b></a> page to.3. Go to your “My Coupon” page to view your Coupon!<br>4. GearBest reserves the right to amend this activity. For any queries, please contact our Support Staff. (<a href=\"https://support.gearbest.com\" target=\"_blank\">https://support.gearbest.com</a>)";
    
    //富文本，两种都可以
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    //或者
    //    NSDictionary *option = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType};
    //    NSData *data = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
    
    //设置富文本
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    //设置段落格式
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 7;
    para.paragraphSpacing = 10;
    [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attStr.length)];
    self.testLabel.attributedText = attStr;
    
    //设置文本的Font没有效果，默认12字号，这个只能服务器端控制吗？ 暂时没有找到方法修改字号
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, attStr.length)];
    //计算加载完成之后Label的frame
    CGSize size = [self.testLabel sizeThatFits:CGSizeMake(300, 1000)];
    //也可以使用这个方法，对应好富文本字典
    //    CGSize size = [self.testLabel.attributedText boundingRectWithSize:CGSizeMake(300, 1000) options:@{} context:nil];
    self.testLabel.frame = CGRectMake(50, 200, size.width, size.height);
}

#pragma mark setter and getter
- (UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 300, 100)];
        _testLabel.textColor = [UIColor blackColor];
        _testLabel.backgroundColor = [UIColor lightTextColor];
        _testLabel.textAlignment = NSTextAlignmentCenter;
        _testLabel.numberOfLines = 0;
        //怎么设置字号都没有效果
        _testLabel.font = [UIFont systemFontOfSize:20];
    }
    return _testLabel;
}

- (void)rw_makeConstraints {
//    [self.stepButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-20);
//        make.width.equalTo(@100);
//        make.height.equalTo(@40);
//    }];
    
//    [self.homeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.top.equalTo(self.stepView.mas_bottom);
//    }];
//
//    CGFloat contentHeight = RW_SCREEN_HEIGHT - 20 - 100;
//    // add SubView
//    [self.homeScrollView addSubview:self.step1ContentView];
    
//    [self.step1ContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(self.homeScrollView);
//        make.width.mas_equalTo(RW_SCREEN_WIDTH);
//        make.height.mas_equalTo(contentHeight);
//    }];
//
//    [self.homeScrollView setContentSize:CGSizeMake(RW_SCREEN_WIDTH * self.titleArr.count, contentHeight)];
    
}

- (void)jbf_stepButtonClick:(UIButton *)button {
    NSInteger tag = button.tag;
    if (tag >= self.titleArr.count) {
        tag = 0;
    }
    [self.homeScrollView setContentOffset:CGPointMake(tag * RW_SCREEN_WIDTH, 0) animated:YES];
    button.tag = button.tag + 1;
}

#pragma mark - Accessor
- (UIButton *)stepButton {
    if (!_stepButton) {
        _stepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stepButton setImage:[UIImage imageNamed:@"icon_more"] forState:UIControlStateNormal];
        [_stepButton addTarget:self action:@selector(jbf_stepButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stepButton;
}
- (RWPageView *)step1ContentView {
    if (!_step1ContentView) {
        _step1ContentView = [[RWPageView alloc] init];
        _step1ContentView.backgroundColor = UIColor.lightGrayColor;
    }
    return _step1ContentView;
}

- (UIScrollView *)homeScrollView {
    if (!_homeScrollView) {
        _homeScrollView = [[UIScrollView alloc] init];
        _homeScrollView.pagingEnabled = YES;
        _homeScrollView.scrollEnabled = NO;
        _homeScrollView.bounces = NO;
        _homeScrollView.showsVerticalScrollIndicator = NO;
        _homeScrollView.showsHorizontalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            _homeScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _homeScrollView;
}


@end
