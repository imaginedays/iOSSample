//
//  FlutterRouter.h
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/8/14.
//  Copyright © 2019 Robin Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FlutterRouter : NSObject
@property (nonatomic,strong) UINavigationController *navigationController;

+ (FlutterRouter *)sharedRouter;
@end

NS_ASSUME_NONNULL_END
