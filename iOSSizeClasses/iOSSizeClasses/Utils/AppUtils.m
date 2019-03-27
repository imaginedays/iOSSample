//
//  AppUtils.m
//  iOSSizeClasses
//
//  Created by imaginedays on 2019/3/8.
//  Copyright © 2019 黄可. All rights reserved.
//

#import "AppUtils.h"

@implementation AppUtils
+ (NSString *)formatterNum:(NSString *)num {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *result = [formatter stringFromNumber:[NSNumber numberWithInt:1234567890]];
    NSLog(@"Formatted number result:%@",result);
    
    // 定制 小数点
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    
//    result = [formatter stringFromNumber:[NSNumber numberWithInt:1234567890.32]];
//    NSLog(@"Formatted number result:%@",result);
    
    // 定制 前后缀
//    formatter.positiveSuffix = @"元";
//    result = [formatter stringFromNumber:[NSNumber numberWithInt:1234567890]];
//    NSLog(@"Formatted number result:%@",result);
    
    // 定制 最大有效数字个数
    formatter.maximumSignificantDigits = 9;
    // 最少有效数字个数
    formatter.minimumSignificantDigits = 3;
    
    result = [formatter stringFromNumber:[NSNumber numberWithInt:1234567890]];
    NSLog(@"Formatted number result:%@",result);
    
    return result;
}
@end
