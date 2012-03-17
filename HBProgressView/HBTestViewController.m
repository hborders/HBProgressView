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

@end

@implementation HBTestViewController

@synthesize progressView = _progressView;

#pragma mark - init/dealloc

- (id)init {
    return [super initWithNibName:nil
                           bundle:nil];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    self.progressView = 
    [[HBProgressView alloc] initWithFrame:CGRectInset(self.view.bounds,
                                                      CGRectGetWidth(self.view.bounds) / 16, 
                                                      CGRectGetHeight(self.view.bounds) / 4)];
    [self.view addSubview:self.progressView];
}

- (void)viewDidUnload {
    self.progressView = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
