//
//  UserSettingCell.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "UserSettingCell.h"

@implementation UserSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _userSettingsBadge = [JSCustomBadge customBadgeWithString:@"" withStringColor:[UIColor redColor] withInsetColor:[UIColor redColor] withBadgeFrame:NO withBadgeFrameColor:[UIColor blueColor] withScale:1.0 withShining:NO withShadow:NO];
    [self.contentView addSubview:_userSettingsBadge];
    _userSettingsBadge.hidden = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    if ([[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"].length>0) {
          self.ArrowLeading.constant = (self.contentView.frame.size.width*50)/414;
        _userSettingsBadge.frame = CGRectMake(_SettingTypelbl.frame.origin.x-3+_SettingTypelbl.frame.size.width,_SettingTypelbl.frame.origin.y, 20, 20);
          }
   else
    self.ArrowLeading.constant = (self.contentView.frame.size.width*40)/414;
}
@end
