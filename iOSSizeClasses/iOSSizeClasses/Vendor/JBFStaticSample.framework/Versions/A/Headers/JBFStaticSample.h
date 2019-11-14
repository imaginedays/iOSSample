//
//  JBFStaticSample.h
//  JBFStaticSample
//
//  Created by imaginedays on 2019/11/6.
//  Copyright © 2019 Robin Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^JBFStaticCompletion)(NSString *result);

@interface JBFStaticSample : NSObject
- (void)urlType:(NSString *)urltype withCompletion:(JBFStaticCompletion)completion;
@end
