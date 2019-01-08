//
//  ZCFPSLabel.m
//  ZCFPS
//
//  Created by 叶志成 on 2019/1/8.
//  Copyright © 2019 yzc. All rights reserved.
//

#import "ZCFPSLabel.h"
#import "ZCProxy.h"

@interface ZCFPSLabel ()

@property (nonatomic, strong) CADisplayLink  *link;
@property (nonatomic, assign) NSInteger      count;
@property (nonatomic, assign) NSTimeInterval lastTimestamp;
@property (nonatomic, assign) CGFloat      fps;

@end

@implementation ZCFPSLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment   = NSTextAlignmentCenter;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.font            = [UIFont boldSystemFontOfSize:13];
        
        self.link = [CADisplayLink displayLinkWithTarget:[ZCProxy proxyWithTarget:self] selector:@selector(displayLinkTicks:)];
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(fps)) options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:NSStringFromSelector(@selector(fps))]) {
        int oldFps = (int)round( [[change valueForKey:NSKeyValueChangeOldKey] integerValue]);
        int newFps = (int)round( [[change valueForKey:NSKeyValueChangeNewKey] integerValue]);
        if (oldFps != newFps) {
            [self updateLabelWithFps];
        }
    }
}

- (void)dealloc {
    [self.link invalidate];
}

- (void)displayLinkTicks:(CADisplayLink *)link {
    if (!self.lastTimestamp) {
        self.lastTimestamp = link.timestamp;
        return;
    }
    
    self.count++;
    NSTimeInterval interval = link.timestamp - self.lastTimestamp;
    if (interval < 1) return;
    self.lastTimestamp = link.timestamp;
    self.fps           = self.count / interval;
    self.count         = 0;
}

- (void)updateLabelWithFps {
    CGFloat                   progress = self.fps / 60.0;
    UIColor                   *color   = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    NSMutableAttributedString *text    = [[NSMutableAttributedString alloc]
                                          initWithString:[NSString stringWithFormat:@"%d FPS", (int)round(self.fps)]];
    
    [text addAttribute:NSForegroundColorAttributeName value:color
                 range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]
                 range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:self.font
                 range:NSMakeRange(0, text.length)];
    self.attributedText = text;
}

@end
