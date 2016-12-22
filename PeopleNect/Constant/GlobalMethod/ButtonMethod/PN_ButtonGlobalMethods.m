//
//  PN_ButtonGlobalMethods.m
//  PeopleNect
//
//  Created by Narendra Pandey on 8/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "PN_ButtonGlobalMethods.h"

@implementation PN_ButtonGlobalMethods

-(void)awakeFromNib{
    _borderLayer = [CALayer layer];
    _borderLayer.backgroundColor = self.borderColor.CGColor;
    [self.layer addSublayer:_borderLayer];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _borderLayer.frame = CGRectMake(0.0f, self.frame.size.height - 1, self.layer.frame.size.width, 1.0f);
}


@end
