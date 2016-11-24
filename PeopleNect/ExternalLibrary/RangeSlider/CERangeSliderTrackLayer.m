//
//  CERangeSliderTrackLayer.m
//  CERangeSlider
//
//  Created by Colin Eberhardt on 24/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "CERangeSliderTrackLayer.h"
#import "CERangeSlider.h"

@implementation CERangeSliderTrackLayer

- (void)drawInContext:(CGContextRef)ctx
{
    CGContextSetFillColorWithColor(ctx, self.slider.trackHighlightColour.CGColor);
    
    float lower = [self.slider positionForValue:self.slider.lowerValue];
    
    float upper = [self.slider positionForValue:self.slider.upperValue];
    
    CGContextFillRect(ctx, CGRectMake(lower, 0, upper - lower, self.bounds.size.height));
    
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:1.0 alpha:1].CGColor);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    CGContextSetLineWidth(ctx, 0.4);
    
    CGContextStrokePath(ctx);
}

@end
