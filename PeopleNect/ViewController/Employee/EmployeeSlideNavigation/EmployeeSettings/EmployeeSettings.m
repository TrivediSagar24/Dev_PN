//
//  EmployeeSettings.m
//  PeopleNect
//
//  Created by Narendra Pandey on 8/16/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "EmployeeSettings.h"
@interface EmployeeSettings ()
{
    UITapGestureRecognizer *imageSelected;
    NSData *dataProfileImg,*employeeUserDetailData;;
    UIImage *chosenImage;
    UITapGestureRecognizer *tapGesture;
    NSTimer *Timer;
}
@end

@implementation EmployeeSettings
#pragma mark - View Life Cycle -
- (void)viewDidLoad{
    [super viewDidLoad];
     employeeUserDetailData= [[NSUserDefaults standardUserDefaults] objectForKey:@"employeeUserDetail"];
    
    if (employeeUserDetailData!=nil) {
         kAppDel.obj_responseEmployeeUserDetail = [NSKeyedUnarchiver unarchiveObjectWithData:employeeUserDetailData];
        [self updateValues];
    }
    if ([kAppDel.obj_CountryCode.countryCode count]==0)
    {
        Timer = [NSTimer scheduledTimerWithTimeInterval: 0.3 target: self selector:@selector(countryCodeWebService)userInfo: nil repeats:NO];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_strCategory.length>0)
    {
        _tfCategory.text = _strCategory;
        _tfSubCategory.text = _strSubCategory;
    }

    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    if (kAppDel.EmployeeProfileImage==nil) {
        _EmployeeProfileImage.image = [UIImage imageNamed:@"plceholder"];
    }else{
    _EmployeeProfileImage.image =  kAppDel.EmployeeProfileImage;
    }
    _EmployeeProfileImage.layer.cornerRadius = _EmployeeProfileImage.frame.size.height/2;
    _EmployeeProfileImage.layer.masksToBounds = YES;
    _EmployeeProfileImage.layer.borderWidth = 1.0;
    _EmployeeProfileImage.layer.borderColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor;
}

-(void)viewDidAppear:(BOOL)animated{
    _EmployeeProfileImage.layer.cornerRadius = _EmployeeProfileImage.frame.size.height/2;
    _saveBtn.frame = CGRectMake(_saveBtn.frame.origin.x, _tfPassword.frame.origin.y+_tfPassword.frame.size.height+15, _saveBtn.frame.size.width, _saveBtn.frame.size.height);
    if (_tfPassword.hidden){
        _saveBtn.frame = CGRectMake(_saveBtn.frame.origin.x, _tfPassword.frame.origin.y, _saveBtn.frame.size.width, _saveBtn.frame.size.height);
    }
    if ([kAppDel.EmployeeSettingText count]>0){
        _tfName.text = [kAppDel.EmployeeSettingText valueForKey:@"name"];
        _tfSurname.text =[kAppDel.EmployeeSettingText valueForKey:@"surName"];
        _tfCountryCode.text = [kAppDel.EmployeeSettingText valueForKey:@"countryCode"];
        _tfPhoneNumber.text =  [kAppDel.EmployeeSettingText valueForKey:@"phoneNo"];
        _tfExperience.text = [kAppDel.EmployeeSettingText valueForKey:@"exp"];
        _tfPriceHour.text = [kAppDel.EmployeeSettingText valueForKey:@"price"];
        _zipcode.text = [kAppDel.EmployeeSettingText valueForKey:@"zipCode"];
        _streetName.text = [kAppDel.EmployeeSettingText valueForKey:@"streetName"];
        _streetNumber.text = [kAppDel.EmployeeSettingText valueForKey:@"streetNumber"];
        _profileDescriptionTV.text = [kAppDel.EmployeeSettingText valueForKey:@"description"];
    }
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CategorySelection)];
    
    [_tfCategory addGestureRecognizer:tapGesture];
}
#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

#pragma mark - IBActions -
- (IBAction)SaveUserDetailClicked:(id)sender
{
    if (_strSubCategoryId.length==0){
        _strSubCategoryId = kAppDel.obj_responseEmployeeUserDetail.Employee_sub_category_id;
    }
    if (_strCategoryId.length==0)
    {
        _strCategoryId = kAppDel.obj_responseEmployeeUserDetail.Employee_category_id;
        
        kAppDel.categorySelectionID = kAppDel.obj_responseEmployeeUserDetail.Employee_category_id;

    }
    if (_Exp.length ==0)
    {
        _Exp = [kAppDel.obj_responseEmployeeUserDetail.Employee_exp_years stringByReplacingOccurrencesOfString:@".00" withString:@""];
    }
    if (_Price.length==0)
    {
        _Price = kAppDel.obj_responseEmployeeUserDetail.Employee_hourly_compensation;
    }
    
    if ([GlobalMethods InternetAvailability]) {
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        
        NSData* imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
        if (imageData==nil)
        {
            imageData =  UIImageJPEGRepresentation(kAppDel.EmployeeProfileImage, 1.0);
        }
        [self returnImage:[UIImage imageWithData:imageData]];
        
        [kAFClient POST:MAIN_URL parameters:[GlobalMethods EmployeeSaveUserDetail:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] firstname:_tfName.text lastName:_tfSurname.text phone:_tfPhoneNumber.text categoryId:_strCategoryId subCategoryId:_strSubCategoryId experience:_Exp rate:_Price description:_profileDescriptionTV.text password:_tfPassword.text zipcode:_zipcode.text streetName:_streetName.text number:_streetNumber.text country_code:_tfCountryCode.text lastEmployer:@""] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             [formData appendPartWithFileData:dataProfileImg name:@"profile_pic" fileName:@"image.jpg" mimeType:@"image/jpeg"];
             
         } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [kAppDel.progressHud hideAnimated:YES];
             
             kAppDel.obj_responseEmployeeUserDetail = [[responseEmployeeUserDetail alloc]initWithDictionary:responseObject];
             
             
             if ([[responseObject valueForKey:@"status"] isEqual:@1]) {
                 
                 if (kAppDel.EmployeeProfileImage==nil) {
                     kAppDel.EmployeeProfileImage = _EmployeeProfileImage.image;
                     
                 }
                 [self presentViewController:[GlobalMethods AlertWithTitle:@"" Message:[responseObject valueForKey:@"message"] AlertMessage:@"OK"] animated:YES completion:nil];
             }
           
              employeeUserDetailData =[NSKeyedArchiver archivedDataWithRootObject: kAppDel.obj_responseEmployeeUserDetail];
              [[NSUserDefaults standardUserDefaults] setObject:employeeUserDetailData forKey:@"employeeUserDetail"];
              [[NSUserDefaults standardUserDefaults] synchronize];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
             [kAppDel.progressHud hideAnimated:YES];
         }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}

#pragma mark - Textfield Delegates -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _tfCategory)
    {
        return NO;
    }
    
    if (textField == _tfExperience)
    {
        textField.text = [kAppDel.obj_responseEmployeeUserDetail.Employee_exp_years stringByReplacingOccurrencesOfString:@".00" withString:@""];
    }
    
    if (textField == _tfPriceHour)
    {
        textField.text = kAppDel.obj_responseEmployeeUserDetail.Employee_hourly_compensation;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    if (textField == _tfExperience)
    {
        _Exp = textField.text;
        
        _tfExperience.text = [NSString stringWithFormat:@"%@ Years of exp",_Exp];
    }
    
    if (textField == _tfPriceHour)
    {
        _Price = textField.text;
        
        _tfPriceHour.text = [NSString stringWithFormat:@"  R$ %@/h",_Price];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == _tfCountryCode)
    {
        _tfCountryCode.inputView = [SubViewCtr sharedInstance];
        
        [SubViewCtr sharedInstance].obj_PickerView.delegate = self;
        
        [SubViewCtr sharedInstance].obj_PickerView.dataSource = self;
        
        [[SubViewCtr sharedInstance]
         
         toolBarPickerWithSelector:@selector(next) Target:self];
    }
}


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
        [_tfCountryCode becomeFirstResponder];

    }
    else if (theTextField == _tfCountryCode)
    {
        [_tfCountryCode resignFirstResponder];
        [_tfPhoneNumber becomeFirstResponder];
    }
    else if (theTextField == _tfPhoneNumber)
    {
        [_tfPhoneNumber resignFirstResponder];
        [_tfCategory becomeFirstResponder];
    }
    else if (theTextField == _tfCategory)
    {
        [_tfCategory resignFirstResponder];
        [_tfExperience becomeFirstResponder];
    }
    else if (theTextField == _tfExperience)
    {
        [_tfExperience resignFirstResponder];
        [_tfPriceHour becomeFirstResponder];
    }
    else if (theTextField == _tfPriceHour)
    {
        [_tfPriceHour resignFirstResponder];
        [_zipcode becomeFirstResponder];
    }
    else if (theTextField == _zipcode)
    {
        [_zipcode resignFirstResponder];
        [_streetName becomeFirstResponder];
    }
    else if (theTextField == _streetName){
        [_streetName resignFirstResponder];
        [_streetNumber becomeFirstResponder];
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

#pragma mark - TextField Values -

-(void)updateValues
{
    _tfName.text = kAppDel.obj_responseEmployeeUserDetail.Employee_first_name;
    
    _tfSurname.text = kAppDel.obj_responseEmployeeUserDetail.Employee_last_name;
    
    _tfEmail.text = kAppDel.obj_responseEmployeeUserDetail.Employee_email;
    _tfEmail.userInteractionEnabled = NO;
    
   // _tfCountryCode.enabled = NO;
    
    _tfPhoneNumber.text = kAppDel.obj_responseEmployeeUserDetail.Employee_phone;
    
    _tfCountryCode.text = kAppDel.obj_responseEmployeeUserDetail.Employee_country_code;
    
    _tfCategory.text = [NSString stringWithFormat:@"%@",kAppDel.obj_responseEmployeeUserDetail.Employee_category_name];
    
    _tfSubCategory.text = [NSString stringWithFormat:@"%@",kAppDel.obj_responseEmployeeUserDetail.Employee_sub_category_name];
    
    _tfSubCategory.userInteractionEnabled = NO;
    
    _tfExperience.text = [NSString stringWithFormat:@"%@Years of exp",[kAppDel.obj_responseEmployeeUserDetail.Employee_exp_years stringByReplacingOccurrencesOfString:@".00" withString:@""]];
    
    _tfPriceHour.text = [NSString stringWithFormat:@"   R$ %@/h",kAppDel.obj_responseEmployeeUserDetail.Employee_hourly_compensation];
    
    _zipcode.text = kAppDel.obj_responseEmployeeUserDetail.Employee_zipcode;
    
    _streetName.text = kAppDel.obj_responseEmployeeUserDetail.Employee_streetName;
    
    _profileDescriptionTV.text = kAppDel.obj_responseEmployeeUserDetail.Employee_profile_description;
    
    _streetNumber.text = kAppDel.obj_responseEmployeeUserDetail.Employee_number;
    
    if ([[NSUserDefaults standardUserDefaults]
         stringForKey:@"EmployeePassword"].length>0)
    {
    _tfPassword.text = [[NSUserDefaults standardUserDefaults]
                stringForKey:@"EmployeePassword"];
    }
    else
    {
        _tfPassword.hidden = YES;
    }
    
    _EmployeeProfileImage.userInteractionEnabled = YES;
    
    imageSelected = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(selectImage)];
    
    [_EmployeeProfileImage addGestureRecognizer:imageSelected];
}

-(void)selectImage
{
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
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                            {
                        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    [self presentViewController:_imagePicker animated:YES completion:nil];
                                }
                                else
                                {
                                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Camera Missing" Message:@"It seems that no camera is attached to this device" AlertMessage:@"OK"]animated:YES completion:nil];
                                }
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                [self presentViewController:_imagePicker animated:YES completion:nil];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - ImagePicker Delegates. -

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   chosenImage = info[UIImagePickerControllerEditedImage];
    
    self.EmployeeProfileImage.image = chosenImage;
    
    kAppDel.EmployeeProfileImage = chosenImage;
   
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Picker -

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    if ([kAppDel.obj_CountryCode.countryCode count]>0) {
        [[SubViewCtr sharedInstance].activityIndicator stopAnimating];
    }
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
    _tfCountryCode.text =[NSString stringWithFormat:@"+%@",[kAppDel.obj_CountryCode.countryCode objectAtIndex:row]];
}


#pragma mark - Picker ToolBar Next button -

-(void)next
{
    [_tfCountryCode resignFirstResponder];
    [_tfPhoneNumber becomeFirstResponder];
}

#pragma mark - Country CodeWebService -
-(void)countryCodeWebService
{
    /*----Getting country code---*/
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"countryCodeList" forKey:@"methodName"];
    
    [kAFClient POST:MAIN_URL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        kAppDel.obj_CountryCode
        = [[CountryCode alloc] initWithDictionary:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

#pragma mark - Image -
-(NSData*)returnImage :(UIImage *)img
{
    dataProfileImg = UIImageJPEGRepresentation(img, 1.0);
    
    return dataProfileImg;
}

#pragma mark - Category -
-(void)CategorySelection
{
//    [[NSUserDefaults standardUserDefaults ]setObject:@"True" forKey:@"Setting"];
//    
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    kAppDel.EmployeeSettingText = [[NSMutableDictionary alloc]init];
    [kAppDel.EmployeeSettingText setValue:_tfName.text
                                   forKey:@"name"];
    [kAppDel.EmployeeSettingText setValue:_tfSurname.text
                                   forKey:@"surName"];
    [kAppDel.EmployeeSettingText setValue:_tfCountryCode.text
                                   forKey:@"countryCode"];
    [kAppDel.EmployeeSettingText setValue:_tfPhoneNumber.text
                                   forKey:@"phoneNo"];
    [kAppDel.EmployeeSettingText setValue:_tfExperience.text
                                   forKey:@"exp"];
    [kAppDel.EmployeeSettingText setValue:_tfPriceHour.text
                                   forKey:@"price"];

    [kAppDel.EmployeeSettingText setValue:_zipcode.text forKey:@"zipCode"];

    [kAppDel.EmployeeSettingText setValue:_streetName.text forKey:@"streetName"];
    
    [kAppDel.EmployeeSettingText setValue:_streetNumber.text forKey:@"streetNumber"];
    
    [kAppDel.EmployeeSettingText setValue:_profileDescriptionTV.text forKey:@"description"];
    
    kAppDel.categorySelectionID = kAppDel.obj_responseEmployeeUserDetail.Employee_category_id;

    CategoryEmployeeCtr * obj_CategoryEmployeeCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
    
    obj_CategoryEmployeeCtr.iscomingFromSettingCtr = YES;
    obj_CategoryEmployeeCtr.selectedCategoryId = kAppDel.obj_responseEmployeeUserDetail.Employee_category_id;
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"Category" forKey:@"EmployeeCategory"];
//    
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController pushViewController:obj_CategoryEmployeeCtr animated:YES];
}
@end
