//
//  ZCProxy.h
//  ZCFPS
//
//  Created by 叶志成 on 2019/1/8.
//  Copyright © 2019 yzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCProxy : NSProxy

@property (nonatomic, weak, readonly) id target;

+ (instancetype)proxyWithTarget:(id)target;

@end

