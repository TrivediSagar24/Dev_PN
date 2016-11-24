//
//  OpenJobCandidatesCell.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/27/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenJobCandidatesCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *employerName;
@property (strong, nonatomic) IBOutlet UILabel *categoryLbl;
@property (strong, nonatomic) IBOutlet UILabel *experienceLbl;
@property (strong, nonatomic) IBOutlet UILabel *distanceLbl;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *acceptrefuseViewWidth;
@property (strong, nonatomic) IBOutlet UILabel *xrejectedLbl;
@property (strong, nonatomic) IBOutlet UILabel *rejectedLbl;
@property (strong, nonatomic) IBOutlet UIImageView *rejectedImage;
@property (strong, nonatomic) IBOutlet UIImageView *ratingImage;
@property (strong, nonatomic) IBOutlet UILabel *ratingLbl;
@property (strong, nonatomic) IBOutlet UILabel *AcceptedLbl;
@property (strong, nonatomic) IBOutlet UIImageView *multiplyImage;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImage;
@property (strong, nonatomic) IBOutlet UIView *acceptRefuseView;
@property (strong, nonatomic) IBOutlet UIButton *hiredBtn;
@property (strong, nonatomic) IBOutlet UIButton *acceptBtn;
@property (strong, nonatomic) IBOutlet UIButton *refuseBtn;

@end
