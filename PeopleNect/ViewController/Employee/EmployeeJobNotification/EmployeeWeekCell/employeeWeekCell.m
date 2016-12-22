//
//  employeeWeekCell.m
//  PeopleNect
//
//  Created by Narendra Pandey on 8/26/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeWeekCell.h"

@implementation employeeWeekCell

-(void)layoutSubviews
{
   _WeekNameView.layer.borderColor = [UIColor colorWithRed:92.0/255.0 green:121.0/255.0 blue:159.0/255.0 alpha:1.0].CGColor;
   _WeekNameView.layer.borderWidth = 1.0;
    _WeekNameView.layer.masksToBounds = YES;
   _WeekNameView.layer.cornerRadius = 10.0;
}
@end
