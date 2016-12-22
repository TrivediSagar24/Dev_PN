//
//  inviteCandidatesCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/28/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface inviteCandidatesCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *EmployerName;
@property (strong, nonatomic) IBOutlet UILabel *categoryLbl;
@property (strong, nonatomic) IBOutlet UILabel *expLbl;
@property (strong, nonatomic) IBOutlet UILabel *distanceLbl;
@property (strong, nonatomic) IBOutlet UILabel *ratingLbl;
@property (strong, nonatomic) IBOutlet UIButton *addSelected;

@end
