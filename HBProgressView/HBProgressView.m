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
@property (nonatomic, strong) CAShapeLayer *completionShapeLayer;

@end

@implementation HBProgressView

@synthesize completionFactor = _completionFactor;

@synthesize totalShapeLayer = _totalShapeLayer;
@synthesize completionShapeLayer = _completionShapeLayer;

#pragma init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.totalShapeLayer = [[CAShapeLayer alloc] init];
        self.totalShapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.totalShapeLayer.fillColor = [UIColor blueColor].CGColor;
        self.totalShapeLayer.masksToBounds = YES;
        [self.layer addSublayer:self.totalShapeLayer];
        
        self.completionShapeLayer = [[CAShapeLayer alloc] init];
        self.completionShapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.completionShapeLayer.fillColor = [UIColor redColor].CGColor;
        [self.totalShapeLayer addSublayer:self.completionShapeLayer];
    }
    
    return self;
}

#pragma mark - UIView

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cornerRadius = CGRectGetHeight(self.layer.bounds);
    UIBezierPath *totalBezierPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds
                                                          byRoundingCorners:UIRectCornerAllCorners
                                                                cornerRadii:CGSizeMake(cornerRadius, 
                                                                                       cornerRadius)];
    
    self.totalShapeLayer.frame = self.layer.bounds;
    self.totalShapeLayer.path = totalBezierPath.CGPath;
    
    UIBezierPath *completionBezierPath = [totalBezierPath copy];
    [completionBezierPath applyTransform:CGAffineTransformMakeTranslation((1 - self.completionFactor) * -CGRectGetWidth(self.totalShapeLayer.bounds),
                                                                          1)];
    self.completionShapeLayer.frame = self.totalShapeLayer.bounds;
    self.completionShapeLayer.path = completionBezierPath.CGPath;
}

#pragma mark - public API

- (void) setCompletionFactor:(CGFloat)completionFactor {
    if (_completionFactor != completionFactor) {
        _completionFactor = completionFactor;
        
        [self setNeedsLayout];
    }
}

@end
