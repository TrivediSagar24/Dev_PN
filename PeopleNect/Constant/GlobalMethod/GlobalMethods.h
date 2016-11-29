//
//  GlobalMethods.h
//  PeopleNect
//
//  Created by Apple on 29/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "SplashEmployerCtr.h"
#import "ViewController.h"
#import "MenuCtr.h"
#import "PN_Constants.h"
#import "Reachability.h"

@interface GlobalMethods : NSObject

+(UIBarButtonItem *)customNavigationBarButton:(SEL)selector Target:(UIViewController *)targetView Image:(NSString *)imageName;

+ (BOOL)validateEmailWithString:(NSString*)email;
+(UIAlertController *)AlertWithTitle:(NSString*)Title Message:(NSString *)Message AlertMessage:(NSString*)AlertMessage;

+(NSDictionary *)EmployeeRegisterWith:(NSString *)registerWith Email:(NSString *)Email Name:(NSString *)Name Surname:(NSString *)Surname Password :(NSString *)password Phone:(NSString *)phone DevideId:(NSString *)deviceId Access_Token:(NSString *)access_token Access_identifire:(NSString *)Access_identifire ZipCode:(NSString *)zipcode StreetName :(NSString *)streetName StreetNumber :(NSString *)StreetNumber countryCode :(NSString *)CountryCode;

+(MBProgressHUD *)ShowProgressHud :(UIView *)view;


+(NSDictionary*)EmployeeLoginWithEmail :(NSString*)Email Password:(NSString*)Password DeviceId:(NSString *)deviceId;

+(NSDictionary *)EmployeeSaveUserDetail:(NSString *)userId firstname:(NSString *)firstname lastName:(NSString *)lastName phone:(NSString *)PhoneNo categoryId :(NSString *)categoryId subCategoryId:(NSString *)subCategoryId experience:(NSString *)experience rate:(NSString *)rate description:(NSString *)description password:(NSString *)password zipcode :(NSString *)zipcode streetName :(NSString *)streetName number :(NSString *)number country_code :(NSString *)country_code;


+(NSDictionary *)EmployerRegister:(NSString *)deviceId email:(NSString *)email name:(NSString*)name password:(NSString *)Password phone :(NSString*)phone surname: (NSString *)surname countryCode :(NSString*)CountryCode;

+(NSDictionary*)UpdateEmployerWithID:(NSString*)EmployerId cityID:(NSString*)cityID companyName :(NSString *)CompanyName Name:(NSString*)Name Phone:(NSString*)Phone StateID:(NSString*)StateID Surname:(NSString*)Surname zipCode :(NSString*)zipCode countryCode:(NSString *)countryCode Streetname:(NSString*)StreetName Password:(NSString*)Password Adress1:(NSString*)Address1 Address2:(NSString*)Address2 countryID:(NSString*)countryID;

+(BOOL)InternetAvailability;

+(NSMutableArray *)SortArray : (NSMutableArray *)arrOriginal;


+(void)dataTaskCancel;
@end
