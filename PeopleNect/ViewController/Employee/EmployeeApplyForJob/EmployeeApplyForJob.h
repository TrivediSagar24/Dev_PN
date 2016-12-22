//
//  EmployeeApplyForJob.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/6/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"

@interface EmployeeApplyForJob : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *jobTitleCmpyLbl;
@property (strong, nonatomic) IBOutlet UILabel *ApplicationSentlbl;
@property (strong, nonatomic) IBOutlet UIImageView *rightSent;
@property (strong, nonatomic) IBOutlet UILabel *waitingLbl;
@property (strong, nonatomic) IBOutlet UILabel *waitingFeedback;
@property (strong, nonatomic) IBOutlet UIImageView *waitingImageView;
@property (strong, nonatomic) IBOutlet UILabel *waitingOneLbl;
@property (strong, nonatomic) IBOutlet UILabel *waitingTwoLbl;
@property (strong, nonatomic) IBOutlet UILabel *waitingThreeLbl;
@property (strong, nonatomic) IBOutlet UIImageView *feedbackImageView;
@property (strong, nonatomic) IBOutlet UIButton *searchAgainbtn;
@property (strong, nonatomic) IBOutlet UILabel *applicationLbl;
@property (strong, nonatomic) IBOutlet UILabel *applicationLblTwo;
@property (strong, nonatomic) IBOutlet UILabel *applicationLblThree;

@property(strong,nonatomic) NSString *jobTitle;
@property(strong,nonatomic) NSString *companyName;
@property(strong,nonatomic) NSString *applicationSent;
@property(strong,nonatomic) NSString *applicationWaiting;
@property(strong,nonatomic) NSString *applicationFeedback;
@property(strong,nonatomic)NSString *wait;
@property(strong,nonatomic)NSString *result;
- (IBAction)searchAgainClicked:(id)sender;

@end
