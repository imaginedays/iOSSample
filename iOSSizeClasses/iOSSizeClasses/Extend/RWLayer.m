//
//  RWLayer.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/10/18.
//  Copyright © 2019 Robin Wong. All rights reserved.
//

#import "RWLayer.h"

@implementation RWLayer
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@">>>>>>>>>>> RWLayer init");
    }
    return self;
}

+ (Class)layerClass{
    return [RWLayer class];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

- (void)setPosition:(CGPoint)position{
    [super setPosition:position];
}

- (void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
}
@end
