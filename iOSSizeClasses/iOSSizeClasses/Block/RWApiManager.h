//
//  RWApiManager.h
//  iOSSizeClasses
//
//  Created by imaginedays on 2019/3/8.
//  Copyright © 2019 黄可. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWApiPrivateProtocol.h"

typedef  NS_ENUM(NSInteger, RWRequest) {
    RWRequestSuccess,
    RWRequestError,
    RWRequestFailed,
    RWRequestNeedAuthCode,
    RWRequestRequestAuthCodeFast,
    RWRequestSingleButton,
    RWRequestLimitTime,
    RWRequestRiskUser,
    RWRequestLockedUser
};
typedef void(^RWRequestBlock)(RWRequest type, NSDictionary * _Nullable param);

NS_ASSUME_NONNULL_BEGIN

@interface RWApiManager : NSObject<RWApiPrivateProtocol>
+(RWApiManager *)shareManager;

- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
                    block:(RWRequestBlock)block;
@end

NS_ASSUME_NONNULL_END
