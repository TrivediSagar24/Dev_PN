//
//  openJobSelected.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/26/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "openJob.h"
#import "FZAccordionTableView.h"
#import "AccordionHeaderView.h"
#import "OpenJobCandidatesCell.h"
#import "UIImageView+WebCache.h"
#import "inviteCandidates.h"
#import "noBalance.h"

static NSString *const kTableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";

@interface openJobSelected : UIViewController
<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnInvites;
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIButton *btnCandidates;
@property (strong, nonatomic) IBOutlet UILabel *lblInvites;
@property (strong, nonatomic) IBOutlet UIImageView *inviteImag;
@property (strong, nonatomic) IBOutlet UIImageView *candidatesImage;
@property (strong, nonatomic)NSString *jobId;
@property (strong, nonatomic)NSString *jobTitle;
@property (strong, nonatomic)NSString *jobPrice;
@property (strong, nonatomic) NSArray *CandidateArrayOptions;
@property (strong, nonatomic) NSMutableArray *selectedArray;
@property (strong, nonatomic) NSMutableArray *hiredArray;
@property (strong, nonatomic) NSMutableArray *applicantArray;
@property (strong, nonatomic) NSMutableArray *rejectedArray;
@property (strong, nonatomic) IBOutlet FZAccordionTableView *candidatesTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *postJobViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong, nonatomic) IBOutlet UIView *postJobView;

- (IBAction)postJobClicked:(id)sender;

- (IBAction)btnCandidatesClicked:(id)sender;
- (IBAction)btnInvitesClicked:(id)sender;
@end
