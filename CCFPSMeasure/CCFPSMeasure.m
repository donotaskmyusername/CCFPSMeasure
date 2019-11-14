//
//  FPSCounter.m
//  LearnCrash
//
//  Created by satel on 2019/11/14.
//  Copyright © 2019 satel. All rights reserved.
//

#import "CCFPSMeasure.h"
#import <UIKit/UIKit.h>

@interface Counter : NSObject

@property (nonatomic, weak) CCFPSMeasure *container;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSInteger interval;

@end

@implementation Counter

- (id)init
{
    if (self = [super init])
    {
        self.count = 0;
        self.lastTime = -1;
        self.interval = 1000;
    }
    return self;
}

- (void)displayLinkTickAction:(CADisplayLink *)link
{
    if (self.lastTime <= 0)
    {
        self.lastTime = link.timestamp;
        return;
    }
    self.count += 1;
    NSTimeInterval delta = link.timestamp - self.lastTime;
    if (delta * 1000 >= self.interval)
    {
        self.lastTime = link.timestamp;
        float fps = self.count / delta;
        self.count = 0;
        NSLog(@"%.1f", fps);
        [self.container.delegate fpsMeasure:self.container didUpdate:fps];
    }
}

@end

@interface CCFPSMeasure ()

@property (nonatomic, strong) CADisplayLink* displayLink;
@property (nonatomic, strong) Counter *counter;

@end

@implementation CCFPSMeasure

- (id)init
{
    if (self = [super init])
    {
        self.updateInterval = 1000;
    }
    return self;
}

- (void)setUpdateInterval:(NSInteger)updateInterval
{
    assert(updateInterval > 100);
    _updateInterval = updateInterval;
}

- (void)dealloc
{
    [self stop];
}

- (void)start
{
    self.counter = [[Counter alloc] init];
    self.counter.container = self;
    self.counter.interval = self.updateInterval;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self.counter selector:@selector(displayLinkTickAction:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop
{
    [self.displayLink invalidate];
    self.displayLink = nil;
    self.counter = nil;
}

@end
