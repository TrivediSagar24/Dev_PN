//
//  employerViewController.m
//  PeopleNect
//
//  Created by Narendra Pandey on 27/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employerViewController.h"


@interface employerViewController (){
  
    NSMutableArray *arrayCountryCode,*arrayCountryId;
    BOOL flagEmail,flagPassword,flagPhone ,_bgWithGradient;
    NSString *countryId;
}
@end

@implementation employerViewController

#pragma mark - View Life Cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self countryCodeWebService ];
    flagEmail = NO;
    flagPassword = NO;
    [_buttonPriviceProtection addTarget:self action:@selector(privacypolicy) forControlEvents:UIControlEventTouchUpInside];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(onClickBack) Target:self Image:@"arrow.png" ];
}


-(void)viewDidLayoutSubviews{
    _heightForContainerView.constant = self.view.frame.size.height;
}


#pragma mark - Back Button -
-(void)onClickBack{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers){
    if ([viewControllrObj isKindOfClass:[SplashEmployerCtr class]])
    {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }
}


#pragma mark- TextField Delegates -
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == _tfCountryCode){
        [SubViewCtr sharedInstance].obj_PickerView.delegate = self;
    [SubViewCtr sharedInstance].obj_PickerView.dataSource = self;
        
        [[SubViewCtr sharedInstance] toolBarPickerWithSelector:@selector(nextAction) Target:self];
        _tfCountryCode.inputView = [SubViewCtr sharedInstance];
       
        if ([[arrayCountryId objectAtIndex:0]count]>0) {
        _tfCountryCode.text = [NSString stringWithFormat:@"+%@",[[arrayCountryCode objectAtIndex:0]objectAtIndex:0]];
        }
        
        countryId = [NSString stringWithFormat:@"%@",[[arrayCountryId objectAtIndex:0]objectAtIndex:0] ];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == _tfName){
        [theTextField resignFirstResponder];
        [_tfSurname becomeFirstResponder];
    }
    else if (theTextField == _tfSurname){
        [_tfSurname resignFirstResponder];
        [_tfEmail becomeFirstResponder];
    }
    else if (theTextField == _tfEmail){
        [_tfEmail resignFirstResponder];
        [_tfCountryCode becomeFirstResponder];
    }
    else if (theTextField == _tfCountryCode){
        [_tfCountryCode resignFirstResponder];
        [_tfPhoneNumber becomeFirstResponder];
    }
    else if (theTextField == _tfPhoneNumber){
        [_tfPhoneNumber resignFirstResponder];
        [_tfPassword becomeFirstResponder];
    }
    else if (theTextField == _tfPassword){
        [_tfPassword resignFirstResponder];
    }
    return YES;
}


#pragma mark - Country CodeWebService -
-(void)countryCodeWebService {
    NSMutableDictionary *dictCountry = [[NSMutableDictionary alloc]init];
    [dictCountry setObject:@"countryCodeList" forKey:@"methodName"];
    arrayCountryCode =[[NSMutableArray alloc] init];
    arrayCountryId = [[NSMutableArray alloc]init];
    [kAFClient POST:MAIN_URL parameters:dictCountry progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject){
        
        [arrayCountryCode addObject:[[responseObject valueForKey:@"data" ]valueForKey:@"countryCode"]];
         [arrayCountryId addObject:[[responseObject valueForKey:@"data" ]valueForKey:@"countryCodeId"]];
        /*--------------Archiving the data----------------*/
        NSData *countryDataObject = [NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_CountryCode];
        /*-------------Setting user defaults data--------------*/
        [[NSUserDefaults standardUserDefaults] setObject:countryDataObject forKey:@"countryCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        }
        failure:^(NSURLSessionDataTask   *task, NSError  * error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
}


#pragma mark - Picker DataSource -
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    if ([[arrayCountryCode objectAtIndex:0]count]>0) {
    [[SubViewCtr sharedInstance].activityIndicator stopAnimating];
    }
    return [[arrayCountryCode objectAtIndex:0]count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"+%@",[[arrayCountryCode objectAtIndex:0] objectAtIndex:row]];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
       _tfCountryCode.text=[NSString stringWithFormat:@"+%@",[[arrayCountryCode objectAtIndex:0] objectAtIndex:row]];
        countryId =  [NSString stringWithFormat:@"%@",[[arrayCountryId objectAtIndex:0] objectAtIndex:row]];
}


#pragma mark - Picker button -
-(void)nextAction{
    [_tfCountryCode resignFirstResponder];
    [_tfPhoneNumber becomeFirstResponder];
}


#pragma mark - Click Continue -
- (IBAction)onClickContinue:(id)sender {
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
    if (emailflag == YES) {
        
        if (_tfCountryCode.text.length == 0)
        {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Country code is required" Message:@"Please select country code" AlertMessage:@"OK"]animated:YES completion:nil];
        }
        else{
            if (_tfPhoneNumber.text.length==0)
            {
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Phone number is required" Message:@"Please enter phone number" AlertMessage:@"OK"]animated:YES completion:nil];
            }
            else{
                if (_tfPassword.text.length == 0)
                {
                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Password is required" Message:@"Please enter password" AlertMessage:@"OK"]animated:YES completion:nil];
                }
                else
                {
                    if (_tfPassword.text.length>0)
                    {
                        passwordflag = YES;
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
    if(passwordflag==YES){
        
        [[NSUserDefaults standardUserDefaults] setObject:_tfPassword.text forKey:@"EmployerPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *countryCode = _tfCountryCode.text;
   
        countryCode = [countryCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
        
        if ([GlobalMethods InternetAvailability]) {
            
            kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
            [kAFClient POST:MAIN_URL parameters:[GlobalMethods EmployerRegister:@"" email:_tfEmail.text name:_tfName.text password:_tfPassword.text phone:_tfPhoneNumber.text surname:_tfSurname.text countryCode:countryCode] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [kAppDel.progressHud hideAnimated:YES];
                if ([[responseObject valueForKey:@"status"] isEqual:@0]){
                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Error!" Message:[responseObject valueForKey:@"message"] AlertMessage:@"OK"]animated:YES completion:nil];
                }
                else{
      
        NSString * str = [[responseObject objectForKey:@"data"]valueForKey:@"employerId"];
                    
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"EmployerUserID"];
                    
        [[NSUserDefaults standardUserDefaults] synchronize];
                    
        kAppDel.obj_responseDataOC  = [[responseDataOC alloc] initWithDictionary:responseObject ];
                    
        NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject: kAppDel.obj_responseDataOC ];
                    
        [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employerRegister"];
                    
    [[NSUserDefaults standardUserDefaults] synchronize];
                
        /* Update Device Token With User Type  */
             
                  /*
            [kAFClient POST:MAIN_URL parameters:[GlobalMethods updateDeviceTokenWithUserType:@"1" DeviceToken:kAppDel.apnDeviceToken userId:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"]] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"updateDeviceTokenWithUserType %@",responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
                   */
                    
        /* Update Device Token With User Type  */
                    
        EmployerSecondScreenCtr *objEmployerSecondScreenCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployerSecondScreenCtr"];
                    
        [[NSUserDefaults standardUserDefaults] setObject:countryId forKey:@"countryId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
                    
        [self.navigationController pushViewController:objEmployerSecondScreenCtr animated:YES];
        }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [kAppDel.progressHud hideAnimated:YES];
            }];
        }
        else{
            
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
        }
 }
}

-(void)privacypolicy{
    privacyPolicy *obj_privacyPolicy = [self.storyboard instantiateViewControllerWithIdentifier:@"privacyPolicy"];
    
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:obj_privacyPolicy];
    
    obj_nav.definesPresentationContext = YES;
    
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:obj_nav animated:YES completion:nil];
}

@end
