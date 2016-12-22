//
//  availabilityCell.m
//  PeopleNect
//
//  Created by Narendra Pandey on 16/11/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "availabilityCell.h"
#import "PN_Constants.h"
@implementation availabilityCell
-(void)layoutSubviews{
    _availabilityView.layer.borderColor = RGBCGCOLOR(92.0, 121.0, 159.0);
    _availabilityView.layer.borderWidth = 1.0;
    _availabilityView.layer.masksToBounds = YES;
    _availabilityView.layer.cornerRadius = 10.0;
}
@end
