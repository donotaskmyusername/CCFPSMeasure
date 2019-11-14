//
//  FPSCounter.h
//  LearnCrash
//
//  Created by satel on 2019/11/14.
//  Copyright © 2019 satel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CCFPSMeasure;

@protocol CCFPSMeasureDelegate <NSObject>

- (void)fpsMeasure:(CCFPSMeasure *)counter didUpdate:(float)fps;

@end

@interface CCFPSMeasure : NSObject

@property (nonatomic, weak) id<CCFPSMeasureDelegate> delegate;
// 多长时间更新一次（不是精确的），毫秒为单位；默认是1000毫秒，不能小于100毫秒；
@property (nonatomic, assign) NSInteger updateInterval;

- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
