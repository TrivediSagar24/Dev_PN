//
//  seeDetailsNotification.h
//  PeopleNect
//
//  Created by Apple on 07/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "localNotification.h"
#import "GlobalMethods.h"
#import "PN_Constants.h"
@import EventKit;
@import EventKitUI;

@interface seeDetailsNotification : UIViewController
<EKEventEditViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *likeStarImg;
@property (strong, nonatomic) IBOutlet UILabel *selectedLbl;
@property (strong, nonatomic) IBOutlet UILabel *totalHourLbl;
@property (strong, nonatomic) IBOutlet UILabel *priceHourLbl;
@property (strong, nonatomic) IBOutlet UIImageView *dolarImg;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLbl;

@property (strong, nonatomic) IBOutlet UIImageView *clockImg;
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *bottomJobPriceLbl;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *distanceLbl;
@property (strong, nonatomic) IBOutlet UILabel *bottomDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *bottomRatingLbl;
@property (strong, nonatomic) IBOutlet UIImageView *starImg;
@property (strong, nonatomic) IBOutlet UILabel *jobDescriptionLbl;
@property(strong,nonatomic)NSString *jobId;
@property (strong, nonatomic) IBOutlet UIImageView *mapWhiteLbl;
@property (strong, nonatomic) IBOutlet UILabel *bottomAddressLbl;
@property(strong,nonatomic)NSString *bottomAddress;
@property(strong,nonatomic)NSString *jobDescription;
@property(strong,nonatomic)NSString *ratings;
@property (strong, nonatomic) IBOutlet UIView *seeDetailsView;
@property(nonatomic)CLLocationCoordinate2D location;


- (IBAction)ScheduleClicked:(id)sender;
- (IBAction)CloseClicked:(id)sender;

@end
