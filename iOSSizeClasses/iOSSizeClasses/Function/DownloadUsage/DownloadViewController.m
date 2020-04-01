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

@interface CellStateModel : NSObject
@property (nonatomic, assign) BOOL isOpen;  //!< 属性名称
@property (nonatomic, assign) CGFloat height;  //!< 属性名称
@end

@implementation CellStateModel

@end

@interface DownloadViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate>
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, WKWebView *> *wkWebViewDic;  //!< 属性名称
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, CellStateModel *> *footerViewStateDic;  //!< 属性名称
@property (nonatomic, assign) CGFloat explandHeight;  //!< 属性名称
@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"文件下载";
    self.explandHeight = 0;//RW_SCREEN_HEIGHT - RW_NAVI_BAR_HEIGHT - 180.0f;
    
    self.wkWebViewDic = [[NSMutableDictionary alloc]init];
    self.footerViewStateDic = [[NSMutableDictionary alloc]init];
    CellStateModel *model1 = [CellStateModel new];
    model1.isOpen = YES;
    model1.height = self.explandHeight;
    [self.footerViewStateDic setObject:model1 forKey:@(0)];
    
    CellStateModel *model2 = [CellStateModel new];
    model2.isOpen = NO;
    model2.height = 0;
    [self.footerViewStateDic setObject:model2 forKey:@(1)];
    
    CellStateModel *model3 = [CellStateModel new];
    model3.isOpen = NO;
    model3.height = 0;
    [self.footerViewStateDic setObject:model3 forKey:@(2)];
    
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
                            [[DownloadNSDataViewController alloc] initWithTitle:@"文件下载-NSData"],
                            [[DownloadNSURLConnectionVC alloc]initWithTitle:@"文件下载-NSURLConnection"],
                            [[DownloadNSURLConnectionBigFileVC alloc]initWithTitle:@"文件下载-NSURLConnection-大文件下载"],
                            
                            ];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
    
//    [self.footerViewStateDic enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, CellStateModel * _Nonnull obj, BOOL * _Nonnull stop) {
//        if ([key integerValue] == indexPath.section) {
//             obj.isOpen = !obj.isOpen;
//             obj.height = self.explandHeight;
//            if (obj.isOpen) {
//                obj.height = self.explandHeight;
//            } else {
//                obj.height = 0.0f;
//            }
//        } else {
//            obj.isOpen = NO;
//            obj.height = 0;
//        }
//    }];
//    [self.tableView reloadData];
    
    UIViewController *viewController = self.controllers[indexPath.section];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.footerViewStateDic objectForKey:@(section)]) {
        CellStateModel *model = [self.footerViewStateDic objectForKey:@(section)];
        CGFloat height = model.height;
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
