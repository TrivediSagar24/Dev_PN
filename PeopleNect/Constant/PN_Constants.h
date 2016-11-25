//
//  PN_Constants.h
//  PeopleNect
//
//  Created by Trivedi Sagar on 26/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "AFAPIClient.h"
#import "AppDelegate.h"


#define kAFClient [AFAPIClient sharedClient]

#define MAIN_URL @"http://peoplenect.inexture.com/webservice"
#define InternetAvailbility @"Internet is not Available."
#define MAIN_URL_DOMAIN @""
#define IS_DEBUG 1
#define APP_NAME @""
#define APP_STORE_ID @""
#define APP_URL @""

#define kAppDel ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define WebSite_URL @""

#define SYSTEM_SCREEN_SIZE [[UIScreen mainScreen] bounds].size

#define IPHONE5_WIDTH  320
#define IPHONE5_HEIGHT 568
#define kDEV_PROPROTIONAL_Height(val) ([UIScreen mainScreen].bounds.size.height / IPHONE5_HEIGHT * val)
#define kDEV_PROPROTIONAL_Width(val) ([UIScreen mainScreen].bounds.size.width / IPHONE5_WIDTH * val)

#define IPHONE6_PLUS_WIDTH  414
#define IPHONE6_PLUS_HEIGHT 736
#define kDEV_PROPROTIONAL_FONTS(val) ([UIScreen mainScreen].bounds.size.width / IPHONE6_PLUS_WIDTH * val)


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f || [[UIScreen mainScreen] bounds].size.width == 568.0f)

#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f || [[UIScreen mainScreen] bounds].size.width == 480.0f)


#define IS_RETINA ([[UIScreen mainScreen] scale] == 2.0f)

//#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 2.0f)

#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f || [[UIScreen mainScreen] bounds].size.width == 667.0f)
#define IS_IPHONE_6_Plus (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f || [[UIScreen mainScreen] bounds].size.width == 736.0f)

#define ipadFrame CGRectMake(0, 0, 768, 1024)
#define iphoneFrame (IS_IPHONE_5) ? CGRectMake(0, 0, 320, 568) :  CGRectMake(0, 0, 320, 480)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/*----- RGB Color -----*/
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define RGBCGCOLOR(r,g,b) [[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f] CGColor]


/*----- Font -----*/
#define FONT(fontname,fontsize)             [UIFont fontWithName:fontname size:fontsize]
#define Museo_700(fontsize)  [UIFont fontWithName:@"Museo-700" size:fontsize]


/*----- Webservice Default Paramater -----*/
#define kTimeOutInterval 300
#define kURLGet @"GET"
#define kURLPost @"POST"

#define NSStringFromInteger(value) [NSString stringWithFormat:@"%ld",(long)value]
#define NSStringFromFloat(value)   [NSString stringWithFormat:@"%f",value]
#define UIImageNamed(imageName)   [UIImage imageNamed:imageName]
#define URLString(str) [NSURL URLWithString:str]

/*----- Webservice Methods -----*/

#define kAFClient [AFAPIClient sharedClient]


/*----- Webservice Method Name -----*/
#define Login                   MAIN_URL@"login"
#define SignUp                  MAIN_URL@"signup"



/*----- Check iOS Version -----*/
#define iOS_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define iOS_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define iOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define iOS_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define iOS_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/*----- NSUserDefaults -----*/
#define kUser_Detail @"OH_UserDetail"
#define kUser_ID @"OH_UserID"

/*----- constant value -----*/
#define minimumPasswordLength 8
#define maximumPasswordLength 20

#define maxPhoneNoLength 10



#define Not_CorrectFormate @"Sorry, response is not in readable formate"

/*----- social sharing keys/secrets ------*/
/*----- google plus ------*/
#define GPP_Client_ID           @""
#define GTLAuthScopePlusLogin   @""


/*----- linkedin ------*/
#define Linkedin_Client_ID      @""
#define Linkedin_Client_Secret  @""
#define Linkedin_Callback_URL   @""

/*--- DeviceID ----*/
#define DevideID [[[UIDevice currentDevice]identifierForVendor]UUIDString]