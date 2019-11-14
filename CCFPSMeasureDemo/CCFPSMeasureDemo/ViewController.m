//
//  ViewController.m
//  CCFPSMeasureDemo
//
//  Created by satel on 2019/11/14.
//  Copyright © 2019 satel. All rights reserved.
//

#import "ViewController.h"
#import "CCFPSMeasure.h"

@interface ViewController ()<CCFPSMeasureDelegate>

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, strong) CCFPSMeasure *fps;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onStartFPS:(id)sender
{
    self.fps = [[CCFPSMeasure alloc] init];
    self.fps.delegate = self;
    [self.fps start];
}

- (IBAction)onStopFPS:(id)sender
{
    [self.fps stop];
    self.fps = nil;
}

- (void)fpsMeasure:(CCFPSMeasure *)counter didUpdate:(float)fps
{
    self.label.text = [NSString stringWithFormat:@"FPS: %.1f", fps];
    [self.label sizeToFit];
}

@end
