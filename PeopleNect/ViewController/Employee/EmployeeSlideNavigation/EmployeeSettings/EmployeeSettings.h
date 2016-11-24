//
//  EmployeeSettings.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/16/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPlaceHolderTextView.h"
#import "CustomPlaceHolderTextField.h"
#import "SlideNavigationController.h"
#import "PN_TextFieldGlobalMethod.h"
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "CategoryEmployeeCtr.h"
#import "SubViewCtr.h"

@interface EmployeeSettings : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *EmployeeProfileImage;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfName;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfSurname;
@property (strong, nonatomic) IBOutlet PN_TextFieldGlobalMethod *tfEmail;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfCountryCode;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPhoneNumber;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfCategory;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfSubCategory;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfExperience;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPriceHour;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPassword;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property(strong,nonatomic) NSString *strCategory;
@property(strong,nonatomic) NSString *strCategoryId;
@property(strong,nonatomic) NSString *strSubCategory;
@property(strong,nonatomic) NSString *strSubCategoryId;
@property(strong,nonatomic) NSString *Exp;
@property(strong,nonatomic) NSString *Price;

@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *zipcode;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *streetName;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *streetNumber;

@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextView *profileDescriptionTV;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;

- (IBAction)SaveUserDetailClicked:(id)sender;

@end
