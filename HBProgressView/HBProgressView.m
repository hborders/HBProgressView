//
//  HBProgressView.m
//  HBProgressView
//
//  Created by Heath Borders on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HBProgressView.h"
#import <QuartzCore/QuartzCore.h>

@interface HBProgressView()

@property (nonatomic, strong) CAShapeLayer *totalShapeLayer;

@end

@implementation HBProgressView

@synthesize totalShapeLayer = _totalShapeLayer;

#pragma init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.totalShapeLayer = [[CAShapeLayer alloc] init];
        self.totalShapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.totalShapeLayer.fillColor = [UIColor blueColor].CGColor;
        [self.layer addSublayer:self.totalShapeLayer];
    }
    
    return self;
}

#pragma mark - UIView

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cornerRadius = MIN(CGRectGetWidth(self.layer.bounds),
                               CGRectGetHeight(self.layer.bounds));
    UIBezierPath *totalBezierPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds
                                                          byRoundingCorners:UIRectCornerAllCorners
                                                                cornerRadii:CGSizeMake(cornerRadius, 
                                                                                       cornerRadius)];
    
    self.totalShapeLayer.frame = self.layer.bounds;
    self.totalShapeLayer.path = totalBezierPath.CGPath;
}

@end
