//
//  RWView.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/10/18.
//  Copyright © 2019 Robin Wong. All rights reserved.
//

#import "RWView.h"
#import "RWLayer.h"

@implementation RWView

-(instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@">>>>>>>> RWView");
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"RWView - touchesBegan");
    [self printResponderChain];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
     NSLog(@"RWView - touchesMoved");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
     NSLog(@"RWView - touchesEnded");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
     NSLog(@"RWView -touchesCancelled");
}

- (void)printResponderChain {
    UIResponder *responder = self;
    printf("%s",[NSStringFromClass([responder class]) UTF8String]);
    while (responder.nextResponder) {
        responder = responder.nextResponder;
        printf(" --> %s",[NSStringFromClass([responder class]) UTF8String]);
    }
}

+ (Class)layerClass {
    return [RWLayer class];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

- (void)setCenter:(CGPoint)center{
    [super setCenter:center];
}

- (void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSLog(@"drawRect");
}

@end
