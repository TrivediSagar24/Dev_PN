//
//  inviteCandidates.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/27/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "openJobSelected.h"
#import "inviteCandidatesCell.h"
#import "UIImageView+WebCache.h"
#import "noBalance.h"

@interface inviteCandidates : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *availableCandidatesLbl;
@property (strong, nonatomic) IBOutlet UITableView *availableTableView;
@property (strong, nonatomic) IBOutlet UIButton *allBtn;
@property (strong, nonatomic) IBOutlet UIImageView *allBtnArrowimg;
@property (strong, nonatomic) IBOutlet UIButton *favouriteBtn;
@property (strong, nonatomic) IBOutlet UIImageView *favouriteBtnArrowimg;
@property (strong, nonatomic)NSString *jobId;
@property (strong, nonatomic)NSString *jobTitle;
@property (nonatomic)int jobPostingPrice;
@property (nonatomic)int jobInvitationPrice;
@property (nonatomic)int TotalBalance;
@property (nonatomic)int jobInvitationFavouritePrice;
@property (strong, nonatomic)NSMutableArray *allEmployeeArray;
@property (strong, nonatomic)NSMutableArray *hotEmployeeArray;
@property (strong, nonatomic) IBOutlet UILabel *inviteTopLbl;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightForAvailableTable;
@property (strong, nonatomic) IBOutlet UIView *bottomView;

- (IBAction)allBtnClicked:(id)sender;
- (IBAction)favouriteBtnClicked:(id)sender;
- (IBAction)inviteCandidate:(id)sender;

@end
