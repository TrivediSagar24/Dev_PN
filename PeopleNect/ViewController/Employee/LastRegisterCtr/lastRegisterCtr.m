//
//  lastRegisterCtr.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/3/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "lastRegisterCtr.h"

@interface lastRegisterCtr ()
{
    NSData *dataProfileImg;
    UITapGestureRecognizer *tap;
}
@end
@implementation lastRegisterCtr
@synthesize imagePicker;
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self TapGesture];
    [self.btnCamera setImage:kAppDel.EmployeeProfileImage forState:UIControlStateNormal];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.btnCamera.layer.cornerRadius = self.btnCamera.frame.size.height/2;
    self.btnCamera.layer.masksToBounds = YES;
//    self.btnCamera.layer.borderWidth = 1;
//    self.btnCamera.layer.borderColor = [UIColor colorWithRed:220/255 green:220/255 blue:220/255 alpha:1.0].CGColor;
 self.btnCamera.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  
    [self.btnCamera setImage:kAppDel.EmployeeProfileImage forState:UIControlStateNormal];
}
#pragma mark - IBAction -
- (IBAction)backBarButtonTapped:(id)sender
{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
    {
        if ([viewControllrObj isKindOfClass:[subCategoryCtr class]])
        {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }
}
- (IBAction)finishRegisterClicked:(id)sender
{
    BOOL registerflag;
    registerflag = NO;
     NSData* imageData = UIImageJPEGRepresentation(kAppDel.EmployeeProfileImage, 1.0);
    if (imageData.length ==0)
    {
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Profile pic is required" Message:@"Please select your profile pic" AlertMessage:@"OK"]animated:YES completion:nil];
    }
    else
    {
        if (_tfExpYear.text.length == 0)
        {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Exp year is required" Message:@"Please Enter experience year" AlertMessage:@"OK"]animated:YES completion:nil];
        }
        else
        {
            if (_tfHourlyCompensate.text.length == 0)
            {
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Hourly compensation is required" Message:@"Please enter hourly compensation" AlertMessage:@"OK"]animated:YES completion:nil];
            }
            else
            {
                if ([_tviewDescribe.text isEqualToString:@"Describe your profile" ])
                {
                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Describe yourself field is required" Message:@"Please describe yourself" AlertMessage:@"OK"]animated:YES completion:nil];
                }
                else
                {
                    registerflag = YES;
                }
            }
        }
}
    
    
    if (registerflag==YES)
    {
        
        if ([GlobalMethods InternetAvailability]) {
            kAppDel.progressHud =   [GlobalMethods ShowProgressHud:self.view];
            
            NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
            
            [param setObject:@"saveUserDetails" forKey:@"methodName"];
            
            [param setObject: [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
            
            [param setObject:_categoryId forKey:@"categoryId"];
            
            [param setObject:_strsubCategoryId forKey:@"subCategoryId"];
            
            [param setObject:_tfExpYear.text forKey:@"experience"];
            
            [param setObject:_tfHourlyCompensate.text forKey:@"rate"];
            
            [param setObject:_tviewDescribe.text forKey:@"description"];
            
            NSData* imageData = UIImageJPEGRepresentation(kAppDel.EmployeeProfileImage, 1.0);
            
            [self returnImage:[UIImage imageWithData:imageData]];
            
            [kAFClient POST:MAIN_URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
             {
                 [formData appendPartWithFileData:dataProfileImg name:@"profilePic" fileName:@"image.jpg" mimeType:@"image/jpeg"];
                 
             } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 kAppDel.obj_FinalRegisteredEmployee
                 = [[FinalRegisteredEmployee alloc] initWithDictionary:responseObject];
                 /*-------Archiving the data----*/
                 
                 NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_FinalRegisteredEmployee];
                 
                 /*----Setting user default data------*/
                 
                 [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"FinalRegisteredEmployee"];
                 
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [kAppDel.progressHud hideAnimated:YES];
                 UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Registration completed" message:@"Your registration has been completed successfully" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                        {
                            //            [GlobalMethods SlideNavigationRootViewForEmployee];
                                       //            [GlobalMethods SlideNavigationLeftMenu];
            employeeJobNotification *obj_employeeJobNotification = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeJobNotification"];
                [self.navigationController pushViewController:obj_employeeJobNotification animated:YES];
            }]];
                 [self presentViewController:alert animated:YES completion:nil];
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 [kAppDel.progressHud hideAnimated:YES];
                 
             }];
            
        }else{
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
        }
    }
}
- (IBAction)btnCameraClicked:(id)sender
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate =self;
    imagePicker.allowsEditing = YES;
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
                                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    [self presentViewController:imagePicker animated:YES completion:nil];
                                }
                    else
                    {
                        [self presentViewController:[GlobalMethods AlertWithTitle:@"Camera missing" Message:@"It seems that no camera is attached to this device" AlertMessage:@"OK"]animated:YES completion:nil];
                        }
                    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                [self presentViewController:imagePicker animated:YES completion:nil];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
#pragma mark - ImagePicker Delegates.

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [self.btnCamera setImage:chosenImage forState:UIControlStateNormal];
    
    kAppDel.EmployeeProfileImage = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITextfield  and textview Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == _tfExpYear)
    {
        [theTextField resignFirstResponder];
        [_tfHourlyCompensate becomeFirstResponder];
    }
    if (theTextField == _tfHourlyCompensate)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}

/* TextView PlaceHolder
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (_tviewDescribe.textColor == [UIColor lightGrayColor])
    {
        _tviewDescribe.text = @"";
        _tviewDescribe.textColor = [UIColor blackColor];
    }
    return YES;
}
-(void) textViewDidChange:(UITextView *)textView
{
    if(_tviewDescribe.text.length == 0){
        _tviewDescribe.textColor = [UIColor lightGrayColor];
        _tviewDescribe.text = @"Describe your profile";
        [_tviewDescribe resignFirstResponder];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if(_tviewDescribe.text.length == 0)
        {
            _tviewDescribe.textColor = [UIColor lightGrayColor];
            _tviewDescribe.text = @"Describe your profile";
            [_tviewDescribe resignFirstResponder];
        }
        return NO;
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

 */

#pragma Mark - Image
-(NSData*)returnImage :(UIImage *)img
{
    dataProfileImg = UIImageJPEGRepresentation(img, 1.0);
    return dataProfileImg;
}
#pragma mark - Tap Gesture
-(void)TapGesture
{
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}
@end
