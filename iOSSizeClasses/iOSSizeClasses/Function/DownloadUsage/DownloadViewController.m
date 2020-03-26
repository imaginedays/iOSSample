//
//  DownloadViewController.m
//  iOSSizeClasses
//  https://cloud.tencent.com/developer/article/1139946
//  Created by Robin Wong on 2020/3/20.
//  Copyright © 2020 Robin Wong. All rights reserved.
//

#import "DownloadViewController.h"

#import "DownloadNSDataViewController.h"
#import "DownloadNSURLConnectionVC.h"
#import "DownloadNSURLConnectionBigFileVC.h"

#import <WebKit/WebKit.h>

@interface DownloadViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate>
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, WKWebView *> *wkWebViewDic;  //!< 属性名称
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *footerViewHeightDic;  //!< 属性名称
@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"文件下载";
    
    self.wkWebViewDic = [[NSMutableDictionary alloc]init];
    self.footerViewHeightDic = [[NSMutableDictionary alloc]init];
    [self.footerViewHeightDic setObject:@(self.view.frame.size.height - 240) forKey:@(0)];
    [self.footerViewHeightDic setObject:@(0) forKey:@(1)];
    [self.footerViewHeightDic setObject:@(0) forKey:@(2)];
    
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
                            [[DownloadNSURLConnectionVC alloc]initWithTitle:@"文件下载断点续传-NSURLConnection"],
                            [[DownloadNSURLConnectionBigFileVC alloc]initWithTitle:@"文件下载断点续传-NSURLConnection-大文件下载"],
                            
                            ];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.controllers.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"CellIdentifier";
    UIViewController *viewController = self.controllers[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    if ([[self.footerViewHeightDic objectForKey:@(indexPath.section)] floatValue] == 0) {
        [self.footerViewHeightDic setObject:@(200) forKey:@(indexPath.section)];
    } else {
        [self.footerViewHeightDic setObject:@(0) forKey:@(indexPath.section)];
    }
    [tableView reloadData];
    
//    UIViewController *viewController = self.controllers[indexPath.section];
//    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.footerViewHeightDic objectForKey:@(section)]) {
        CGFloat height = ((NSNumber *)[self.footerViewHeightDic objectForKey:@(section)]).floatValue;
        NSLog(@"heightForFooterInSection = %f",height);
        return height;
    }
    return .1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.wkWebViewDic objectForKey:@(section)]) {
        return [self.wkWebViewDic objectForKey:@(section)];
    } else {
        WKWebView *wkWebView = [self jbf_createWKWebView];
        NSString *des = @"杜仲，中药材名。本品为杜仲科植物杜仲的树皮。为了保护资源，一般采用局部剥皮法。在清明至夏至间，选取生长15～20年以上的植株，按药材规格大小，剥下树皮，刨去粗皮，晒干。置通风干燥处。功能主治为：补肝肾，强筋骨，安胎。治腰脊酸疼，足膝痿弱，小便余沥，阴下湿痒，胎漏欲堕，胎动不安，高血压。①《本经》：主腰脊痛，补中益精气，坚筋骨，强志，除阴下痒湿，小便余沥。②《别录》：主脚中酸痛，不欲践地。③《药性论》：治肾冷臀腰痛，腰病人虚而身强直，风也。腰不利加而用之。④《日华子本草》：治肾劳，腰脊挛。入药炙用。⑤王好古：润肝燥，补肝经风虚。⑥《本草正》：止小水梦遗，暖子宫，安胎气。⑦《玉楸药解》：益肝肾，养筋骨，去关节湿淫。治腰膝酸痛，腿足拘挛。⑧《本草再新》：充筋力，强阳道。";
        NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                                        "<head> \n"
                                        "<style type=\"text/css\"> \n"
                                        "body {font-size:15px;}\n"
                                        "</style> \n"
                                        "</head> \n"
                                        "<body>"
                                        "<script type='text/javascript'>"
//                                        "window.onload = function(){\n"
//                                        "var $img = document.getElementsByTagName('img');\n"
//                                        "for(var p in  $img){\n"
//                                        " $img[p].style.width = '100%%';\n"
//                                        "$img[p].style.height ='auto'\n"
//                                        " let height = document.body.offsetHeight;\n"   "window.webkit.messageHandlers.imagLoaded.postMessage(height);\n"
//                                        "}\n"
//                                        "}"
                                        "</script>%@"
                                        "</body>"
                                        "</html>",des];
        [wkWebView loadHTMLString:htmlString baseURL:nil];
        [self.wkWebViewDic setObject:wkWebView forKey:@(section)];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
  [webView evaluateJavaScript:@"document.documentElement.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    CGFloat height = [result doubleValue];
      NSLog(@"height = %f",height);
    
    //通知cell更改约束
      [self.wkWebViewDic enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, WKWebView * _Nonnull obj, BOOL * _Nonnull stop) {
          if ([obj isEqual:webView]) {
              [self.tableView beginUpdates];
//              [self.footerViewHeightDic setObject:@(200) forKey:key];
              NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:[key integerValue]];
              [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
              [self.tableView endUpdates];
              *stop = YES;
          }
      }];
  }];
}

#pragma mark - Accessor
- (WKWebView *)jbf_createWKWebView {
    
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    NSString *script = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:script injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript: wkUserScript];
    
    configuration.userContentController = wkUController;
    
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    wkWebView.navigationDelegate = self;
    wkWebView.backgroundColor = [UIColor whiteColor];
    wkWebView.scrollView.backgroundColor = UIColor.whiteColor;
    wkWebView.opaque = NO;
    wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
    wkWebView.scrollView.showsVerticalScrollIndicator = YES;
    return wkWebView;
}

@end
