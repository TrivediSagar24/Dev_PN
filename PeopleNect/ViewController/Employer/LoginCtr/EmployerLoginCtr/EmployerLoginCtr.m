//
//  EmployerLoginCtr.m
//  PeopleNect
//
//  Created by Apple on 11/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//


#import "EmployerLoginCtr.h"

@interface EmployerLoginCtr ()
{
    UIGestureRecognizer *tap;
    BOOL flagEmail;
}
@end
@implementation EmployerLoginCtr
#pragma  mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    flagEmail = false;
    [[NSUserDefaults standardUserDefaults ]setObject:@"Employer" forKey:@"LoginData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(onClickBack) Target:self Image:@"arrow.png"];
}


#pragma mark - Back Button
-(void)onClickBack{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
    {
        if ([viewControllrObj isKindOfClass:[SplashEmployerCtr class]])
        {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }
}


#pragma mark - TextField Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField ==_tfEmail){
        [_tfEmail resignFirstResponder];
        [_tfPassword becomeFirstResponder];
    }
    if(textField ==_tfPassword){
        [_tfPassword resignFirstResponder];
    }
    return YES;
}


#pragma mark - Login Button
- (IBAction)onClickLogin:(id)sender {
    BOOL email = NO,password = NO;
    if (_tfEmail.text.length == 0){
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Email is Required" Message:@"Please enter your Email" AlertMessage:@"OK"]animated:YES completion:nil];
    }
    else{
        if (_tfEmail.text.length>0)
        {
        if ([GlobalMethods validateEmailWithString:_tfEmail.text]){
                email = YES;
            }
            else{
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Invalid Email" Message:@"Please enter a valid email address" AlertMessage:@"OK"]animated:YES completion:nil];
            }
        }
    }
    if (email == YES){
        if (_tfPassword.text.length ==0 )
        {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"password is Required" Message:@"Please enter your Password" AlertMessage:@"OK"]animated:YES completion:nil];
        }
        else{
            password = YES;
        }
    }
    if (password == YES)
    {
        [[NSUserDefaults standardUserDefaults] setObject:_tfPassword.text forKey:@"EmployerPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
        [dict setObject:_tfEmail.text forKey:@"email"];
        [dict setObject:_tfPassword.text forKey:@"password"];
        [dict setObject:DevideID forKey:@"deviceId"];
        [dict setObject:@"ios" forKey:@"os"];
        [dict setObject:@"employerLogin" forKey:@"methodName"];
       
        if ([GlobalMethods InternetAvailability]) {
            
            kAppDel.progressHud  = [GlobalMethods ShowProgressHud:self.view];
            
            [kAFClient POST:MAIN_URL parameters:dict progress:nil success:^(NSURLSessionDataTask * task, id   responseObject) {
                
                [kAppDel.progressHud hideAnimated:YES];
                
                NSString * str = [[responseObject objectForKey:@"data"]valueForKey:@"employerId"];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"EmployerUserID"];
                
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                NSString * countryId = [[responseObject objectForKey:@"data"]valueForKey:@"countryId"];
                
                
                [[NSUserDefaults standardUserDefaults] setObject:countryId forKey:@"countryId"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                if([[responseObject valueForKey:@"status"] isEqual:@1]){
                    
                    self.loginEmployerId =[[responseObject valueForKey:@"data"]valueForKey:@"employerId" ];
                    
                    kAppDel.obj_responseDataOC = [[responseDataOC alloc] initWithDictionary:responseObject];
                    
                    NSData *loginObject = [NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseDataOC];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:loginObject  forKey:@"employerLogin"];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"employerLogin"];
                    if (data!=nil) {
                        kAppDel.obj_responseDataOC = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                    }
                    
            if(kAppDel.obj_responseDataOC.employerCompanyName != (id)[NSNull null] && kAppDel.obj_responseDataOC.employerProfilePic != (id)[NSNull null] ){
                        [[NSUserDefaults standardUserDefaults] setObject:@"Login" forKey:@"Update"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        
            employeeSlideNavigation *leftMenu = [self.storyboard
                                                             instantiateViewControllerWithIdentifier: @"employeeSlideNavigation"];
                        
                [[SlideNavigationController sharedInstance] setLeftMenu:leftMenu];
                        
                
                
        /* Update Device Token With User Type  */
                
                /*
                [kAFClient POST:MAIN_URL parameters:[GlobalMethods updateDeviceTokenWithUserType:@"1" DeviceToken:kAppDel.apnDeviceToken userId:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"]] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"updateDeviceTokenWithUserType %@",responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
                 
                 */
        /* Update Device Token With User Type  */

                
                
                MenuCtr *obj_MenuCtr  = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuCtr"];
                [self.navigationController pushViewController:obj_MenuCtr animated:YES];
                        
                    }
                    
                else{
                        EmployerSecondScreenCtr *obj_EmployerSecondScreenCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployerSecondScreenCtr"];
                        
                        [self.navigationController pushViewController:obj_EmployerSecondScreenCtr animated:YES];
                    }
                }
                else{
                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Error " Message:[responseObject valueForKey:@"message"] AlertMessage:@"OK"] animated:YES completion:nil];
                }
            }
                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [kAppDel.progressHud hideAnimated:YES];
                    }
             ];
        }else{
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
        }
    }
}


#pragma mark - ForgotPassword
- (IBAction)onClickForgotPassword:(id)sender {
    
    EmployeeForgotPasswordCtr *obj_EmployeeForgotPasswordCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeForgotPasswordCtr"];
    
    [self.navigationController pushViewController:obj_EmployeeForgotPasswordCtr animated:YES];
}

#pragma mark - dismissKeyboard -
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

@end
