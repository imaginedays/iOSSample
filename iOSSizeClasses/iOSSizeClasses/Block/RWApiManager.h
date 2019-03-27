//
//  RWApiManager.h
//  iOSSizeClasses
//
//  Created by imaginedays on 2019/3/8.
//  Copyright © 2019 黄可. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWApiPrivateProtocol.h"

typedef  NS_ENUM(NSInteger, WJLoginVerification) {
    WJLoginVerificationSuccess,
    WJLoginVerificationError,
    WJLoginVerificationFailed,
    WJLoginVerificationNeedAuthCode,
    WJLoginVerificationRequestAuthCodeFast,
    WJLoginVerificationSingleButton,
    WJLoginVerificationLimitTime,
    WJLoginVerificationRiskUser,
    WJLoginVerificationLockedUser
};
typedef void(^WJLoginVerificationBlock)(WJLoginVerification type, NSDictionary *param);

NS_ASSUME_NONNULL_BEGIN

@interface RWApiManager : NSObject<RWApiPrivateProtocol>
+(RWApiManager *)shareManager;

- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
                      sid:(NSString *)sid
                    token:(NSString *)token
                    block:(WJLoginVerificationBlock)block;
@end

NS_ASSUME_NONNULL_END
