//
//  employeeSlideNavigation.h
//  PeopleNect
//
//  Created by Narendra Pandey on 8/11/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PN_Constants.h"
#import "GlobalMethods.h"
#import "employeeJobNotification.h"
#import "EmployeeSettings.h"
#import "employeePendingInvitation.h"
#import "employeeJobHistory.h"
#import "employeeRevenues.h"
#import "MenuCtr.h"
#import "employerTransaction.h"
#import "employerSettings.h"
#import "CategoryEmployeeCtr.h"
#import "SplashEmployerCtr.h"
#import "openJob.h"
#import "onGoingJobs.h"
#import "EmployerJobHistory.h"

@interface employeeSlideNavigation : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *ProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblUserCategory;
@property (strong, nonatomic) IBOutlet UILabel *lblUserExperience;
@property (strong, nonatomic) IBOutlet UITableView *userSettingTable;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *rightButtonTrailing;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *imageTrailing;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@property (strong, nonatomic) IBOutlet UILabel *LableBorder;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UIView *MiddleView;
@property (strong, nonatomic) IBOutlet UIView *BotomView;
@property (strong, nonatomic) IBOutlet UIView *ExitView;
@property(strong,nonatomic) NSMutableArray *openJobInfo;

- (IBAction)ExitClicked:(id)sender;
- (IBAction)RightNavigateClikced:(id)sender;
- (IBAction)SearchJobClicked:(id)sender;

@end
