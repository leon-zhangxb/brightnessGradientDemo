//
//  JCBrightness.m
//
//  Created by HJaycee on 16/8/13.
//  Copyright © 2016年 HJaycee. All rights reserved.
//

#import "JCBrightness.h"

static CGFloat _currentBrightness;
static NSOperationQueue *_queue;

@implementation JCBrightness

+ (void)initialize{
    //系统通知：手机亮度改变时发送的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveDefaultBrightness) name:UIScreenBrightnessDidChangeNotification object:nil];
    
//    [self saveDefaultBrightness];
}

+ (void)saveDefaultBrightness{
    _currentBrightness = [UIScreen mainScreen].brightness;
}

+ (void)graduallySetBrightness:(CGFloat)value{

    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    [_queue cancelAllOperations];
    NSLog(@"将要变为的亮度%f",value);
    CGFloat brightness = [UIScreen mainScreen].brightness;
    CGFloat step = 0.005 * ((value > brightness) ? 1 : -1);
    int times = fabs((value - brightness) / 0.005);
    //根据亮度差计算出时间和每个单位时间调节的亮度值
    for (CGFloat i = 1; i < times + 1; i++) {
        
        [_queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:1 / 180.0];
            [UIScreen mainScreen].brightness = brightness + i * step;
        }];
    }
}

+ (void)graduallyResumeBrightness{
    [self graduallySetBrightness:_currentBrightness];
}

+ (void)fastResumeBrightness{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    [_queue cancelAllOperations];
    [_queue addOperationWithBlock:^{
        [UIScreen mainScreen].brightness = _currentBrightness;
    }];
}

@end
