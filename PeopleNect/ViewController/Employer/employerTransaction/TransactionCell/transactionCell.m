//
//  transactionCell.m
//  PeopleNect
//
//  Created by Narendra Pandey on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "transactionCell.h"

@implementation transactionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews
{
    _circularLbl.layer.cornerRadius = _circularLbl.layer.frame.size.height/2;
    _circularLbl.layer.masksToBounds = YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
