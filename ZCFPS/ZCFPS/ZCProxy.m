//
//  ZCProxy.m
//  ZCFPS
//
//  Created by 叶志成 on 2019/1/8.
//  Copyright © 2019 yzc. All rights reserved.
//

#import "ZCProxy.h"

@interface ZCProxy()

- (instancetype)initWithTarget:(id)target;

@end

@implementation ZCProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {

    return [[ZCProxy alloc] initWithTarget:target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
