//
//  RWAutoDictionary.h
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/5/7.
//  Copyright © 2019 黄可. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RWAutoDictionary : NSObject
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSData *date;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) id opaqueObject;
@end

NS_ASSUME_NONNULL_END
