//
//  RWAutoDictionary.m
//  iOSSizeClasses
//
//  Created by Robin Wong on 2019/5/7.
//  Copyright © 2019 黄可. All rights reserved.
//

#import "RWAutoDictionary.h"
#import <objc/runtime.h>

@interface RWAutoDictionary ()
@property (nonatomic, copy) NSMutableDictionary *backingStore;  //!< 属性名称
@end

@implementation RWAutoDictionary

@dynamic string,number,date,opaqueObject;

- (instancetype)init {
    self = [super init];
    if (self) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

id autoDictionaryGetter(id self, SEL _cmd) {
    RWAutoDictionary *typedSelf = (RWAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    NSString *key = NSStringFromSelector(_cmd);
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    RWAutoDictionary *typedSelf = (RWAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    if (value) {
        [backingStore setObject:value forKey:key];
    } else {
        [backingStore removeObjectForKey:key];
    }
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    } else {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}

@end
