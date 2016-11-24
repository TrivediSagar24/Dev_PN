//
//  employeeJobNotification.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "searchTableViewCell.h"
#import "PN_ButtonGlobalMethods.h"
@import GoogleMaps;
#import "SlideNavigationController.h"
#import "employeeSlideNavigation.h"
#import "employeeWeeKCell.h"
#import "CERangeSlider.h"
#import "EmployeeApplyForJob.h"
#import "employeeChangeLoc.h"
#import "employeeRatings.h"
#import "employeeChat.h"
#import "gotInvitation.h"
#import "JSCustomBadge.h"

@interface employeeJobNotification : UIViewController<UITableViewDataSource,UITableViewDelegate,GMSMapViewDelegate ,CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIView *ButtonSectionView;
@property(nonatomic,strong) IBOutlet NSLayoutConstraint *heightforTableCategoryView;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (strong, nonatomic) IBOutlet PN_ButtonGlobalMethods *btnAll;
@property (strong, nonatomic) IBOutlet PN_ButtonGlobalMethods *btnInMyArea;
@property (strong, nonatomic) IBOutlet UILabel *lblJobCategoryInfo;
@property (strong, nonatomic) IBOutlet UIView *TopAvailabilityView;
@property (strong, nonatomic) IBOutlet UILabel *btnAllBorder;
@property (strong,nonatomic) NSString *UserCategory;
@property (strong, nonatomic) IBOutlet UILabel *btnAreaBorder;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property(strong,nonatomic) NSMutableArray *totalJobs;
@property(strong,nonatomic) UIButton *switchSelected;
@property(strong,nonatomic)UIButton *chatSelected;
@property (strong, nonatomic) IBOutlet UIView *EmployeeAvailabilityView;
@property (strong, nonatomic) IBOutlet UIView *FreeView;
@property (strong, nonatomic) IBOutlet UIView *settinOptionalView;
@property (strong, nonatomic) IBOutlet UIButton *freeButton;
@property (strong, nonatomic) IBOutlet UIButton *btn_AdvanceOption;
@property (strong, nonatomic) IBOutlet UIView *settingWeekView;
@property (strong, nonatomic) IBOutlet UICollectionView *employeeWeekCollection;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *TopFreelbl;
@property (strong, nonatomic) IBOutlet UILabel *TurnOnLable;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *bottomFreelbl;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *TopFreeView;
@property (strong, nonatomic) IBOutlet UIView *ProgressSaveEmployeeView;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *TopstartTimeLbl;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *TopEndTimelbl;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *HeightstartTimeLbl;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *HeightEndTimelbl;
@property (strong, nonatomic) IBOutlet UILabel *lblProgressWeekNames;
@property (strong, nonatomic) IBOutlet UIView *viewAdvanceOptions;
@property (strong, nonatomic) IBOutlet UILabel *startTimeOnelbl;
@property (strong, nonatomic) IBOutlet UILabel *endTimeTwlvLbl;
@property (strong, nonatomic) IBOutlet UIButton *changeLocationBtn;
@property(strong,nonatomic)  JSCustomBadge *chatBadge;
@property (strong, nonatomic) IBOutlet UILabel *availableLbl;

- (IBAction)btnAllClikced:(id)sender;
- (IBAction)btnInMyAreaClicked:(id)sender;
- (IBAction)advancedOptionClicked:(id)sender;
- (IBAction)freeButtonClicked:(id)sender;
- (IBAction)settingCloseClicked:(id)sender;
- (IBAction)btnSaveProgressClicked:(id)sender;
- (IBAction)changeLocationClicked:(id)sender;
- (IBAction)closedAvailabilityClicked:(id)sender;

@end
