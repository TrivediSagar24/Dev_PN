//
//  UserSettingCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 8/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSCustomBadge.h"
@interface UserSettingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *SettingTypelbl;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *ArrowLeading;
@property(strong,nonatomic)  JSCustomBadge  *userSettingsBadge;

@end
