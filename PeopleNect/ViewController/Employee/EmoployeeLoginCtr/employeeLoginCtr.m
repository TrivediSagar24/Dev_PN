//
//  employeeLoginCtr.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeLoginCtr.h"
#import "EmployeeForgotPasswordCtr.h"
#import "employeeJobNotification.h"
#import  "responseDataOC.h"
@interface employeeLoginCtr ()
{
    GPPSignIn *signIn;
}
@end
@implementation employeeLoginCtr
#pragma mark - View LifeCycle -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self GoogleFBLblText];
    [self googleSignIn];
    [[NSUserDefaults standardUserDefaults ]setObject:@"Employee" forKey:@"LoginData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   }
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"Gray_right_arrow_"];
}
#pragma mark - GoogleFBLblText -
-(void) GoogleFBLblText
{
    _lblWithGoogle.text = [NSString stringWithFormat:@"With\nGoogle"];
    _lblWithFacebook.text = [NSString stringWithFormat:@"With\nFacebook"];
    _lblWithFacebook.numberOfLines = 0;
    _lblWithGoogle.numberOfLines = 0;
    [_lblWithGoogle setLineBreakMode:NSLineBreakByWordWrapping];
    [_lblWithFacebook setLineBreakMode:NSLineBreakByWordWrapping];
}
#pragma mark - IBAction -
- (IBAction)GoogleLoginClicked:(id)sender
{
        [signIn authentication];
}
- (IBAction)FacebookLoginClicked:(id)sender
{
    
    if ([GlobalMethods InternetAvailability]) {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        
        [login
         logInWithReadPermissions: @[@"public_profile",@"email", @"user_friends"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
         {
             if (error)
             {
             } else if (result.isCancelled)
             {
             } else
             {
                 [self getInfo];
             }
         }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
   
}
- (IBAction)LoginClicked:(id)sender
{
    BOOL email = NO,password = NO;
    if (_tfEmail.text.length == 0)
    {
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Email is Required" Message:@"Please enter your Email" AlertMessage:@"OK"]animated:YES completion:nil];
    }
    else
    {
        if (_tfEmail.text.length>0)
        {
            if ([GlobalMethods validateEmailWithString:_tfEmail.text])
            {
                email = YES;
            }
            else
            {
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Invalid Email" Message:@"Please enter a valid email address" AlertMessage:@"OK"]animated:YES completion:nil];
            }
        }
    }
    if (email == YES)
    {
        if (_tfPassword.text.length ==0 )
        {
             [self presentViewController:[GlobalMethods AlertWithTitle:@"password is Required" Message:@"Please enter  your Password" AlertMessage:@"OK"]animated:YES completion:nil];
        }
        else
        {
            password = YES;
        }
    }
    if (password == YES)
    {
        
        if ([GlobalMethods InternetAvailability]) {
            
            kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
            [kAFClient POST:MAIN_URL parameters:[GlobalMethods EmployeeLoginWithEmail:_tfEmail.text Password:_tfPassword.text DeviceId:DevideID] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 kAppDel.obj_reponseGmailFacebookLogin
                 = [[reponseGmailFacebookLogin alloc] initWithDictionary:responseObject];
            
                 /*-------Archiving the data----*/
                 
                 NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_reponseGmailFacebookLogin];
                 
        /*----Setting user default data-----------*/
                 
                 [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employeeRegisterSocial"];
                 
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 if ([[responseObject valueForKey:@"data"]valueForKey:@"category_id"])
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:@"Category_id" forKey:@"Category_id"];
                     
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     
                     
                     employeeSlideNavigation *leftMenu =[self.storyboard
                                                         instantiateViewControllerWithIdentifier: @"employeeSlideNavigation"];
                     
                     [[SlideNavigationController sharedInstance] setLeftMenu:leftMenu];
                     
                
                     
            employeeJobNotification *obj_employeeJobNotification = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeJobNotification"];
                     [self.navigationController pushViewController:obj_employeeJobNotification animated:YES];
                }
                 
                [[NSUserDefaults standardUserDefaults] setObject:_tfPassword.text forKey:@"EmployeePassword"];
                 
                [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [kAppDel.progressHud hideAnimated:YES];
                 
                 if ([[[responseObject valueForKey:@"data"]valueForKey:@"userId"] length]>0 && ![[responseObject valueForKey:@"data"]valueForKey:@"category_id"])
                 {
                     CategoryEmployeeCtr *obj_CategoryEmployeeCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
                     
                     [self.navigationController pushViewController:obj_CategoryEmployeeCtr animated:YES];
                 }
                 if ([[responseObject valueForKey:@"status"] isEqual:@1])
                 {
                     NSString *imageString = [[responseObject valueForKey:@"data"]valueForKey:@"jobseeker_profile_pic"];
                     
                     kAppDel.EmployeeProfileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]]];
                    
                     NSString * userId = [[responseObject objectForKey:@"data"]valueForKey:@"userId"];
                     
                     [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"EmployeeUserId"];
                     
                     [[NSUserDefaults standardUserDefaults] synchronize];
           
            /* Update Device Token With User Type  */
     
                /*
                 
                [kAFClient POST:MAIN_URL parameters:[GlobalMethods updateDeviceTokenWithUserType:@"0" DeviceToken:kAppDel.apnDeviceToken userId:userId] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"updateDeviceTokenWithUserType %@",responseObject);
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                     }];
                      
                */
                     
            /* Update Device Token With User Type  */

                 }
                 else
                 {
                     [self presentViewController:[GlobalMethods AlertWithTitle:@"Error" Message:[responseObject valueForKey:@"message"] AlertMessage:@"OK"] animated:YES completion:nil];
                 }
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [kAppDel.progressHud hideAnimated:YES];
             }];
            
        }else{
             [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
        }
}
}
- (IBAction)forgotPasswordClicked:(id)sender
{
    EmployeeForgotPasswordCtr *obj_EmployeeForgotPasswordCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeForgotPasswordCtr"];
    [self.navigationController pushViewController:obj_EmployeeForgotPasswordCtr animated:YES];
}
#pragma mark - Navigation Bar Back Button
-(void)barBackButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - Google Sign In
-(void)googleSignIn
{
    signIn = [GPPSignIn sharedInstance];
    signIn.clientID = kClientId;
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];
    signIn.delegate = self;
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.shouldFetchGoogleUserID = YES;
}
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error
{
     kAppDel.progressHud =  [GlobalMethods ShowProgressHud:self.view];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSString stringWithFormat:@"https://www.googleapis.com/oauth2/v1/userinfo?access_token=%@",[auth valueForKey:@"accessToken"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:[[[NSString alloc] initWithContentsOfURL:url usedEncoding:nil error:nil] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    kAppDel.EmployeeProfileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[jsonDictionary objectForKey:@"picture"]]]];
    
    [kAFClient POST:MAIN_URL parameters: [GlobalMethods EmployeeRegisterWith:@"socialMedia" Email:[jsonDictionary valueForKey:@"email"] Name:[jsonDictionary valueForKey:@"given_name"] Surname:[jsonDictionary valueForKey:@"family_name"] Password:@"" Phone:@"" DevideId:@"" Access_Token:[auth valueForKey:@"accessToken"] Access_identifire:[jsonDictionary valueForKey:@"id"] ZipCode:@"" StreetName:@"" StreetNumber:@"" countryCode:@""] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         kAppDel.obj_reponseGmailFacebookLogin
         = [[reponseGmailFacebookLogin alloc] initWithDictionary:responseObject];
         /*-------Archiving the data----*/
         
         NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_reponseGmailFacebookLogin];
         
         /*-------Setting user default data-----------*/
         
         [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employeeRegisterSocial"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         [kAppDel.progressHud hideAnimated:YES];
         
          kAppDel.EmployeeStreetName = [[responseObject valueForKey:@"data"]valueForKey:@"streetName"];

         NSString * userId = [[responseObject objectForKey:@"data"]valueForKey:@"userId"];
         
         [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"EmployeeUserId"];
         
         [[NSUserDefaults standardUserDefaults] synchronize];
        
        /* Update Device Token With User Type  */
         /*
         [kAFClient POST:MAIN_URL parameters:[GlobalMethods updateDeviceTokenWithUserType:@"0" DeviceToken:kAppDel.apnDeviceToken userId:userId] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"updateDeviceTokenWithUserType %@",responseObject);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
         }];
          */
         
         /* Update Device Token With User Type  */
         
        if ([[[responseObject valueForKey:@"data"]valueForKey:@"streetName"]length]>0)
       {
           if ([[responseObject valueForKey:@"data"]valueForKey:@"category_name"])
           {
               NSString *imageString = [[responseObject valueForKey:@"data"]valueForKey:@"jobseeker_profile_pic"];
               if (imageString.length>0)
               {
                   kAppDel.EmployeeProfileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]]];
               }
               
               employeeSlideNavigation *leftMenu = [self.storyboard
                                                                              instantiateViewControllerWithIdentifier: @"employeeSlideNavigation"];
               
               [[SlideNavigationController sharedInstance] setLeftMenu:leftMenu];
               
               employeeJobNotification *obj_employeeJobNotification = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeJobNotification"];
               obj_employeeJobNotification.UserCategory = [[responseObject valueForKey:@"data"]valueForKey:@"category_name"];
               [self.navigationController pushViewController:obj_employeeJobNotification animated:YES];
               
        [[NSUserDefaults standardUserDefaults] setObject:@"Category_id" forKey:@"Category_id"];
               
            [[NSUserDefaults standardUserDefaults] synchronize];
           }
           else
           {
               CategoryEmployeeCtr *obj_CategoryEmployeeCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
               [self.navigationController pushViewController:obj_CategoryEmployeeCtr animated:YES];
           }
       }
         else
         {
             employeeViewController *obj_employeeViewController = [self.storyboard  instantiateViewControllerWithIdentifier:@"employeeViewController"];
             [self.navigationController pushViewController:obj_employeeViewController animated:YES ];
         }
     }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [kAppDel.progressHud hideAnimated:YES];
     }];
    if (error)
    {
    } else
    {
    }
}
- (BOOL)schemeAvailable:(NSString *)scheme
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    return [application canOpenURL:URL];
}
#pragma mark - UITextfield  and textview Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == _tfEmail)
    {
        [theTextField resignFirstResponder];
        [_tfPassword becomeFirstResponder];
    }
    if (theTextField == _tfPassword)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSRange spaceRange = [string rangeOfString:@" "];
    if (spaceRange.location != NSNotFound)
    {
        return NO;
    } else {
        return YES;
    }
}
#pragma mark - Facebook Sign In
-(void)getInfo
{
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    if ([FBSDKAccessToken currentAccessToken])
    {
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name,email,first_name,last_name,picture.type(large),birthday,bio,location"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
         {
    if (!error)
    {
         kAppDel.EmployeeProfileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[result valueForKey:@"picture"]valueForKey:@"data"]valueForKey:@"url"]]]];
       
     
        [kAFClient POST:MAIN_URL parameters:[GlobalMethods EmployeeRegisterWith:@"socialMedia" Email:[result valueForKey:@"email"]  Name:[result valueForKey:@"first_name"]  Surname:[result valueForKey:@"last_name"] Password:@"" Phone:@"" DevideId:@"" Access_Token:[FBSDKAccessToken currentAccessToken].tokenString Access_identifire:[result valueForKey:@"id"] ZipCode:@"" StreetName:@"" StreetNumber:@"" countryCode:@""] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
        {
            
            kAppDel.obj_reponseGmailFacebookLogin
            = [[reponseGmailFacebookLogin alloc] initWithDictionary:responseObject];
            /*-------Archiving the data----*/
            
            NSLog(@"rsponse object gmailfacebook %@",responseObject);
            NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_reponseGmailFacebookLogin];
           
            /*-------Setting user default data-----------*/
            
            [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employeeRegisterSocial"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            [kAppDel.progressHud hideAnimated:YES];
            
            kAppDel.EmployeeStreetName = [[responseObject valueForKey:@"data"]valueForKey:@"streetName"];
            
    NSString * userId = [[responseObject objectForKey:@"data"]valueForKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"EmployeeUserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
            
        /* Update Device Token With User Type  */
          
            /*
        [kAFClient POST:MAIN_URL parameters:[GlobalMethods updateDeviceTokenWithUserType:@"0" DeviceToken:kAppDel.apnDeviceToken userId:userId] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"updateDeviceTokenWithUserType %@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
             */
            
        /* Update Device Token With User Type  */
            
    if ([[[responseObject valueForKey:@"data"]valueForKey:@"streetName"]length]>0)
    {
        if ([[responseObject valueForKey:@"data"]valueForKey:@"category_name"])
            {
                NSString *imageString = [[responseObject valueForKey:@"data"]valueForKey:@"jobseeker_profile_pic"];
                
            if (imageString.length>0)
                {
                        
                kAppDel.EmployeeProfileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]]];
                        
                }
                
                employeeSlideNavigation *leftMenu = [self.storyboard
                                                                               instantiateViewControllerWithIdentifier: @"employeeSlideNavigation"];
                
                [[SlideNavigationController sharedInstance] setLeftMenu:leftMenu];
                
                employeeJobNotification *obj_employeeJobNotification = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeJobNotification"];
                    obj_employeeJobNotification.UserCategory = [[responseObject valueForKey:@"data"]valueForKey:@"category_name"];
                    [self.navigationController pushViewController:obj_employeeJobNotification animated:YES];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Category_id" forKey:@"Category_id"];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                else
                {
                    CategoryEmployeeCtr *obj_CategoryEmployeeCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
                    [self.navigationController pushViewController:obj_CategoryEmployeeCtr animated:YES];
                }
            }
            else
            {
                employeeViewController *obj_employeeViewController = [self.storyboard  instantiateViewControllerWithIdentifier:@"employeeViewController"];
                [self.navigationController pushViewController:obj_employeeViewController animated:YES ];
            }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
        {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }
         }];
    }
}
@end
