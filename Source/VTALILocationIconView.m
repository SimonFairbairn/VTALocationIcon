//
//  VTALILocationIconView.m
//  VTALocationIcon
//
//  Created by Simon Fairbairn on 30/09/2013.
//  Copyright (c) 2013 Simon Fairbairn. All rights reserved.
//

#import "VTALILocationIconView.h"

const CGFloat offset = 5.0f;

@interface VTALILocationIconView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic) BOOL isCircle;


@end

@implementation VTALILocationIconView


#pragma mark - Properties

-(CAShapeLayer *)shapeLayer {
    if ( !_shapeLayer ) {
        _shapeLayer = [CAShapeLayer layer];
        
        _shapeLayer.frame = self.bounds;

        _shapeLayer.path = [[self drawTriangle] CGPath];

        _shapeLayer.fillColor = self.tintColor.CGColor;
        _shapeLayer.lineWidth = 1.0f;
        _shapeLayer.lineJoin = kCALineJoinBevel;
    }
    return _shapeLayer;
}

#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if ( self ) {
        [self setup];
    }
    return self;
}

-(void)setup {
    [self.layer addSublayer:self.shapeLayer];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    
//    CGContextAddPath(ctx, [self drawTriangle].CGPath);
//
//}

- (UIBezierPath *)drawTriangle {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    
    CGFloat twoThirdsDown = floor(CGRectGetMidY(self.bounds) );
    CGFloat twoThirdsAcross = floor( CGRectGetMidX(self.bounds) );
    
    [path moveToPoint:CGPointMake(offset, twoThirdsDown)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width - offset, offset)];
    [path addLineToPoint:CGPointMake(twoThirdsAcross, self.bounds.size.height - offset)];
    
    // Calculate hypotenuse
    //    CGFloat x =  pow((( self.bounds.size.height / 2 ) - offset), 2);
    //    CGFloat y =  pow((( self.bounds.size.width / 2 ) - offset), 2);
    //    CGFloat pos = sqrt(x + y) / 2;
    
    //    CGFloat x = offset + 10;
    //    CGFloat y = (self.bounds.size.height - offset) - 10;
    
    [path addLineToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)];
    [path closePath];

    
//    self.shapeLayer.path = [self drawTriangle].CGPath;
    return path;
}

- (UIBezierPath *)drawCircle {
    
    CGRect newBounds = CGRectInset(self.bounds, offset, offset);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:newBounds];
    
    
    
    //    self.shapeLayer.path = [self drawTriangle].CGPath;
    return path;
}



- (void)animate
{
    
    if ( self.isCircle ) {
        CABasicAnimation *morph = [CABasicAnimation animationWithKeyPath:@"path"];
        morph.duration = 0.5;
        morph.fromValue = (id) self.shapeLayer.path;
        morph.toValue = (id) [self drawTriangle].CGPath;
        [self.shapeLayer addAnimation:morph forKey:nil];
        self.shapeLayer.path = [self drawTriangle].CGPath;
        self.isCircle = NO;
        
    } else {
        CABasicAnimation *morph = [CABasicAnimation animationWithKeyPath:@"path"];
        morph.duration = 0.5;
        morph.fromValue = (id) self.shapeLayer.path;
        morph.toValue = (id) [self drawCircle].CGPath;
        [self.shapeLayer addAnimation:morph forKey:nil];
        self.shapeLayer.path = [self drawCircle].CGPath;
        self.isCircle = YES;
    }
    
    
//    CATransform3D finalPosition = CATransform3DMakeScale(0.1, 0.1, 1.0);
//    
//    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    scaleAnim.toValue = [NSValue valueWithCATransform3D:finalPosition];
//    scaleAnim.removedOnCompletion = YES;
//    scaleAnim.duration = 0.3;
//    scaleAnim.delegate = self;
//    scaleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    
//    
//    [self.shapeLayer addAnimation:scaleAnim forKey:nil];
//    self.shapeLayer.transform = finalPosition;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
//    [self.shapeLayer removeFromSuperlayer];


    
    
}


@end
