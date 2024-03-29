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

@property (nonatomic, strong) CAShapeLayer *maskShapeLayer;
@property (nonatomic, strong) CAShapeLayer *completionShapeLayer;
@property (nonatomic, strong) CAShapeLayer *shadowShapeLayer;

@end

@implementation HBProgressView

@synthesize completionFactor = _completionFactor;

@synthesize maskShapeLayer = _maskShapeLayer;
@synthesize completionShapeLayer = _completionShapeLayer;
@synthesize shadowShapeLayer = _shadowShapeLayer;

#pragma init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.backgroundColor = [UIColor blueColor].CGColor;
        
        self.maskShapeLayer = [[CAShapeLayer alloc] init];
        self.maskShapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.maskShapeLayer.fillColor = [UIColor blackColor].CGColor;
        self.layer.mask = self.maskShapeLayer;
        
        self.completionShapeLayer = [[CAShapeLayer alloc] init];
        self.completionShapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.completionShapeLayer.fillColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:self.completionShapeLayer];
        
        self.shadowShapeLayer = [[CAShapeLayer alloc] init];
        self.shadowShapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.shadowShapeLayer.fillColor = [UIColor purpleColor].CGColor;
        self.shadowShapeLayer.fillRule = kCAFillRuleEvenOdd;
        self.shadowShapeLayer.shadowColor = [UIColor blackColor].CGColor;
        self.shadowShapeLayer.shadowOpacity = .5;
        [self.layer addSublayer:self.shadowShapeLayer];
    }
    
    return self;
}

#pragma mark - UIView

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cornerRadius = CGRectGetHeight(self.layer.bounds);
    UIBezierPath *maskBezierPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds
                                                         byRoundingCorners:UIRectCornerAllCorners
                                                               cornerRadii:CGSizeMake(cornerRadius, 
                                                                                      cornerRadius)];
    
    self.maskShapeLayer.frame = self.layer.bounds;
    self.maskShapeLayer.path = maskBezierPath.CGPath;
    
    self.completionShapeLayer.frame = self.layer.bounds;
    
    if (self.completionFactor == 0) {
        self.completionShapeLayer.path = NULL;
    } else {        
        UIBezierPath *completionBezierPath = [maskBezierPath copy];
        if (self.completionFactor == 1) {
            self.completionShapeLayer.path = completionBezierPath.CGPath;
        } else {
            [completionBezierPath applyTransform:CGAffineTransformMakeTranslation((1 - self.completionFactor) * -CGRectGetWidth(self.layer.bounds),
                                                                                  1)];
            self.completionShapeLayer.path = completionBezierPath.CGPath;
        }
    }
    
    CGSize shadowShapeLayerShadowOffsetSize = CGSizeMake(0, 
                                                         CGRectGetHeight(self.layer.bounds) / 20);
    CGSize shadowShapeLayerFrameOffsetSize = shadowShapeLayerShadowOffsetSize;
    shadowShapeLayerFrameOffsetSize.width = 10;
    
    CGRect shadowShapeLayerOuterRect = CGRectInset(self.layer.bounds,
                                                   -shadowShapeLayerFrameOffsetSize.width,
                                                   -shadowShapeLayerFrameOffsetSize.height);
    UIBezierPath *shadowShapeLayerBezierPath = [UIBezierPath bezierPathWithRect:shadowShapeLayerOuterRect];      
    
    UIBezierPath *shadowShapeLayerInnerBezierPath = [maskBezierPath copy];
    [shadowShapeLayerInnerBezierPath applyTransform:CGAffineTransformMakeTranslation(-CGRectGetMidX(self.layer.bounds), 
                                                                                     -CGRectGetMidY(self.layer.bounds))];
    [shadowShapeLayerInnerBezierPath applyTransform:CGAffineTransformMakeScale(-1, 
                                                                               1)];
    [shadowShapeLayerInnerBezierPath applyTransform:CGAffineTransformMakeTranslation(CGRectGetMidX(self.layer.bounds), 
                                                                                     CGRectGetMidY(self.layer.bounds))];
    
    [shadowShapeLayerBezierPath appendPath:shadowShapeLayerInnerBezierPath];
    
    self.shadowShapeLayer.frame = CGRectOffset(shadowShapeLayerOuterRect, 
                                               shadowShapeLayerFrameOffsetSize.width, 
                                               shadowShapeLayerFrameOffsetSize.height);

    self.shadowShapeLayer.shadowOffset = shadowShapeLayerShadowOffsetSize;
    
    self.shadowShapeLayer.path = shadowShapeLayerBezierPath.CGPath;
}

#pragma mark - public API

- (void) setCompletionFactor:(CGFloat)completionFactor {
    if (_completionFactor != completionFactor) {
        _completionFactor = completionFactor;
        
        [self setNeedsLayout];
    }
}

@end
