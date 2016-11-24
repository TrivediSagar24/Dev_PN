//
//  employerSettings.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//
#import "SubViewCtr.h"
#import "employerSettings.h"

@interface employerSettings (){
    NSMutableArray *arrayState,*arrayStateId,*arrayCityId,*arrayData,*arrayCity;
    UIImage *chosenImage;
    NSData *Details;
    UIImageView *profileImageView;
    NSArray *json;
    CLLocationCoordinate2D Location;
}
@end

@implementation employerSettings
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    _tfStreetName.placeSearchDelegate = self;
    _tfStreetName.delegate = self;
    _tfStreetName.strApiKey = @"AIzaSyB9U-Ssv6A9Tt2keQtZyWMuadHoELYeGlk";
    
    _tfStreetName.superViewOfList = self.view;
    _tfStreetName.autoCompleteShouldHideOnSelection = YES;
    _tfStreetName.maximumNumberOfAutoCompleteRows = 5;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self unarchivingData];
    
    _tfName.text = kAppDel.obj_responseDataOC.employerName;
    _tfSurname.text = kAppDel.obj_responseDataOC.employerSurname;
    _tfEmail.text = kAppDel.obj_responseDataOC.employerEmail;
    
    _tfEmail.userInteractionEnabled = NO;
    _tfCountryCode.userInteractionEnabled = NO;
    _tfEmail.textColor = [UIColor grayColor];
    _tfCountryCode.textColor = [UIColor grayColor];
    
    _tfPhoneNumber.text = kAppDel.obj_responseDataOC.employerPhoneNumber;
    _tfCountryCode.text = kAppDel.obj_responseDataOC.employerCountryCode;
    _tfPassword.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"EmployerPassword"];
    _tfCompanyName.text = kAppDel.obj_responseDataOC.employerCompanyName;
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.btnCamera.layer.cornerRadius = self.btnCamera.frame.size.height/2;
    self.btnCamera.layer.masksToBounds = YES;
    if (kAppDel.EmployerProfileImage!=nil){
        self.btnCamera.layer.borderWidth = 1;
        self.btnCamera.layer.borderColor = [UIColor colorWithRed:220/255 green:220/255 blue:220/255 alpha:1.0].CGColor;
        }
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    profileImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_btnCamera.frame.origin.x, _btnCamera.frame.origin.y, _btnCamera.frame.size.width, _btnCamera.frame.size.height)];
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2;
        profileImageView.layer.masksToBounds = YES;
        if (kAppDel.EmployerProfileImage==nil) {
            profileImageView.image = [UIImage imageNamed:@"profile"];
        }else{
            profileImageView.image = kAppDel.EmployerProfileImage;
        }
        [_profileView addSubview:profileImageView];
    
    
    
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

    _tfStreetName.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_tfStreetName.frame.size.width)*0.5, _tfName.frame.origin.y, _tfCompanyName.frame.size.width, 100.0);
}


#pragma mark - UITextField Delegates -
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    if (theTextField == _tfName){
        [theTextField resignFirstResponder];
        [_tfSurname becomeFirstResponder];
    }
else if (theTextField == _tfSurname){
        [_tfSurname resignFirstResponder];
        [_tfPhoneNumber becomeFirstResponder];
    }
    else if (theTextField == _tfPhoneNumber)
    {
        [_tfPhoneNumber resignFirstResponder];
        [_tfPassword becomeFirstResponder];
    }
    else if (theTextField == _tfPassword)
    {
        [_tfPassword resignFirstResponder];
        [_tfCompanyName becomeFirstResponder];
    }
    else if (theTextField == _tfCompanyName)
    {
        [_tfCompanyName resignFirstResponder];
        [_tfStreetName becomeFirstResponder];
    }
    else if (theTextField == _tfStreetName)
    {
        [_tfStreetName resignFirstResponder];
        [_tfStreetNumber becomeFirstResponder];
    }
    else if (theTextField == _tfStreetNumber)
    {
        [_tfStreetNumber resignFirstResponder];
        [_tfComplement becomeFirstResponder];
    }
    else if (theTextField == _tfComplement)
    {
        [_tfComplement resignFirstResponder];
        [_tfZipCode becomeFirstResponder];
    }
    else if (theTextField == _tfZipCode)
    {
        [_tfZipCode resignFirstResponder];
        [_tfState becomeFirstResponder];
    }
    
    else if (theTextField == _tfState)
    {
        [_tfState resignFirstResponder];
        [_tfCity becomeFirstResponder];
    }
    else if (theTextField==_tfCity){
        [_tfCity resignFirstResponder];
    }
    return YES;
}


#pragma mark - SlideNavigationController Methods -
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}
- (BOOL)slideNavigationControllerShouldDisplayRightMenu{
    return NO;
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


#pragma mark - IBActions -
- (IBAction)btnCameraClicked:(id)sender{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate =self;
    _imagePicker.allowsEditing = YES;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select One" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                    {
    [self dismissViewControllerAnimated:YES completion:^{
                                }];
                }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_imagePicker animated:YES completion:nil];
        }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Camera Missing" Message:@"It seems that no camera is attached to this device" AlertMessage:@"OK"]animated:YES completion:nil];
            }
        }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:nil];
        }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}


- (IBAction)SaveClicked:(id)sender {
    NSData* imageData;
    
    if (chosenImage!=nil) {
      imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
    }else{
        imageData = UIImageJPEGRepresentation(kAppDel.EmployerProfileImage, 1.0);
    }
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
   
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    [_param setObject:@"updateEmployersDetails" forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    
     [_param setObject:_tfName.text forKey:@"name"];
    
    [_param setObject:_tfSurname.text forKey:@"surname"];
    
     [_param setObject:_tfPhoneNumber.text forKey:@"phone"];
    
      [_param setObject:_tfCompanyName.text forKey:@"company_name"];
    
    [_param setObject:_tfCountryCode.text forKey:@"countryId"];
    
    [_param setObject:_tfZipCode.text forKey:@"zip"];
   
    [_param setObject:_tfState.text forKey:@"stateId"];
   
    [_param setObject:_tfCity.text  forKey:@"cityId"];
    
 
    [_param setObject:_tfCountryCode.text forKey:@"country_code"];
   
    [_param setObject:_tfStreetName.text forKey:@"street_name"];
    
    [_param setObject:_tfStreetNumber.text forKey:@"address1"];
    [_param setObject:_tfComplement.text forKey:@"address2"];

    [_param setObject:_tfPassword.text forKey:@"password"];
    
    [kAFClient POST:MAIN_URL parameters:_param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         [formData appendPartWithFileData:imageData name:@"profilepic" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [kAppDel.progressHud hideAnimated:YES];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [kAppDel.progressHud hideAnimated:YES];

    }];
    
    
}
#pragma mark - ImagePicker Delegates.

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    chosenImage = info[UIImagePickerControllerEditedImage];
    
//    [self.btnCamera setImage:chosenImage forState:UIControlStateNormal];
    kAppDel.EmployerProfileImage = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Unarchiving data -
-(void)unarchivingData{
    
    Details = [[NSUserDefaults standardUserDefaults] objectForKey:@"employerDetails"];
    if (Details==nil) {
        [self GetUSerDetail];
    }
    else{
        if (Details!=nil) {
             kAppDel.obj_EmployerDetails = [NSKeyedUnarchiver unarchiveObjectWithData:Details];
        }
        [self Setdata];
    }
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Update"]isEqualToString:@"Login"])
    {
        NSData *loginData= [[NSUserDefaults standardUserDefaults] objectForKey:@"employerLogin"];
        if (loginData!=nil) {
            kAppDel.obj_responseDataOC = [NSKeyedUnarchiver unarchiveObjectWithData:loginData];
        }
    }
    else{
        NSData *registerData= [[NSUserDefaults standardUserDefaults] objectForKey:@"employerRegister"];
        if (registerData!=nil) {
           kAppDel.obj_responseDataOC = [NSKeyedUnarchiver unarchiveObjectWithData:registerData];
        }
    }
}

#pragma mark - Get USer Detail -

-(void)GetUSerDetail{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [_param setObject:@"employersDetails" forKey:@"methodName"];
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        [kAppDel.progressHud hideAnimated:YES];
        
        kAppDel.obj_EmployerDetails = [[EmployerDetails alloc] initWithDictionary:responseObject];
        
        Details = [NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_EmployerDetails];

        [[NSUserDefaults standardUserDefaults] setObject:Details  forKey:@"employerDetails"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if (Details!=nil) {
            Details = [[NSUserDefaults standardUserDefaults] objectForKey:@"employerDetails"];
           kAppDel.obj_EmployerDetails = [NSKeyedUnarchiver unarchiveObjectWithData:Details];
        }

        [self Setdata];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
    }];
}

-(void)Setdata{
    _tfZipCode.text = kAppDel.obj_responseDataOC.employerZipCode;
    _tfStreetNumber.text = kAppDel.obj_responseDataOC.employerNumber;
    _tfZipCode.text = kAppDel.obj_EmployerDetails.ZipCode;
    _tfState.text = kAppDel.obj_EmployerDetails.StateName;
    _tfCity.text = kAppDel.obj_EmployerDetails.cityName;
    _tfStreetNumber.text = kAppDel.obj_EmployerDetails.address1;
    _tfStreetName.text = kAppDel.obj_EmployerDetails.streetName;
    _tfComplement.text = kAppDel.obj_EmployerDetails.address2;
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
                _tfState.text = [[dict valueForKey:@"long_name"]objectAtIndex:i];
    }
    if ([type containsObject:@"administrative_area_level_2"]) {
                    _tfCity.text = [[dict valueForKey:@"long_name"]objectAtIndex:i];
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
