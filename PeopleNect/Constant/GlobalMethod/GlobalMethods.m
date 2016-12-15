//
//  GlobalMethods.m
//  PeopleNect
//
//  Created by Apple on 29/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "GlobalMethods.h"
#import "PN_Constants.h"
@implementation GlobalMethods

/*---customNavigationBarButton----*/


+(UIBarButtonItem *)customNavigationBarButton:(SEL)selector Target:(UIViewController *)targetView Image:(NSString *)imageName;

{
    UIBarButtonItem *backBarItem;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [button addTarget:targetView action:selector forControlEvents:UIControlEventTouchUpInside];
    
    backBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return backBarItem;
}
/*---validateEmailWithString----*/

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*----------------Alert Controller---------------*/

+(UIAlertController *)AlertWithTitle:(NSString*)Title Message:(NSString *)Message AlertMessage:(NSString*)AlertMessage
{
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertCtr addAction:[UIAlertAction actionWithTitle:AlertMessage style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    
    return alertCtr;
}


/*----------------EmployeeLogin----------------*/

+(NSDictionary*)EmployeeLoginWithEmail :(NSString*)Email Password:(NSString*)Password DeviceId:(NSString *)deviceId
{
    
     NSMutableDictionary  *_params = [[NSMutableDictionary alloc]init];


[_params setObject:@"login"  forKey:@"methodName"];
    
[_params setObject:Email  forKey:@"email"];
    
[_params setObject:Password  forKey:@"password"];

[_params setObject:DevideID  forKey:@"deviceId"];


    return _params;
    
}


/*----------------EmployeeRegister----------------*/

+(NSDictionary *)EmployeeRegisterWith:(NSString *)registerWith Email:(NSString *)Email Name:(NSString *)Name Surname:(NSString *)Surname Password :(NSString *)password Phone:(NSString *)phone DevideId:(NSString *)deviceId Access_Token:(NSString *)access_token Access_identifire:(NSString *)Access_identifire ZipCode:(NSString *)zipcode StreetName :(NSString *)streetName StreetNumber :(NSString *)StreetNumber countryCode :(NSString *)CountryCode

{
  NSMutableDictionary  *_params = [[NSMutableDictionary alloc]init];
    
    [_params setObject:@"register"  forKey:@"methodName"];
    
    [_params setObject:registerWith  forKey:@"registerWith"];
    
    [_params setObject:Email  forKey:@"email"];
    
    [_params setObject:Name  forKey:@"name"];
    
    [_params setObject:Surname  forKey:@"surname"];
    
    [_params setObject:password  forKey:@"password"];
    
    [_params setObject:phone  forKey:@"phone"];
    
    [_params setObject:DevideID forKey:@"deviceId"];
    
    [_params setObject:access_token  forKey:@"access_token"];
    
    [_params setObject:Access_identifire forKey:@"access_identifier"];
    
    [_params setObject:zipcode  forKey:@"zipcode"];
    
    [_params setObject:streetName  forKey:@"streetName"];
    
    [_params setObject:StreetNumber  forKey:@"number"]
    ;

    [_params setObject:CountryCode  forKey:@"country_code"];
    
    return _params;
}


/*------------EmployeeSaveUserDetail----------------*/

+(NSDictionary *)EmployeeSaveUserDetail:(NSString *)userId firstname:(NSString *)firstname lastName:(NSString *)lastName phone:(NSString *)PhoneNo categoryId :(NSString *)categoryId subCategoryId:(NSString *)subCategoryId experience:(NSString *)experience rate:(NSString *)rate description:(NSString *)description password:(NSString *)password zipcode :(NSString *)zipcode streetName :(NSString *)streetName number :(NSString *)number country_code :(NSString *)country_code lastEmployer:(NSString*)lastEmployer
{
NSMutableDictionary  *_params = [[NSMutableDictionary alloc]init];
    [_params setObject:@"updateUserDetails"  forKey:@"methodName"];
    [_params setObject:userId  forKey:@"userId"];
    [_params setObject:firstname  forKey:@"firstName"];
    [_params setObject:lastName  forKey:@"lastName"];
    [_params setObject:PhoneNo  forKey:@"phone"];
    [_params setObject:categoryId  forKey:@"categoryId"];
    [_params setObject:subCategoryId  forKey:@"subCategoryId"];
    [_params setObject:experience  forKey:@"experience"];
    [_params setObject:rate  forKey:@"rate"];
    [_params setObject:description  forKey:@"description"];
    [_params setObject:password  forKey:@"password"];
    [_params setObject:zipcode  forKey:@"zipcode"];
    [_params setObject:streetName  forKey:@"streetName"];
    [_params setObject:number  forKey:@"number"];
    [_params setObject:country_code forKey:@"country_code"];
    
    [_params setObject:lastEmployer forKey:@"lastEmployer"];
    
    return _params;
}


+(NSDictionary *)EmployerRegister:(NSString *)deviceId email:(NSString *)email name:(NSString *)name password:(NSString *)Password phone:(NSString *)phone surname:(NSString *)surname countryCode:(NSString *)CountryCode{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [_param setObject:@"registerEmployer"  forKey:@"methodName"];
    [_param setObject:DevideID  forKey:@"deviceId"];
    [_param setObject:email  forKey:@"email"];
    [_param setObject:name  forKey:@"name"];
    [_param setObject:Password  forKey:@"password"];
    [_param setObject:phone  forKey:@"phone"];
    [_param setObject:surname  forKey:@"surname"];
    [_param setObject:CountryCode  forKey:@"country_code"];
    return _param;
}

+(MBProgressHUD *)ShowProgressHud :(UIView *)view
{
  MBProgressHUD* progressHud = [MBProgressHUD showHUDAddedTo:kAppDel.window animated:YES];
    
    
    progressHud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    return progressHud;
}


+(NSDictionary *)UpdateEmployerWithID:(NSString *)EmployerId cityID:(NSString *)cityID companyName:(NSString *)CompanyName Name:(NSString *)Name Phone:(NSString *)Phone StateID:(NSString *)StateID Surname:(NSString *)Surname zipCode:(NSString *)zipCode countryCode:(NSString *)countryCode Streetname:(NSString *)StreetName Password:(NSString *)Password Adress1:(NSString *)Address1 Address2:(NSString *)Address2 countryID:(NSString *)countryID
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [_param setObject:cityID  forKey:@"cityId"];
    [_param setObject:CompanyName  forKey:@"company_name"];
    [_param setObject:EmployerId  forKey:@"employerId"];
    [_param setObject:@"updateEmployersDetails"  forKey:@"methodName"];
    [_param setObject:Name  forKey:@"name"];
    [_param setObject:Phone  forKey:@"phone"];
    [_param setObject:StateID forKey:@"stateId"];
    [_param setObject:Surname forKey:@"surname"];
    [_param setObject:zipCode forKey:@"zip"];
    [_param setObject:countryCode forKey:@"country_code"];
    [_param setObject:StreetName forKey:@"street_name"];
    [_param setObject:Password forKey:@"password"];
    [_param setObject:Address1 forKey:@"address1"];
    [_param setObject:Address2 forKey:@"address2"];
    [_param setObject:countryID forKey:@"countryId"];
    return _param;
}


+(NSDictionary *)updateDeviceTokenWithUserType:(NSString *)UserType DeviceToken:(NSString *)DeviceToken userId:(NSString *)userId{
  
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [_param setObject:@"updateDeviceToken" forKey:@"methodName"];
    [_param setObject:UserType forKey:@"userType"];
    [_param setObject:DeviceToken forKey:@"deviceToken"];
    [_param setObject:userId forKey:@"userId"];
    return _param;
}

+(void)dataTaskCancel
{
    for (NSURLSessionDataTask *dataTaskObj in kAFClient.dataTasks)
    {
        [kAppDel.progressHud hideAnimated:YES];
        
        [dataTaskObj cancel];
    }
}

+(BOOL)InternetAvailability{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


+(NSMutableArray *)SortArray : (NSMutableArray *)arrOriginal
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES
        comparator:^(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
        }];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [arrOriginal
                   sortedArrayUsingDescriptors:sortDescriptors];
    [arrOriginal removeAllObjects];
    [arrOriginal addObjectsFromArray:sortedArray];
    return arrOriginal;
}

@end
