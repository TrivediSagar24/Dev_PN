//
//  AppDelegate.m
//  PeopleNect
//
//  Created by Trivedi Sagar on 26/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//


#import "AppDelegate.h"
#import "SlideNavigationController.h"
#import "employeeSlideNavigation.h"
@import GoogleMaps;
@interface AppDelegate ()
{
    UIStoryboard *mainStoryboard;
    NSData *dataLogin;
}
@end
@implementation AppDelegate
BOOL employerLogin, employeeLogin;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
#pragma mark - LifeCycle -
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"",
                                                        PayPalEnvironmentSandbox : @"AYEzBeYksFb3Nf_xnHBeX2I2W4gj4WJkFQwQnEUBW31F-p3Ui4jfILBMjoLsz8e0azcCWDBLxX1ZcUQJ"
}];
    

    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];

//    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//    }
    
    /*------- Google Sign In -------------------*/

    [GMSServices provideAPIKey:@"AIzaSyB9U-Ssv6A9Tt2keQtZyWMuadHoELYeGlk"];
    
//    AIzaSyB9U-Ssv6A9Tt2keQtZyWMuadHoELYeGlk
    
    [GMSPlacesClient provideAPIKey:@"AIzaSyB9U-Ssv6A9Tt2keQtZyWMuadHoELYeGlk"];

    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
   
    mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
   

    
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
       
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
       
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
      
    }];

    
/*------- Employee Login--------------*/

    NSData *FinalRegisteredEmployee = [[NSUserDefaults standardUserDefaults] objectForKey:@"FinalRegisteredEmployee"];
    if (FinalRegisteredEmployee!=nil) {
        kAppDel.obj_FinalRegisteredEmployee = [NSKeyedUnarchiver unarchiveObjectWithData:FinalRegisteredEmployee];
    }
    
    NSString *userDefault = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"];
    
    if (FinalRegisteredEmployee == nil) {
        
        if ([[[NSUserDefaults standardUserDefaults]
              stringForKey:@"Category_id"]isEqualToString:@"Category_id"])
        {
            employeeSlideNavigation *leftMenu = [mainStoryboard
                                                 instantiateViewControllerWithIdentifier: @"employeeSlideNavigation"];
            
            [[SlideNavigationController sharedInstance] setLeftMenu:leftMenu];
            
            employeeJobNotification * obj_employeeJobNotification = [mainStoryboard instantiateViewControllerWithIdentifier:@"employeeJobNotification"];
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            [navigationController pushViewController:obj_employeeJobNotification animated:NO];
        }
    }
    if (kAppDel.obj_FinalRegisteredEmployee.Employee_category_id.length>0)
    {
       
        employeeSlideNavigation *leftMenu = [mainStoryboard
                                             instantiateViewControllerWithIdentifier: @"employeeSlideNavigation"];
        
        [[SlideNavigationController sharedInstance] setLeftMenu:leftMenu];
        employeeJobNotification * obj_employeeJobNotification = [mainStoryboard instantiateViewControllerWithIdentifier:@"employeeJobNotification"];
        UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
        [navigationController pushViewController:obj_employeeJobNotification animated:NO];
    }
    else
    {
        NSData *  registerEmployee= [[NSUserDefaults standardUserDefaults] objectForKey:@"employeeRegister"];
        
        NSData *LoginEmployee = [[NSUserDefaults standardUserDefaults]objectForKey:@"employeeRegisterSocial"];
        if (registerEmployee!=nil) {
             kAppDel.obj_responseRegiserEmployee = [NSKeyedUnarchiver unarchiveObjectWithData:registerEmployee];
        }if (LoginEmployee!=nil) {
            kAppDel.obj_reponseGmailFacebookLogin = [NSKeyedUnarchiver unarchiveObjectWithData:LoginEmployee];
             kAppDel.EmployeeProfileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:kAppDel.obj_reponseGmailFacebookLogin.Employee_jobseeker_profile_pic]]];
        }
        NSString *userId;
        if (registerEmployee==nil) {
           userId = [NSString stringWithFormat:@"%@",kAppDel.obj_reponseGmailFacebookLogin.Employee_UserId];
        }else{
        userId = [NSString stringWithFormat:@"%@", kAppDel.obj_responseRegiserEmployee.Employee_UserId];
        }
        if ([userDefault isEqualToString:userId])
        {
            if (registerEmployee==nil) {
                if (kAppDel.obj_reponseGmailFacebookLogin.Employee_category_name.length==0 && kAppDel.obj_reponseGmailFacebookLogin.Employee_email.length>1) {
                    
                    CategoryEmployeeCtr * obj_CategoryEmployeeCtr = [mainStoryboard instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    [navigationController pushViewController:obj_CategoryEmployeeCtr animated:NO];
                }
            }
            else{
                if (kAppDel.obj_responseRegiserEmployee.Employee_category_id.length==0 && kAppDel.obj_responseRegiserEmployee.Employee_zipcode.length>1)
                {
                    
                    CategoryEmployeeCtr * obj_CategoryEmployeeCtr = [mainStoryboard instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
                    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                    [navigationController pushViewController:obj_CategoryEmployeeCtr animated:NO];
                }

            }
        }
    }
/*----- Employer Login--------------------*/
    
    
    /*----------Get prestored data----------*/
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"employerRegister"];
    if (data!=nil) {
         self.obj_responseDataOC =  [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
/*-----Check if data is null or not---------*/
    
    if(!data){
        dataLogin= [[NSUserDefaults standardUserDefaults] objectForKey:@"employerLogin"];
        
        if (dataLogin!=nil) {
           self.obj_responseDataOC =[NSKeyedUnarchiver unarchiveObjectWithData:dataLogin];
        }
    }
    if(data != nil || dataLogin != nil){
        if(self.obj_responseDataOC.employerCompanyName != (id)[NSNull null] && self.obj_responseDataOC.employerProfilePic !=(id)[NSNull null] )
        {
            /*---------Setting menu ctr as root view controller---------*/
            
            self.obj_responseDataOC = [[NSUserDefaults standardUserDefaults] objectForKey:@"employerLogin"];
            
            employeeSlideNavigation *leftMenu = [mainStoryboard
                                                 instantiateViewControllerWithIdentifier: @"employeeSlideNavigation"];
            
            [[SlideNavigationController sharedInstance] setLeftMenu:leftMenu];
            MenuCtr *obj_MenuCtr = [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuCtr"];
             UINavigationController *obj_navigation = (UINavigationController *)self.window.rootViewController;
            [obj_navigation pushViewController:obj_MenuCtr animated:NO];
        }
        
        else{
          
            EmployerSecondScreenCtr *obj_EmployeeSecondScreen = [ mainStoryboard instantiateViewControllerWithIdentifier:@"EmployerSecondScreenCtr"];
            UINavigationController *obj_navigation = (UINavigationController *)self.window.rootViewController;
            [obj_navigation pushViewController:obj_EmployeeSecondScreen animated:NO];
        }
    }
       return YES;
}

- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation
{
    
    if ([url.scheme isEqualToString:@"fb1582860478685505"])
    
    {
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
        
    }
    
    return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
   
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}


#pragma Mark- Device ID -
- (void)registerForRemoteNotification
{
    /*----- let the device know we want to receive push notifications -----*/
    //For iOS 8
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)] && [UIApplication instancesRespondToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    if ([identifier isEqualToString:@"declineAction"]){
        
    }
    else if ([identifier isEqualToString:@"answerAction"]){
        
    }
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    self.device_Token = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
   
    NSLog(@"DEVICE_TOKEN :: %@", deviceToken);
    
    const unsigned *tokenBytes = [deviceToken bytes];
   
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    NSString *apnDeviceToken = hexToken;
    
    kAppDel.apnDeviceToken = apnDeviceToken;
    
    NSLog(@"APN_DEVICE_TOKEN :: %@", apnDeviceToken);
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    self.device_Token = nil;
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"user info %@",userInfo);
    
//    for(NSString *key in [userInfo allKeys]) {
//        
//         [self.window.rootViewController presentViewController:[GlobalMethods AlertWithTitle:@"userInfo" Message:[userInfo objectForKey:key] AlertMessage:@"OK"] animated:YES completion:nil];
//    }
}


#pragma mark - CoreData -

- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PeopleNectCoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PeopleNectCoreData.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory -

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - LocalNotification -
/*
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"notification %@",notification.alertBody);
    
    notification.applicationIconBadgeNumber = -1;

    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.rootViewController = [[UIViewController alloc] init];
    
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow makeKeyAndVisible];
    
    [alertWindow.rootViewController presentViewController:[GlobalMethods AlertWithTitle:@"PeopleNect Remainder" Message:notification.alertBody AlertMessage:@"ok"]animated:YES completion:nil];
    
}
*/
@end
