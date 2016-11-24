//
//  postedJobCell.h
//  PeopleNect
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface postedJobCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *postJobView;
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *jobPriceLbl;
@property (strong, nonatomic) IBOutlet UIImageView *closeImagView;
@property (strong, nonatomic) IBOutlet UILabel *inviteLbl;
@property (strong, nonatomic) IBOutlet UIImageView *rightArrowImg;
@property (strong, nonatomic) IBOutlet UILabel *whiteBorderLbl;

@end
