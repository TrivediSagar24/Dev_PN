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

-(void)awakeFromNib{
    _availabilityView.layer.borderColor = RGBCGCOLOR(92.0, 121.0, 159.0);
    _availabilityView.layer.borderWidth = 1.0;
    _availabilityView.layer.masksToBounds = YES;
    
    if IS_IPHONE_4
        _availabilityView.layer.cornerRadius = 10;
    else
        _availabilityView.layer.cornerRadius = 10;
}
-(void)layoutSubviews{
      // _availabilityView.layer.cornerRadius = (self.frame.size.width*10)/414;

}
@end
