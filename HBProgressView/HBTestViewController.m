//
//  HBTestViewController.m
//  HBProgressView
//
//  Created by Heath Borders on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HBTestViewController.h"
#import "HBProgressView.h"

@interface HBTestViewController ()

@property (nonatomic, strong) HBProgressView *progressView;
@property (nonatomic, strong) NSTimer *progressTimer;

@end

@implementation HBTestViewController

@synthesize progressView = _progressView;
@synthesize progressTimer = _progressTimer;

#pragma mark - init/dealloc

- (id)init {
    return [super initWithNibName:nil
                           bundle:nil];
}

- (void) dealloc {
    [self.progressTimer invalidate];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    self.progressView = 
    [[HBProgressView alloc] initWithFrame:CGRectInset(self.view.bounds,
                                                      CGRectGetWidth(self.view.bounds) / 16, 
                                                      CGRectGetHeight(self.view.bounds) / 4)];
    [self.view addSubview:self.progressView];
    
    UIButton *showProgressButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [showProgressButton addTarget:self 
                           action:@selector(startProgressTimer)
                 forControlEvents:UIControlEventTouchUpInside];
    showProgressButton.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 16,
                                          CGRectGetHeight(self.view.bounds) * 7 / 8,
                                          CGRectGetWidth(self.view.bounds) * 7 / 8, 
                                          CGRectGetHeight(self.view.bounds) * 1 / 16);
    [showProgressButton setTitle:@"Show Progress" 
                        forState:UIControlStateNormal];
    [self.view addSubview:showProgressButton];
}

- (void)viewDidUnload {
    self.progressView = nil;
    [self.progressTimer invalidate];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - private API

- (void) startProgressTimer {
    self.progressView.completionFactor = 0;
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:.2
                                                          target:self
                                                        selector:@selector(updateProgress)
                                                        userInfo:nil 
                                                         repeats:YES];
}

- (void) updateProgress {
    self.progressView.completionFactor += .1;
    if (self.progressView.completionFactor >= 1) {
        self.progressView.completionFactor = 1;
        [self.progressTimer invalidate];
    }
}

@end
