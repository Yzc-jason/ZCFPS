//
//  ZCFPSView.m
//  ZCFPS
//
//  Created by 志成 on 2019/8/13.
//  Copyright © 2019 yzc. All rights reserved.
//

#import "ZCFPSView.h"
#import "ZCFPSLabel.h"

@implementation ZCFPSView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        ZCFPSLabel *fpsLabel = [[ZCFPSLabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:fpsLabel];
    }
    return self;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch       = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint prePoint     = [touch previousLocationInView:self];
    CGFloat offSetX      = currentPoint.x - prePoint.x;
    CGFloat offSetY      = currentPoint.y - prePoint.y;
    
    self.transform = CGAffineTransformTranslate(self.transform, offSetX, offSetY);
}

@end
