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

@property (nonatomic, strong) UIActivityIndicatorView *activity;

@property (nonatomic, strong) UIImageView *iconImage;

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

-(UIActivityIndicatorView *)activity {
    if ( !_activity ) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.hidesWhenStopped = YES;
        _activity.alpha = 0.0f;
        _activity.frame = CGRectMake(CGRectGetMidX(self.bounds) - _activity.frame.size.width / 2, CGRectGetMidY(self.bounds) - _activity.frame.size.height / 2, _activity.frame.size.width, _activity.frame.size.height);
    }
    return _activity;
}

#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame{
    
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
    [self addSubview:self.activity];
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



- (void)animate {
    
    CGFloat duration = 0.5;
    
    CATransform3D firstFrame;
    CATransform3D secondFrame;
    CATransform3D thirdFrame;
    CATransform3D fourthFrame;
    CATransform3D fifthFrame;
    
    if ( CATransform3DIsIdentity(self.shapeLayer.transform)) {
        firstFrame  = CATransform3DMakeScale(1.0f, 1.0f, 1.0);
        
        secondFrame = CATransform3DMakeScale(0.75f, 0.75f, 1.0); // halfway to 1.0 from 0.75
        secondFrame = CATransform3DRotate(secondFrame, M_PI_2, 0, 0, 1);
        
        thirdFrame = CATransform3DMakeScale(0.5f, 0.5f, 1.0); // halfway to 1.0 from 0.75
        thirdFrame= CATransform3DRotate(thirdFrame, M_PI, 0, 0, 1);
        
        fourthFrame = CATransform3DMakeScale(0.25f, 0.25f, 1.0); // halfway to 1.0 from 0.75
        fourthFrame = CATransform3DRotate(fourthFrame, M_PI_2 * 3, 0, 0, 1);
        
        fifthFrame = CATransform3DMakeScale(0.0f, 0.0f, 1.0); // halfway to 1.0 from 0.75
        fifthFrame = CATransform3DRotate(fifthFrame, 0, 0, 0, 1);
        
        [self.activity startAnimating];
        [UIView animateWithDuration:duration animations:^{
            self.activity.alpha = 1.0f;
        }];
        
        
    } else {
        firstFrame  = CATransform3DMakeScale(0.0f, 0.0f, 1.0);
        
        secondFrame = CATransform3DMakeScale(0.25f, 0.25f, 1.0); // halfway to 1.0 from 0.75
        secondFrame = CATransform3DRotate(secondFrame, M_PI_2, 0, 0, 1);
        
        thirdFrame = CATransform3DMakeScale(0.5f, 0.5f, 1.0); // halfway to 1.0 from 0.75
        thirdFrame= CATransform3DRotate(thirdFrame, M_PI, 0, 0, 1);
        
        fourthFrame = CATransform3DMakeScale(0.75f, 0.75f, 1.0); // halfway to 1.0 from 0.75
        fourthFrame = CATransform3DRotate(fourthFrame, M_PI_2 * 3, 0, 0, 1);
        
        fifthFrame = CATransform3DMakeScale(1.0f, 1.0f, 1.0); // halfway to 1.0 from 0.75
        fifthFrame = CATransform3DRotate(fifthFrame, 0, 0, 0, 1);
        

        [UIView animateWithDuration:duration animations:^{
            self.activity.alpha = 0.0f;
        }];

        
    }
    
    CAKeyframeAnimation *scaleAndRotate = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAndRotate.values = @[[NSValue valueWithCATransform3D:firstFrame],
                              [NSValue valueWithCATransform3D:secondFrame],
                              [NSValue valueWithCATransform3D:thirdFrame],
                              [NSValue valueWithCATransform3D:fourthFrame],
                              [NSValue valueWithCATransform3D:fifthFrame]];
    scaleAndRotate.duration = duration;
    scaleAndRotate.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    scaleAndRotate.delegate = self;
    scaleAndRotate.removedOnCompletion = NO;
    scaleAndRotate.fillMode = kCAFillModeForwards;
    
    [self.shapeLayer addAnimation:scaleAndRotate forKey:@"entire animation"];
    
    return;
    
    // Other animations and experiments
    
    
    duration = 1.0f;

    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.values = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat: [[self.shapeLayer valueForKeyPath:@"transform.rotation.z"] floatValue]],
                            [NSNumber numberWithFloat:M_PI * 2],
                            nil];
    animation.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:duration], nil];
    
    animation.timingFunctions = [NSArray arrayWithObjects:
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    

    
    CAKeyframeAnimation *scaleAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnim.removedOnCompletion = NO;
    scaleAnim.fillMode = kCAFillModeForwards;
    scaleAnim.removedOnCompletion = NO;
    scaleAnim.fillMode = kCAFillModeForwards;

    
    scaleAnim.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat: 1.0f],
                        [NSNumber numberWithFloat:0.0f],
                        nil];
    scaleAnim.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:duration], nil];
    
    scaleAnim.timingFunctions = [NSArray arrayWithObjects:
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[animation, scaleAnim];
    animationGroup.duration = duration;
    
    [self.shapeLayer addAnimation:animationGroup forKey:@"Group"];
    self.shapeLayer.transform = CATransform3DIdentity;
    
    return;
    
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
    
    
    
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
//    [self.shapeLayer removeFromSuperlayer];
    if ( CATransform3DIsIdentity(self.shapeLayer.transform)) {
        CATransform3D lastFrame = CATransform3DMakeScale(0.0f, 0.0f, 1.0); // halfway to 1.0 from 0.75
        lastFrame = CATransform3DRotate(lastFrame, M_PI, 0, 0, 1);
        self.shapeLayer.transform = lastFrame;
    } else {
        self.shapeLayer.transform = CATransform3DIdentity;
    }
    
}


@end
