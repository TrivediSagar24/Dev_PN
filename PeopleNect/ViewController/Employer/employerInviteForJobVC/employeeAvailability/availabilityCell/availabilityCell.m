//
//  availabilityCell.m
//  PeopleNect
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "availabilityCell.h"

@implementation availabilityCell
-(void)layoutSubviews
{
    _availabilityView.layer.borderColor = [UIColor colorWithRed:92.0/255.0 green:121.0/255.0 blue:159.0/255.0 alpha:1.0].CGColor;
    _availabilityView.layer.borderWidth = 1.0;
    _availabilityView.layer.masksToBounds = YES;
    _availabilityView.layer.cornerRadius = 10.0;
}
@end
