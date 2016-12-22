//
//  OpenJobCandidatesCell.m
//  PeopleNect
//
//  Created by Narendra Pandey on 9/27/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "OpenJobCandidatesCell.h"

@implementation OpenJobCandidatesCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _employerName.adjustsFontSizeToFitWidth = TRUE;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    _profilePic.layer.masksToBounds = YES;
    _profilePic.layer.cornerRadius = _profilePic.layer.frame.size.height/2;

    _acceptrefuseViewWidth.constant = _refuseBtn.frame.origin.x + _refuseBtn.frame.size.width;
    
}

@end
