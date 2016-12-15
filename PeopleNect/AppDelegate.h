//
//  AppDelegate.h
//  PeopleNect
//
//  Created by Trivedi Sagar on 26/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <CoreMotion/CoreMotion.h>
#import "MBProgressHUD.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "employeeJobNotification.h"
#import "MenuCtr.h"
#import "responseDataOC.h"
#import "CategoryEmployeeCtr.h"
#import "EmployerSecondScreenCtr.h"
#import "ViewController.h"
#import "SplashEmployerCtr.h"
#import "GlobalMethods.h"
@import GooglePlaces;
#import <CoreData/CoreData.h>
#import "GlobalMethods.h"
#import "PayPalMobile.h"

static NSString * const kClientId = @"285378539209-tfajq8qi1s2pj56g6jpkmio1545itrrf.apps.googleusercontent.com";

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)NSString  *device_Token;
@property (strong, nonatomic)NSString  *EmployeeStreetName;
@property(strong,nonatomic)NSString *userSelectedStatus;
@property(strong,nonatomic)NSString *userInvitedStatus;
@property(strong,nonatomic)NSString *applicationStatus;
@property(strong,nonatomic)NSString *SelectedFollowUp;

@property(strong ,nonatomic)MBProgressHUD *progressHud;
@property(strong,nonatomic)  responseDataOC *obj_responseDataOC;
@property (strong,nonatomic) responseUpdateEmployerDetails *obj_responseDataUpdateEmployerDetails;
@property(strong,nonatomic)reponseGmailFacebookLogin *obj_reponseGmailFacebookLogin;
@property(strong,nonatomic)responseEmployeeUserDetail*obj_responseEmployeeUserDetail;
@property(strong,nonatomic)CountryCode *obj_CountryCode;
@property(strong,nonatomic)NSMutableDictionary *EmployeeSettingText;
@property(strong,nonatomic)EmployeeAreWiseJob *obj_EmployeeAreWiseJob;
@property(strong,nonatomic)EmployeeAllJob *obj_EmployeeAllJob;
@property(strong,nonatomic) UIImage *EmployeeProfileImage;
@property(strong,nonatomic) UIImage *EmployerProfileImage;
@property(strong,nonatomic)EmployeeCategory *obj_EmployeeCategory;
@property(strong,nonatomic) responseEmployeesList *obj_responseEmployeesList;
@property (strong,nonatomic) responseCategoryList *obj_responseCategoryList;
@property(strong,nonatomic) responseRegiserEmployee *obj_responseRegiserEmployee;
@property(strong,nonatomic)FinalRegisteredEmployee *obj_FinalRegisteredEmployee;
@property(strong,nonatomic)jobPostingPriceBalance *obj_jobPostingPriceBalance;
@property(strong,nonatomic)EmployerDetails *obj_EmployerDetails;
@property(strong,nonatomic)NSString *apnDeviceToken;
@property(strong,nonatomic)NSString *categorySelectionID;

@property(strong,nonatomic) NSMutableArray *subCategorymap;

@property(strong,nonatomic) NSMutableArray *subCategoryFromInvited;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic) int changeCount;

- (NSURL *)applicationDocumentsDirectory;
@end

