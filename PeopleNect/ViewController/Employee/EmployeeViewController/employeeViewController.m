//
//  employeeViewController.m
//  PeopleNect
//
//  Created by Narendra Pandey on 27/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeViewController.h"
#import "PN_Constants.h"
#import "GlobalMethods.h"
#import "CategoryEmployeeCtr.h"
#import "SubViewCtr.h"
#import "ViewController.h"
static int count = 0;

@interface employeeViewController ()
{
    GPPSignIn *signIn;
    NSData *dataProfileImg;
    BOOL facebook,google;
    NSData *registerSocial;
    CLLocationCoordinate2D Location;
    NSArray *json;
}
@end

@implementation employeeViewController

#pragma mark- View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self googleSignIn];
    [self autoSuggestion];

    //[self countryCodeWebService];
    
   registerSocial= [[NSUserDefaults standardUserDefaults] objectForKey:@"employeeRegisterSocial"];
   
    if (registerSocial!=nil) {
        kAppDel.obj_reponseGmailFacebookLogin = [NSKeyedUnarchiver unarchiveObjectWithData:registerSocial];
    }
    [self GoogleFBLblText];
    
     if (kAppDel.obj_reponseGmailFacebookLogin.Employee_email.length>0)
     {
         _middleView.alpha = 0.0;
         _registerView.alpha = 0.0;
         _btnPrivacyPolicy.alpha = 0.0;
     }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
[[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"Gray_right_arrow_"];
    
 self.heightForMainContainer.constant = self.mainContainer.frame.size.height;
    
    if (facebook == TRUE)
    {
        count = count;
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [self autoSuggestionOptionalProperty];
    
    if (kAppDel.obj_reponseGmailFacebookLogin.Employee_email.length>0)
    {
        _tfName.text = kAppDel.obj_reponseGmailFacebookLogin.Employee_first_name;
        _tfSurname.text = kAppDel.obj_reponseGmailFacebookLogin.Employee_last_name;
        _tfEmail.text = kAppDel.obj_reponseGmailFacebookLogin.Employee_email;
        _tfEmail.userInteractionEnabled = NO;
        _tfPassword.hidden = YES;
        _tfPassword.text = @"PP@123abc";
        [self hidePasswordText];
        [UIView animateWithDuration:0.4 animations:^{
            _middleView.alpha = 1.0;
            _registerView.alpha = 1.0;
            _btnPrivacyPolicy.alpha = 1.0;
        }];
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    if (facebook == TRUE){
        count = count;
    }
    if (google == TRUE) {
        count = 0;
    }
    kAppDel.obj_reponseGmailFacebookLogin = [[reponseGmailFacebookLogin alloc]initWithDictionary:nil];
    NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_reponseGmailFacebookLogin];
    /*-------Setting user default data-----------*/
    [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employeeRegisterSocial"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    kAppDel.EmployeeStreetName = @"fakeData";
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EmployeePassword"];
}


#pragma mark - IBAction
- (IBAction)googleSignInBtnClicked:(id)sender
{
    [signIn authentication];
    facebook = FALSE;
    google = TRUE;
}


- (IBAction)facebookSignInClicked:(id)sender
{
    facebook = TRUE;
    google = FALSE;
    
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
    }
    else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
    
}


- (IBAction)btnRegisterClicked:(id)sender
{
    BOOL emailflag = NO,passwordflag=NO;
    if (_tfName.text.length == 0)
    {
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Name is required" Message:@"Please enter your name" AlertMessage:@"OK"]animated:YES completion:nil];
    }
    else{
            if (_tfSurname.text.length == 0)
            {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Surname is required" Message:@"Please enter your surname" AlertMessage:@"OK"]animated:YES completion:nil];
            }
        else{
                if(_tfEmail.text.length == 0)
                {
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Email is required" Message:@"Please enter your email" AlertMessage:@"OK"]animated:YES completion:nil];
                }
            else{
                if (_tfEmail.text.length>0){
                    if ([GlobalMethods validateEmailWithString:_tfEmail.text]){
                        emailflag = YES;
                    }
                    else{
                        [self presentViewController:[GlobalMethods AlertWithTitle:@"Invalid email" Message:@"Please enter a valid email address" AlertMessage:@"OK"]animated:YES completion:nil];
                }
            }
        }
    }
}
    
    
if (emailflag == YES)
    {
        if (_tfPhoneCountryCode.text.length == 0)
        {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Country code is required" Message:@"Please select country code" AlertMessage:@"OK"]animated:YES completion:nil];
        }
    else{
            if (_tfPhoneNumber.text.length==0)
            {
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Phone number is required" Message:@"Please enter phone number" AlertMessage:@"OK"]animated:YES completion:nil];
            }
            else
            {
                if (_tfZipCode.text.length==0)
                {
                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Zip code is required" Message:@"Please enter zip code" AlertMessage:@"OK"]animated:YES completion:nil];
                }
                else
                {
                    if(_tfStreetName.text.length ==0)
                    {
                        [self presentViewController:[GlobalMethods AlertWithTitle:@"Street name is required" Message:@"Please enter street name" AlertMessage:@"OK"]animated:YES completion:nil];
                    }
                else
                {
                if(_tfStreetNumber.text.length ==0)
                {
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Street number is required" Message:@"Please enter street number" AlertMessage:@"OK"]animated:YES completion:nil];
            }
        else
        {
            if (_tfPassword.text.length == 0)
            {
                 [self presentViewController:[GlobalMethods AlertWithTitle:@"Password is required" Message:@"Please enter password" AlertMessage:@"OK"]animated:YES completion:nil];
            }
            else
            {
                if (_tfPassword.text.length>0)
                {
                    passwordflag = YES;

                    /* Password validation */
                  
                    /*
                    NSString *passwordRegex = @"((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%?_!^&*]).{8,})";
                    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
                    [passwordTest evaluateWithObject:_tfPassword.text];
                    if([passwordTest evaluateWithObject:_tfPassword.text])
                    {
                        passwordflag = YES;
                    }
                    else{
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Invalid password" Message:@"Password must contain an alphabet, a special character, a capital alphabet  and a number" AlertMessage:@"OK"]animated:YES completion:nil];
                }
            */
            }
        }

        }
                        
        }
}
    }
}
}
    if(passwordflag == YES)
    {
        /// .... Google facebook update........
        
        if ([[NSUserDefaults standardUserDefaults]
             stringForKey:@"EmployeeUserId"].length>0 && kAppDel.EmployeeStreetName.length==0)
        {
            CGImageRef cgref = [kAppDel.EmployeeProfileImage CGImage];
            CIImage *cim = [kAppDel.EmployeeProfileImage CIImage];
            
            if (cim == nil && cgref == NULL)
            {
                if ([GlobalMethods InternetAvailability]) {
                    [self updateRegister];
                }else{
                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
                }
            }
            else
            {
                if ([GlobalMethods InternetAvailability]) {
                    [self UpdateUserDetail];
                }else{
                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
                }
            }
        }
    else
        {
            if ([GlobalMethods InternetAvailability]) {
                
                kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
                
                [kAFClient POST:MAIN_URL parameters:[GlobalMethods EmployeeRegisterWith:@"email" Email:_tfEmail.text Name:_tfName.text Surname:_tfSurname.text Password:_tfPassword.text  Phone:_tfPhoneNumber.text DevideId:@"" Access_Token:@"" Access_identifire:@"" ZipCode:_tfZipCode.text StreetName:_tfStreetName.text StreetNumber:_tfStreetNumber.text countryCode:_tfPhoneCountryCode.text] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                 {
                     [kAppDel.progressHud hideAnimated:YES];
                     
                     kAppDel.obj_responseRegiserEmployee = [[responseRegiserEmployee alloc]initWithDictionary:responseObject];
                     
                     /*-------Archiving the data----*/
                     
                     NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseRegiserEmployee];
                     
                     /*-------Setting user default data-----------*/
                     
            [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employeeRegister"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     
        if ([[responseObject valueForKey:@"status"] isEqual:@1])
                    {
                         
                NSString * str = [[responseObject objectForKey:@"data"]valueForKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] setObject: str forKey:@"EmployeeUserId"];
                         
                [[NSUserDefaults standardUserDefaults] synchronize];
                         
                [[NSUserDefaults standardUserDefaults] setObject:_tfPassword.text forKey:@"EmployeePassword"];
                         
            CategoryEmployeeCtr *obj_CategoryEmployeeCtr = [self.storyboard  instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
                         
            [self.navigationController pushViewController:obj_CategoryEmployeeCtr animated:YES ];
            }else{
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Error!" Message:[responseObject valueForKey:@"message"] AlertMessage:@"OK"]animated:YES completion:nil];
                }
            }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
    [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
            }
        }
    }
}



- (IBAction)btnPrivacyClicked:(id)sender
{
 
    privacyPolicy *obj_privacyPolicy = [self.storyboard instantiateViewControllerWithIdentifier:@"privacyPolicy"];
    
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:obj_privacyPolicy];
    
    obj_nav.definesPresentationContext = YES;
    
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:obj_nav animated:YES completion:nil];
    
//    UIWebView *privacyPolicy=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    NSString *indexPath = [NSBundle pathForResource:@"index" ofType:@"html" inDirectory:nil];
//    [privacyPolicy loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
//    [self.view addSubview:myWebView];
}


#pragma mark - Navigation Bar Back Button -
-(void)barBackButton{
    [self.navigationController popToRootViewControllerAnimated:YES];
    count = 0;
}
    

#pragma mark - UITextField Delegates -
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == _tfName)
    {
        [theTextField resignFirstResponder];
        [_tfSurname becomeFirstResponder];
        
    }
    else if (theTextField == _tfSurname)
    {
        [_tfSurname resignFirstResponder];
        [_tfEmail becomeFirstResponder];
    }
    else if (theTextField == _tfEmail)
    {
        [_tfEmail resignFirstResponder];
        [_tfPhoneNumber becomeFirstResponder];
    }
    else if (theTextField == _tfPhoneNumber)
    {
        [_tfPhoneNumber resignFirstResponder];
        [_tfStreetName becomeFirstResponder];
    }
    else if (theTextField == _tfStreetName)
    {
        [_tfStreetName resignFirstResponder];
        [_tfZipCode becomeFirstResponder];
    }
    else if (theTextField == _tfZipCode)
    {
        [_tfZipCode resignFirstResponder];
        [_tfStreetNumber becomeFirstResponder];
    }
    else if (theTextField == _tfStreetNumber)
    {
        [_tfStreetNumber resignFirstResponder];
         [_tfPassword becomeFirstResponder];
    }
    
    else if (theTextField == _tfPassword)
    {
        [_tfPassword resignFirstResponder];
    }
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == _tfPhoneCountryCode)
    {
        _tfPhoneCountryCode.inputView = [SubViewCtr sharedInstance];
        
        [SubViewCtr sharedInstance].obj_PickerView.delegate = self;
        
        [SubViewCtr sharedInstance].obj_PickerView.dataSource = self;
        
        [[SubViewCtr sharedInstance]
         
         toolBarPickerWithSelector:@selector(next) Target:self];
        
        _tfPhoneCountryCode.text =[NSString stringWithFormat:@"+%@",[kAppDel.obj_CountryCode.countryCode objectAtIndex:0]];
    }
    if (textField == _tfStreetNumber) {
        if (_tfPassword.hidden == YES) {
            textField.returnKeyType = UIReturnKeyDone;
        }
        else
            textField.returnKeyType = UIReturnKeyNext;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSRange spaceRange = [string rangeOfString:@" "];
    if (spaceRange.location != NSNotFound)
    {
        
        if (textField==_tfStreetName) {
            return YES;
        }
        else
            
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - Picker -
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if ([kAppDel.obj_CountryCode.countryCode count]==0) {
    }
    else
        [[SubViewCtr sharedInstance].activityIndicator stopAnimating];
    return [kAppDel.obj_CountryCode.countryCode count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"+%@",[kAppDel.obj_CountryCode.countryCode objectAtIndex:row] ];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _tfPhoneCountryCode.text =[NSString stringWithFormat:@"+%@",[kAppDel.obj_CountryCode.countryCode objectAtIndex:row]];
}


#pragma mark - Picker ToolBar Next button -

-(void)next
{
    [_tfPhoneCountryCode resignFirstResponder];
    
    [_tfPhoneNumber becomeFirstResponder];
}

#pragma mark - GoogleFBLblText


-(void) GoogleFBLblText
{
    _lblGoogle.text = [NSString stringWithFormat:@"With\nGoogle"];
    
    _lblFacebook.text = [NSString stringWithFormat:@"With\nFacebook"];
    
    _lblFacebook.numberOfLines = 0;
    
    _lblGoogle.numberOfLines = 0;
    
    [_lblGoogle setLineBreakMode:NSLineBreakByWordWrapping];
    
    [_lblFacebook setLineBreakMode:NSLineBreakByWordWrapping];
}


#pragma mark - Google Sign In -


-(void)googleSignIn
{
    signIn = [GPPSignIn sharedInstance];
    signIn.clientID = GPP_Client_ID;
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];
    signIn.delegate = self;
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.shouldFetchGoogleUserID = YES;
}


- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error
{
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];

    NSString  *accessTocken = [auth valueForKey:@"accessToken"];
    
    NSString *str=[NSString stringWithFormat:@"https://www.googleapis.com/oauth2/v1/userinfo?access_token=%@",accessTocken];
    
    NSString *escapedUrl = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",escapedUrl]];
    
    NSString *jsonData = [[NSString alloc] initWithContentsOfURL:url usedEncoding:nil error:nil];
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:[jsonData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    NSString *imageString = [jsonDictionary objectForKey:@"picture"];
    
    kAppDel.EmployeeProfileImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:imageString]]];
    
    
    [kAFClient POST:MAIN_URL parameters:[GlobalMethods EmployeeRegisterWith:@"socialMedia" Email:[jsonDictionary valueForKey:@"email"] Name:[jsonDictionary valueForKey:@"given_name"] Surname:[jsonDictionary valueForKey:@"family_name"] Password:@"" Phone:@"" DevideId:@"" Access_Token:[auth valueForKey:@"accessToken"] Access_identifire:[jsonDictionary valueForKey:@"id"] ZipCode:@"" StreetName:@"" StreetNumber:@"" countryCode:@""] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [kAppDel.progressHud hideAnimated:YES];
        
        NSString * str = [[responseObject objectForKey:@"data"]valueForKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"EmployeeUserId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        kAppDel.EmployeeStreetName = [[responseObject valueForKey:@"data"]valueForKey:@"streetName"];
        
        kAppDel.obj_responseRegiserEmployee = [[responseRegiserEmployee alloc]initWithDictionary:responseObject];
        
        /*-------Archiving the data----*/
        
        NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseRegiserEmployee];
        
        /*-------Setting user default data-----------*/
        
        [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employeeRegister"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        NSLog(@"%@",[[responseObject valueForKey:@"data"]valueForKey:@"streetName"]);
        
        if ([[[responseObject valueForKey:@"data"]valueForKey:@"streetName"]length]>0)
        {
            if ([[responseObject valueForKey:@"data"]valueForKey:@"category_name"])
            {
                NSString *imageString = [[responseObject valueForKey:@"data"]valueForKey:@"jobseeker_profile_pic"];
                if (imageString.length>0)
                {
                    kAppDel.EmployeeProfileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]]];
                }
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
        }        else
        {
            _tfName.text = [jsonDictionary valueForKey:@"given_name"];
            _tfSurname.text = [jsonDictionary valueForKey:@"family_name"];
            _tfEmail.text = [jsonDictionary valueForKey:@"email"];
            _tfEmail.userInteractionEnabled = NO;
            _tfPassword.hidden = YES;
             _tfPassword.text = @"PP@123abc";
            
            [UIView animateWithDuration:0.4 animations:^{
                
                _middleView.alpha = 0.0;
                _btnRegister.alpha = 0.0;
                _btnPrivacyPolicy.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                

                if (count==0)
                {
                    [self hidePasswordText];
                }
                [UIView animateWithDuration:0.3 animations:^{
                    _middleView.alpha = 1.0;
                    _btnRegister.alpha = 1.0;
                    _btnPrivacyPolicy.alpha = 1.0;
                }];
                
            }];

        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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


#pragma mark - Facebook Sign In -
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

            kAppDel.obj_responseRegiserEmployee = [[responseRegiserEmployee alloc]initWithDictionary:responseObject];
                      
            /*-------Archiving the data----*/
                      
        NSData *registerEmployee =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseRegiserEmployee];
                      
        /*-------Setting user default data-----------*/
                      
        [[NSUserDefaults standardUserDefaults] setObject:registerEmployee forKey:@"employeeRegister"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [kAppDel.progressHud hideAnimated:YES];
                      
    kAppDel.EmployeeStreetName = [[responseObject valueForKey:@"data"]valueForKey:@"streetName"];

    NSString * str = [[responseObject objectForKey:@"data"]valueForKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"EmployeeUserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
        if ([[[responseObject valueForKey:@"data"]valueForKey:@"streetName"]length]>0)
    {
        if ([[responseObject valueForKey:@"data"]valueForKey:@"category_name"])
        {
            NSString *imageString = [[responseObject valueForKey:@"data"]valueForKey:@"jobseeker_profile_pic"];
                              
        if (imageString.length>0)
        {
                                  
        kAppDel.EmployeeProfileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]]];
                                  
        }
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
                _tfName.text = [result valueForKey:@"first_name"];
                _tfSurname.text = [result valueForKey:@"last_name"];
                _tfEmail.text = [result valueForKey:@"email"];
                _tfEmail.userInteractionEnabled = NO;
                _tfPassword.text = @"PP@123abc";
                _tfPassword.hidden = YES;
                [UIView animateWithDuration:0.4 animations:^{
                    
                    _middleView.alpha = 0.0;
                    _btnRegister.alpha = 0.0;
                    _btnPrivacyPolicy.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    
                    if (count==0)
                    {
                        [self hidePasswordText];
                    }
                   
                    [UIView animateWithDuration:0.3 animations:^{
                        _middleView.alpha = 1.0;
                        _btnRegister.alpha = 1.0;
                        _btnPrivacyPolicy.alpha = 1.0;
                    }];
                    
                }];
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                  {
                      [kAppDel.progressHud hideAnimated:YES];

                  }];

    }
             
         }];
    }
    
    
}
#pragma mark - Country CodeWebService


-(void)countryCodeWebService
{
    /*----Getting country code---*/
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"countryCodeList" forKey:@"methodName"];
    
    [kAFClient POST:MAIN_URL parameters:dict progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject)
     {
         kAppDel.obj_CountryCode
         = [[CountryCode alloc] initWithDictionary:responseObject];
         
     }
            failure:^(NSURLSessionDataTask *task, NSError   *error)
     {
     }];
}
#pragma Mark - Image

-(void)returnImage :(UIImage *)img
{
    dataProfileImg = UIImageJPEGRepresentation(img, 1.0);
}


#pragma mark - PasswordText Hide

-(void)hidePasswordText
{
    _middleView.frame = CGRectMake(_middleView.frame.origin.x, _middleView.frame.origin.y, _middleView.frame.size.width,_middleView.frame.size.height-_tfPassword.frame.size.height);
    
    _registerView.frame = CGRectMake(_registerView.frame.origin.x, _middleView.frame.origin.y+_middleView.frame.size.height, _registerView.frame.size.width, _registerView.frame.size.height);
    
    _btnPrivacyPolicy.frame = CGRectMake(_btnPrivacyPolicy.frame.origin.x, _registerView.frame.origin.y + _registerView.frame.size.height +15 , _btnPrivacyPolicy.frame.size.width, _btnPrivacyPolicy.frame.size.height);
 count = 1;
}

#pragma mark - Update User Detail -
-(void)UpdateUserDetail
{
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    
    NSData* imageData = UIImageJPEGRepresentation(kAppDel.EmployeeProfileImage, 1.0);
    
    [self returnImage:[UIImage imageWithData:imageData]];
    
    [kAFClient POST:MAIN_URL parameters:[GlobalMethods EmployeeSaveUserDetail:[[NSUserDefaults standardUserDefaults]
        stringForKey:@"EmployeeUserId"] firstname:_tfName.text lastName:_tfSurname.text phone:_tfPhoneNumber.text categoryId:@"" subCategoryId:@"" experience:@"" rate:@"" description:@"" password:@"" zipcode:_tfZipCode.text streetName:_tfStreetName.text number:_tfStreetNumber.text country_code:_tfPhoneCountryCode.text lastEmployer:@""] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         [formData appendPartWithFileData:dataProfileImg name:@"profile_pic" fileName:@"image.jpg" mimeType:@"image/jpeg"];
         
     } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         [kAppDel.progressHud hideAnimated:YES];
        
         kAppDel.obj_responseRegiserEmployee = [[responseRegiserEmployee alloc]initWithDictionary:responseObject];
         
         /*-------Archiving the data----*/
         
         NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseRegiserEmployee];
         
         /*-------Setting user default data-----------*/
         
         [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employeeRegister"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         CategoryEmployeeCtr *obj_CategoryEmployeeCtr = [self.storyboard  instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
         
         [self.navigationController pushViewController:obj_CategoryEmployeeCtr animated:YES ];
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         [kAppDel.progressHud hideAnimated:YES];
         
     }];
}
-(void)updateRegister
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
   
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];

    [_param addEntriesFromDictionary:[GlobalMethods EmployeeSaveUserDetail:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] firstname:_tfName.text lastName:_tfSurname.text phone:_tfPhoneNumber.text categoryId:@"" subCategoryId:@"" experience:@"" rate:@"" description:@"" password:_tfPassword.text zipcode:_tfZipCode.text streetName:_tfStreetName.text number:_tfStreetNumber.text country_code:_tfPhoneCountryCode.text lastEmployer:@""]];
    [_param setObject:@"" forKey:@"profile_pic"];
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [kAppDel.progressHud hideAnimated:YES];
        
        kAppDel.obj_responseRegiserEmployee = [[responseRegiserEmployee alloc]initWithDictionary:responseObject];
        
        /*-------Archiving the data----*/
        
        NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseRegiserEmployee];
        
        /*-------Setting user default data-----------*/
        
        [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employeeRegister"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        CategoryEmployeeCtr *obj_CategoryEmployeeCtr = [self.storyboard  instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
        
        [self.navigationController pushViewController:obj_CategoryEmployeeCtr animated:YES ];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];

    }];
}
#pragma mark -autoSuggestion -
-(void)autoSuggestion{
    _tfStreetName.placeSearchDelegate = self;
    _tfStreetName.delegate = self;
    _tfStreetName.strApiKey = @"AIzaSyB9U-Ssv6A9Tt2keQtZyWMuadHoELYeGlk";
    _tfStreetName.superViewOfList = self.view;
    _tfStreetName.autoCompleteShouldHideOnSelection = YES;
    _tfStreetName.maximumNumberOfAutoCompleteRows = 10;
    _tfPhoneCountryCode.text = @"+55";
    _tfPhoneCountryCode.enabled = NO;
   // _tfPhoneCountryCode.textColor = [UIColor grayColor];
}

-(void)autoSuggestionOptionalProperty{
    _tfStreetName.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    _tfStreetName.autoCompleteBoldFontName = @"HelveticaNeue";
    _tfStreetName.autoCompleteTableCornerRadius=0.0;
    _tfStreetName.autoCompleteRowHeight=35;
    _tfStreetName.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    _tfStreetName.autoCompleteFontSize=14;
    _tfStreetName.autoCompleteTableBorderWidth=1.0;
    _tfStreetName.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    _tfStreetName.autoCompleteShouldHideOnSelection=YES;
    _tfStreetName.autoCompleteShouldHideClosingKeyboard=YES;
    _tfStreetName.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    _tfStreetName.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_tfStreetName.frame.size.width)*0.5, _phoneView.frame.origin.y, _tfStreetName.frame.size.width, 300.0);
}

#pragma mark - Place search Textfield Delegates -
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    [self.view endEditing:YES];
    Location = responseDict.coordinate;
    NSString *req = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",Location.latitude,Location.longitude];
    [self usingNsurljsonParsing:req];
}

-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    if(index%2==0){
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}


-(void)usingNsurljsonParsing:(NSString *)urlAsString
{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    NSString *encodedUrlAsString = [urlAsString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                if (!error){
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]){
                        NSError *jsonError;
                        json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        if (jsonError){
                        } else{
                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                NSArray *StateCity = [[json valueForKey:@"results"]valueForKey:@"address_components"];
                                
                                NSMutableDictionary *dict = [StateCity objectAtIndex:0];
                                
                                for (int i = 0; i<dict.count; i++) {
                                    
                                    NSArray *type = [[dict valueForKey:@"types"]objectAtIndex:i];
                    if ([type containsObject:@"administrative_area_level_1"]) {
                       
                       // _tfState.text =[[dict valueForKey:@"long_name"]objectAtIndex:i];
                        
                            }
                    if ([type containsObject:@"administrative_area_level_2"]) {
                        //_tfCity.text = [[dict valueForKey:@"long_name"]objectAtIndex:i];
                                    }
                                    if ([type containsObject:@"postal_code"]) {
                                        _tfZipCode.text = [[dict valueForKey:@"long_name"]objectAtIndex:i];
                                    }
                                    
                                }
                            });
                        }
                    }
                } else{
                    //NSLog(@"error : %@", error.description);
                }
            }] resume];
}


@end
