//
//  RWApiManager.m
//  iOSSizeClasses
//
//  Created by imaginedays on 2019/3/8.
//  Copyright © 2019 黄可. All rights reserved.
//

#import "RWApiManager.h"
#import <objc/message.h>

#define WJLoginVerification(replayCode, param) \
GetBlockAndCall(WJLoginVerification, loginSelector, replayCode, param);

@implementation RWApiManager
#define loginSelector @selector(loginWithUserName:password:sid:token:block:)
- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
                      sid:(NSString *)sid
                    token:(NSString *)token
                    block:(WJLoginVerificationBlock)block {
    if (userName.length > 0) {
        block(WJLoginVerificationSuccess,@{@"msg":userName});
    }
 SetBlock(loginSelector);
}

+(RWApiManager *)shareManager {
    static dispatch_once_t onceToken;
    static id singleInstance;
    
    dispatch_once(&onceToken, ^{
        singleInstance = [[RWApiManager alloc] init];
    });
    return singleInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        // init config
    }
    return self;
}

#pragma mark Associate Object

- (void)setCallBackBlock:(id)block selector:(SEL)selector {
    if (block) {
        objc_setAssociatedObject(self, selector, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (id)getCallBackBlockWithSelector:(SEL)selector {
    id block = objc_getAssociatedObject(self, selector);
    return block;
}

@end
