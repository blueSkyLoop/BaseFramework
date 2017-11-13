//
//  FPSLabel.m
//  BaseFramework
//
//  Created by Beelin on 17/2/20.
//  Copyright © 2017年 Mantis-man. All rights reserved.
//

#import "FPSLabel.h"
#import "OOProxy.h"

@interface FPSLabel()
@property (nonatomic, strong) CADisplayLink  *link;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSTimeInterval lastTime;
@end


@implementation FPSLabel
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = CGSizeMake(70, 20);
    }
    self = [super initWithFrame:frame];
    
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    
    self.link = [CADisplayLink displayLinkWithTarget:[OOProxy proxyWithTarget:self] selector:@selector(tick:)];
    
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)dealloc {
    [self.link invalidate];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(70, 20);;
}

- (void)tick:(CADisplayLink *)link {
    if (self.lastTime == 0) {
        self.lastTime = link.timestamp;
        return;
    }
    
    self.count++;
    NSTimeInterval delta = link.timestamp - self.lastTime;
    if (delta < 1) return;
    self.lastTime = link.timestamp;
    float fps = self.count / delta;
    self.count = 0;
    
    self.text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    NSLog(@"fps: %@",self.text);
}

@end
