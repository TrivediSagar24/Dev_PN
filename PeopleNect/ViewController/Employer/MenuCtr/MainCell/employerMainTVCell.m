//
//  employerMainTVCell.m
//  PeopleNect
//
//  Created by Narendra Pandey on 29/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employerMainTVCell.h"

@implementation employerMainTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews ];
    self.imgVwMainTVCell.layer.cornerRadius  = self.imgVwMainTVCell.frame.size.height/2;
    self.imgVwMainTVCell.layer.masksToBounds = YES;
}
@end
