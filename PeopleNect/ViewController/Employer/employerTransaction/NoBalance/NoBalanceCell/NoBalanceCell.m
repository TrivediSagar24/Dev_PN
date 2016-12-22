//
//  NoBalanceCell.m
//  PeopleNect
//
//  Created by Narendra Pandey on 30/09/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "NoBalanceCell.h"

@implementation NoBalanceCell

-(void)layoutSubviews
{
    _packageView.layer.borderWidth = 2;
    _packageView.layer.borderColor = [UIColor colorWithRed:101.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0].CGColor;
}
@end
