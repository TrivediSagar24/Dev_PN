//
//  CERangeSlider.m
//  CERangeSlider
//
//  Created by Colin Eberhardt on 22/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "CERangeSlider.h"
#import <QuartzCore/QuartzCore.h>
#import "CERangeSliderKnobLayer.h"
#import "CERangeSliderTrackLayer.h"

@implementation CERangeSlider
{
    CERangeSliderTrackLayer* _trackLayer;
    CERangeSliderKnobLayer* _upperKnobLayer;
    CERangeSliderKnobLayer* _lowerKnobLayer;
    
    float _knobWidth;
    float _useableTrackLength;
    
    CGPoint _previousTouchPoint;
}

#define GENERATE_SETTER(PROPERTY, TYPE, SETTER, UPDATER) \
@synthesize PROPERTY = _##PROPERTY; \
\
- (void)SETTER:(TYPE)PROPERTY { \
    if (_##PROPERTY != PROPERTY) { \
        _##PROPERTY = PROPERTY; \
        [self UPDATER]; \
    } \
}

GENERATE_SETTER(trackHighlightColour, UIColor*, setTrackHighlightColour, redrawLayers)

GENERATE_SETTER(trackColour, UIColor*, setTrackColour, redrawLayers)

GENERATE_SETTER(curvatiousness, float, setCurvatiousness, redrawLayers)

GENERATE_SETTER(knobColour, UIColor*, setKnobColour, redrawLayers)

GENERATE_SETTER(maximumValue, float, setMaximumValue, setLayerFrames)

GENERATE_SETTER(minimumValue, float, setMinimumValue, setLayerFrames)

GENERATE_SETTER(lowerValue, float, setLowerValue, setLayerFrames)

GENERATE_SETTER(upperValue, float, setUpperValue, setLayerFrames)

- (void) redrawLayers
{
    [_upperKnobLayer setNeedsDisplay];
    [_lowerKnobLayer setNeedsDisplay];
    [_trackLayer setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _trackHighlightColour = [UIColor colorWithRed:44.0/255.0 green:96.0/255.0 blue:144.0/255.0 alpha:1.0];
        
         _trackColour = [ UIColor colorWithRed:167.0/255.0 green:167.0/255.0 blue:167.0/255.0 alpha:1.0];
        
        _trackColour = [ UIColor redColor];
        
        _knobColour = [UIColor colorWithRed:44.0/255.0 green:96.0/255.0 blue:144.0/255.0 alpha:1.0];

        _curvatiousness = 1.0;
        
        _maximumValue = 24;
        
        _minimumValue = 0;
        
        // Initialization code
        
        _maximumValue = 24;
        _minimumValue = 0;
        
        
        _upperValue = 24;
        _lowerValue = 0;
        
        _trackLayer = [CERangeSliderTrackLayer layer];
        
        _trackLayer.slider = self;
        
        [self.layer addSublayer:_trackLayer];

        _upperKnobLayer = [CERangeSliderKnobLayer layer];
        _upperKnobLayer.slider = self;
        [self.layer addSublayer:_upperKnobLayer];

        _lowerKnobLayer = [CERangeSliderKnobLayer layer];
        _lowerKnobLayer.slider = self;
        [self.layer addSublayer:_lowerKnobLayer];
                                           
        [self setLayerFrames];
    }
    return self;
}
                                           
- (void) setLayerFrames
{
    _trackLayer.frame = CGRectInset(self.bounds, 0, self.bounds.size.height/3.5);
[_trackLayer setNeedsDisplay];

    _knobWidth = self.bounds.size.height;
    _useableTrackLength = self.bounds.size.width - _knobWidth;

    float upperKnobCentre = [self positionForValue:_upperValue];
    
    _upperKnobLayer.frame = CGRectMake(upperKnobCentre - _knobWidth / 2, 0, _knobWidth, _knobWidth);

    float lowerKnobCentre = [self positionForValue:_lowerValue];
    
    _lowerKnobLayer.frame = CGRectMake(lowerKnobCentre - _knobWidth / 2, 0, _knobWidth, _knobWidth);

    [_upperKnobLayer setNeedsDisplay];
    
    [_lowerKnobLayer setNeedsDisplay];
}
                                           
- (float) positionForValue:(float)value
{
    return _useableTrackLength * (value - _minimumValue) /
        (_maximumValue - _minimumValue) + (_knobWidth / 2);
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    _previousTouchPoint = [touch locationInView:self];
    
    // hit test the knob layer

    if(CGRectContainsPoint(_lowerKnobLayer.frame, _previousTouchPoint))
    {
        _lowerKnobLayer.highlighted = YES;
        
        _lowerTouchPoint = _previousTouchPoint;
        
        [_lowerKnobLayer setNeedsDisplay];
        
    }
    else if(CGRectContainsPoint(_upperKnobLayer.frame, _previousTouchPoint))
    {
        _upperKnobLayer.highlighted = YES;
        _upperTouchPoint = _previousTouchPoint;

        [_upperKnobLayer setNeedsDisplay];
    }
    return _upperKnobLayer.highlighted || _lowerKnobLayer.highlighted;
}

#define BOUND(VALUE, UPPER, LOWER)	MIN(MAX(VALUE, LOWER), UPPER)

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
     _touchPoint = [touch locationInView:self];
    
    // deterine by how much the user has dragged
    float delta = _touchPoint.x - _previousTouchPoint.x;
    float valueDelta = (_maximumValue - _minimumValue) * delta / _useableTrackLength;
    
    _previousTouchPoint = _touchPoint;
    
    // update the values
    if (_lowerKnobLayer.highlighted)
    {
        _lowerValue += valueDelta;
        
        _lowerTouchPointValue = _touchPoint;
        _lowerValue = BOUND(_lowerValue, _upperValue, _minimumValue);
    }
    if (_upperKnobLayer.highlighted)
    {
        _upperValue += valueDelta;
        _upperTouchPointValue = _touchPoint;
        _upperValue = BOUND(_upperValue, _maximumValue, _lowerValue);
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES] ;
    
    [self setLayerFrames];
    
    [CATransaction commit];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
 return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    _lowerKnobLayer.highlighted = _upperKnobLayer.highlighted = NO;
    [_lowerKnobLayer setNeedsDisplay];
    [_upperKnobLayer setNeedsDisplay];
}

@end
