//
//  UIView+Category.m
//  ZCFPS
//
//  Created by 叶志成 on 2019/1/8.
//  Copyright © 2019 yzc. All rights reserved.
//

#import "UIView+Category.h"
#import "ZCFPSLabel.h"

@implementation UIView (Category)

+ (void)load {
#if defined(DEBUG)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zc_applicationDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    });
# endif
}

- (void)fpsDetect {
    CGFloat mainScreen = [UIScreen mainScreen].bounds.size.height;
    CGFloat fpsLabelY  = mainScreen - 49;
    
    if (mainScreen >= 812) { //iPhone X MAX XR
        fpsLabelY = fpsLabelY - 34;
    }
    
    ZCFPSLabel *fpsLabel = [[ZCFPSLabel alloc] initWithFrame:CGRectMake(0, fpsLabelY, 50, 20)];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:fpsLabel];
}

+ (void)zc_applicationDidFinishLaunching:(NSNotification *)noti{
    [[self alloc] fpsDetect];
}

@end
