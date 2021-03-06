//
//  AppDelegate.m
//  iOSSizeClasses
//
//  Created by 黄可 on 2016/12/5.
//  Copyright © 2016年 黄可. All rights reserved.
//

#import "AppDelegate.h"
#import <JLRoutes/JLRoutes.h>
#import "AppDelegate+JLRoutesRegister.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [FIRApp configure];
    /*
     外部打开APP
     NSURL *viewUserURL = [NSURL URLWithString:@"myapp://user/view/joeldev"];
     [[UIApplication sharedApplication] openURL:viewUserURL];
     */
//    JLRoutes *routes = [JLRoutes globalRoutes];
//    [routes addRoute:@"user/view/:userID" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
//        NSString *userID = parameters[@"userID"]; // defined in the route by specifying ":userID"
//        NSLog(@"userID: %@",userID);
//        // present UI for viewing user with ID 'userID'
//        return YES; // return YES to say we have handled the route
//    }];
//
//    [[JLRoutes routesForScheme:@"RoutesOne"] addRoute:@"/:user/:view/:userID" handler:^BOOL(NSDictionary *parameters) {
//        NSString *user = parameters[@"user"];
//        NSString *view = parameters[@"view"];
//        NSString *userID = parameters[@"userID"];
//        NSLog(@"user = %@,view = %@,userID = %@",user,view,userID);
//        return YES;
//    }];
//
//    [[JLRoutes routesForScheme:@"RoutesTwo"] addRoute:@"/Two" handler:^BOOL(NSDictionary *parameters) {
//        return YES;
//    }];
//
//    JLRoutes.globalRoutes[@"/:user/:view/:userID"] = ^BOOL(NSDictionary *parameters) {
//        NSString *user = parameters[@"user"];
//        NSString *view = parameters[@"view"];
//        NSString *userID = parameters[@"userID"];
//        NSLog(@"user = %@,view = %@,userID = %@",user,view,userID);
//        return YES;
//    };
//    FlutterRouter *router = [FlutterRouter sharedRouter];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    router.navigationController = storyboard.instantiateInitialViewController;
//    
//    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:router onStart:^(FlutterViewController *fvc){
//        
//    }];
    [self registerRouteWithScheme:@"RoutesOne"];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [JLRoutes routeURL:url];
}

@end
