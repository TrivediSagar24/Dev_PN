//
//  employeeChatCell.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeChatCell.h"

@implementation employeeChatCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(void)layoutSubviews{
    [super layoutSubviews];
    _profilePic.layer.cornerRadius = _profilePic.frame.size.height/2;
    _profilePic.layer.masksToBounds = YES;
//    _checkedImg.hidden = YES;
}
@end
