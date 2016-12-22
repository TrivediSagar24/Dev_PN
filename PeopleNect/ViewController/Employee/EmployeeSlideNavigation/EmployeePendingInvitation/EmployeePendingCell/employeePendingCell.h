//
//  employeePendingCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/6/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface employeePendingCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *pendingmainView;
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *lblKm;
@property (strong, nonatomic) IBOutlet UILabel *StartDateKLbl;
@property (strong, nonatomic) IBOutlet UILabel *lblRatings;
@property (strong, nonatomic) IBOutlet UILabel *jobDescriptionLbl;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
- (IBAction)AcceptBtnClicked:(id)sender;
- (IBAction)refuseBtnClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *acceptBtn;
@property (strong, nonatomic) IBOutlet UIButton *refuseBtn;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalHour;
@end
