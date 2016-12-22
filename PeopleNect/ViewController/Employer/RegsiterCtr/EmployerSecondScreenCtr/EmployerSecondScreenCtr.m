//
//  EmployerSecondScreenCtr.m
//  PeopleNect
//
//  Created by Narendra Pandey on 29/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "EmployerSecondScreenCtr.h"


@interface EmployerSecondScreenCtr (){
    NSMutableArray *arrayData;
    NSMutableArray *arrayCity;
    NSMutableArray *arrayState,*arrayStateId,*arrayCityId;
    UIImagePickerController *imagePicker;
    UIImage *chosenImage;
    NSData *imgData,*dataProfileImg;
    NSString *EmployerUserID;    

}
@end

@implementation EmployerSecondScreenCtr
#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    EmployerUserID   = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"];
    _countryId = [[NSUserDefaults standardUserDefaults]stringForKey:@"countryId"];
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
        [self stateWebService];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


-(void)viewDidLayoutSubviews{
     _heightForContainerView.constant = self.view.frame.size.height;
}


#pragma mark - Unarchiving data
-(void)unarchivingData{
    NSData *registerData= [[NSUserDefaults standardUserDefaults] objectForKey:@"employerRegister"];
    if (registerData!=nil) {
     kAppDel.obj_responseDataOC = [NSKeyedUnarchiver unarchiveObjectWithData:registerData];
    }
}


#pragma mark - TextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == _tfCity){
        [SubViewCtr sharedInstance].obj_PickerView.delegate = self;
    [SubViewCtr sharedInstance].obj_PickerView.dataSource = self;
        [[SubViewCtr sharedInstance] toolBarPickerWithSelector:@selector(nextActionOnCity) Target:self];
        
       [SubViewCtr sharedInstance].obj_PickerView.tag =100;
        
        _tfCity.inputView = [SubViewCtr sharedInstance];
        
        if(arrayCity.count >0){
        _tfCity.text = [NSString stringWithFormat:@"%@",[[arrayCity objectAtIndex:0]objectAtIndex:0] ];
        }
        if(arrayCityId.count >0){
        self.cityId = [NSString stringWithFormat:@"%@",[[arrayCityId objectAtIndex:0]objectAtIndex:0] ];
        }
        else{
            [self stateWebService];
        }
    }
    if(textField == _tfState){
        [SubViewCtr sharedInstance].obj_PickerView.delegate = self;
        [SubViewCtr sharedInstance].obj_PickerView.dataSource = self;
        [[SubViewCtr sharedInstance] toolBarPickerWithSelector:@selector(nextActionOnState) Target:self];
        [SubViewCtr sharedInstance].obj_PickerView.tag =200;

        _tfState.inputView = [SubViewCtr sharedInstance];
        
        if(arrayState.count > 0){
        _tfState.text = [NSString stringWithFormat:@"%@",[[arrayState objectAtIndex:0]objectAtIndex:0] ];
        }
        
        if(arrayStateId.count>0){
        self.stateId = [NSString stringWithFormat:@"%@",[[arrayStateId objectAtIndex:0]objectAtIndex:0] ];
            [self cityWebServiceWithStateId:self.stateId];
        }
        else{
            [self stateWebService];
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == _tfCompanyName){
        [theTextField resignFirstResponder];
        [_tfZipCode becomeFirstResponder];
    }
    else if (theTextField == _tfZipCode){
        [_tfZipCode resignFirstResponder];
        [_tfState becomeFirstResponder];
    }
    else if (theTextField == _tfState){
        [_tfState resignFirstResponder];
        [_tfCity becomeFirstResponder];
    }
    else if (theTextField == _tfCity){
        [_tfCity resignFirstResponder];
        [_tfNumber becomeFirstResponder];
    }
    else if (theTextField == _tfNumber){
        [_tfNumber resignFirstResponder];
        [_tfComplement becomeFirstResponder];
    }
    else if (theTextField == _tfComplement){
        [_tfComplement resignFirstResponder];
    }
    return YES;
}


#pragma mark - Register Button
- (IBAction)onClickRegister:(id)sender {
    if(!imgData.length){
         [self presentViewController:[GlobalMethods AlertWithTitle:@"Company's photo name is required" Message:@"Please enter your company's photo" AlertMessage:@"OK"] animated:YES completion:nil];
    }
    else if(!_tfCompanyName.text.length){
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Company name is required" Message:@"Please enter your company name" AlertMessage:@"OK"] animated:YES completion:nil];
         }
    else if (!_tfZipCode.text.length){
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Zip code is required" Message:@"Please enter your zip code" AlertMessage:@"OK"] animated:YES completion:nil];
    }
    else if (!_tfState.text.length){
        [self presentViewController:[GlobalMethods AlertWithTitle:@"State  is required" Message:@"Please enter your state" AlertMessage:@"OK"] animated:YES completion:nil];
    }
    else if (!_tfCity.text.length){
        [self presentViewController:[GlobalMethods AlertWithTitle:@"City code  is required" Message:@"Please enter your city" AlertMessage:@"OK"] animated:YES completion:nil];
    }
        if(imgData.length>0 && _tfCompanyName.text.length>0 && _tfCity.text.length>0  && _tfState.text.length>0 &&_tfZipCode.text.length >0){
     
            if ([GlobalMethods InternetAvailability]) {
                
                kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
                
                NSData* imageData = UIImageJPEGRepresentation(chosenImage, 1.0);
                
                [self returnImage:[UIImage imageWithData:imageData]];
                
                [kAFClient POST:MAIN_URL parameters: [GlobalMethods UpdateEmployerWithID:EmployerUserID cityID:_cityId companyName:_tfCompanyName.text Name:kAppDel.obj_responseDataOC.employerName Phone:kAppDel.obj_responseDataOC.employerPhoneNumber StateID:_stateId Surname:kAppDel.obj_responseDataOC.employerSurname zipCode:_tfZipCode.text countryCode:kAppDel.obj_responseDataOC.employerCountryCode Streetname:@"" Password:[[NSUserDefaults standardUserDefaults] objectForKey:@"EmployerPassword"] Adress1:_tfNumber.text Address2:_tfComplement.text countryID:_countryId] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    [formData appendPartWithFileData:dataProfileImg name:@"profilepic" fileName:@"image.jpg" mimeType:@"image/jpeg"];
                    
                } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [kAppDel.progressHud hideAnimated:YES];
                    
                    if([[responseObject valueForKey:@"status"] isEqual:@1]){
                        kAppDel.obj_responseDataOC  = [[responseDataOC alloc] initWithDictionary:responseObject ];
                        
                        NSData *registerDataObject = [NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseDataOC];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:registerDataObject forKey:@"employerRegister"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:@"Register" forKey:@"Update"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        
                        MenuCtr *obj_MenuCtr  = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuCtr"];
                        [self.navigationController pushViewController:obj_MenuCtr animated:YES];
                    }
                    
                    else{
                        
                        [self presentViewController:[GlobalMethods AlertWithTitle:@"" Message:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"message"]] AlertMessage:@"OK"]animated:YES completion:nil];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [kAppDel.progressHud hideAnimated:YES];
                }];
            }else{
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
            }
        }
}


#pragma mark - Image Picker Button
- (IBAction)onClickImage:(id)sender {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate =self;
    imagePicker.allowsEditing = YES;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select One" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                            {
                                
                                [actionSheet dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
            {
                                
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    
                [self presentViewController:imagePicker animated:YES completion:nil];
                                    
                }else
                {
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Camera Missing" Message:@"It seems that no camera is attached to this device" AlertMessage:@"OK"]animated:YES completion:nil];
                        }
                                
            }]];
    
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                
                                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                
                                [self presentViewController:imagePicker animated:YES completion:nil];
                                
                            }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];

}


#pragma mark - Image Picker Delegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    chosenImage = info[UIImagePickerControllerEditedImage];
    [self.btnImage setImage:chosenImage forState:UIControlStateNormal];
      self.btnImage.layer.cornerRadius = self.btnImage.frame.size.height/2;
    
    self.btnImage.layer.masksToBounds = YES;
    imgData =  UIImageJPEGRepresentation(chosenImage, 1.0);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark - WebServices
-(void)stateWebService {
    
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
        [dict setObject:@"stateList" forKey:@"methodName"];
        [dict setObject:_countryId forKey:@"countryId"];
        
        arrayState =[[NSMutableArray alloc] init];
        arrayStateId = [[NSMutableArray alloc] init];
        [kAFClient POST:MAIN_URL parameters:dict progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject){
            [arrayState addObject:[[responseObject valueForKey:@"data" ]valueForKey:@"stateName"]];
            [arrayStateId addObject:[[responseObject valueForKey:@"data" ]valueForKey:@"stateId"]];
        }
                failure:^(NSURLSessionDataTask   *task, NSError  * error) {
                    [kAppDel.progressHud hideAnimated:YES];
                }];
        
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}


-(void)cityWebServiceWithStateId:(NSString *)stateId{
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"cityList" forKey:@"methodName"];
        [dict setObject:stateId forKey:@"stateId"];
        arrayCity =[[NSMutableArray alloc] init];
        arrayCityId = [[NSMutableArray alloc] init];
        [kAFClient POST:MAIN_URL parameters:dict progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject){
            [arrayCity addObject:[[responseObject valueForKey:@"data" ]valueForKey:@"cityName"]];
            [arrayCityId addObject:[[responseObject valueForKey:@"data" ]valueForKey:@"cityId"]];
        }
                failure:^(NSURLSessionDataTask   *task, NSError  * error) {
                    [kAppDel.progressHud hideAnimated:YES];
                }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
}


#pragma mark - Picker DataSource
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
        if(pickerView.tag == 100){
            
                [[SubViewCtr sharedInstance].activityIndicator stopAnimating];
                return [[arrayCity objectAtIndex:0]count];
            
        }
        if(pickerView.tag == 200){
            
                [[SubViewCtr sharedInstance].activityIndicator stopAnimating];
                 return [[arrayState objectAtIndex:0]count];
           
        }
        return 0;
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
        if(pickerView.tag == 100){
            return [NSString stringWithFormat:@"%@",[[arrayCity objectAtIndex:0] objectAtIndex: row]];
        }
        if(pickerView.tag == 200){
            return[NSString stringWithFormat:@"%@",[[arrayState objectAtIndex:0] objectAtIndex:row]];
        }
        return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
        if(pickerView.tag == 200){
        
        _tfState.text =[NSString stringWithFormat:@"%@",[[arrayState objectAtIndex:0] objectAtIndex:row]];
        _stateId =[NSString stringWithFormat:@"%@",[[arrayStateId objectAtIndex:0] objectAtIndex:row]];
        [self cityWebServiceWithStateId:self.stateId];
        }
    
        if(pickerView.tag == 100){
            _tfCity.text =[NSString stringWithFormat:@"%@",[[arrayCity objectAtIndex:0] objectAtIndex:row]];
            _cityId =[NSString stringWithFormat:@"%@",[[arrayCityId objectAtIndex:0] objectAtIndex:row]];
        }
    
}


#pragma  mark - ToolBar Method
-(void)nextActionOnState{
    [_tfState resignFirstResponder];
    [_tfCity becomeFirstResponder];
}


-(void)nextActionOnCity{
    [_tfCity resignFirstResponder];
    [_tfNumber becomeFirstResponder];
}

#pragma Mark - Image
-(NSData*)returnImage :(UIImage *)img
{
    dataProfileImg = UIImageJPEGRepresentation(img, 1.0);
    return dataProfileImg;
}
@end
