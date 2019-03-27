//
//  RWApiPrivateProtocol.h
//  iOSSizeClasses
//
//  Created by imaginedays on 2019/3/8.
//  Copyright © 2019 黄可. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GetBlockAndCall(prefixedDefine, AssociatedSelector, replyCode, param) \
prefixedDefine##Block block = [self getCallBackBlockWithSelector:AssociatedSelector];\
!block ?: block(prefixedDefine##replyCode, (param));

#define SetBlock(AssociatedSelector) \
[self setCallBackBlock:block selector:AssociatedSelector];

NS_ASSUME_NONNULL_BEGIN

@protocol RWApiPrivateProtocol <NSObject>

- (void)setCallBackBlock:(id)block selector:(SEL)selector;
- (id)getCallBackBlockWithSelector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
