//
//  employeeChatCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface employeeChatCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userDesc;
@property (strong, nonatomic) IBOutlet UILabel *chatTime;
@property (strong, nonatomic) IBOutlet UIImageView *checkedImg;

@end
