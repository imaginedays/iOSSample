//
//  AppDelegate+JLRoutesRegister.m
//  iOSSizeClasses
//
//  Created by imaginedays on 2018/10/17.
//  Copyright © 2018 黄可. All rights reserved.
//

#import "AppDelegate+JLRoutesRegister.h"
#import <JLRoutes.h>
#import <objc/runtime.h>
#import "RWBaseViewController.h"
@implementation AppDelegate (JLRoutesRegister)

- (void)registerRouteWithScheme:(NSString *)scheme {
    //RoutesOne://push/UIViewController  push UIViewController 模式
    [[JLRoutes routesForScheme:scheme] addRoute:@"/push/:UIViewController"handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *vcName = parameters[@"UIViewController"];
        //将我们的storyBoard实例化,“Main”为StoryBoard的名称
//        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
//        if ([mainStoryBoard instantiateViewControllerWithIdentifier:vcName] != nil) {
//            //跳转事件
//            UIViewController *currentVc = [self currentViewController];
//            [currentVc.navigationController pushViewController:[mainStoryBoard instantiateViewControllerWithIdentifier:vcName] animated:YES];
//        }else {
            //根据字符串初始化UIViewController
            Class class = NSClassFromString(vcName);
            UIViewController *nextVC = [[class alloc] init];
            //给UIViewController赋值
            [self paramToVc:nextVC param:parameters];
            UIViewController *currentVc = [self currentViewController];
            [currentVc.navigationController pushViewController:nextVC animated:YES];
//        }
        return YES;
    }];
}

//确定是哪个viewcontroller
- (UIViewController *)currentViewController {
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}

- (void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters {
    // runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

@end
