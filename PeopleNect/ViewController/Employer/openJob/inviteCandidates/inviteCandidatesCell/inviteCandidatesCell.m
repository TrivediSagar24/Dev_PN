//
//  inviteCandidatesCell.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/28/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "inviteCandidatesCell.h"

@implementation inviteCandidatesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_addSelected setImage:[UIImage imageNamed:@"Whiteplus_"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    _profilePic.layer.masksToBounds =  YES;
    _profilePic.layer.cornerRadius = _profilePic.layer.frame.size.height/2;
}
@end
