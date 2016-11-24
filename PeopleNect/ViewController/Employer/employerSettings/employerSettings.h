//
//  employerSettings.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "PN_TextFieldGlobalMethod.h"
#import "CustomPlaceHolderTextField.h"
#import "MVPlaceSearchTextField.h"

@interface employerSettings : UIViewController

<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,PlaceSearchTextFieldDelegate,UITextFieldDelegate>

@property(nonatomic,strong) IBOutlet UIButton *btnCamera;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfComplement;

@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfName;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfSurname;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfEmail;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPhoneNumber;

@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfCountryCode;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPassword;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfCompanyName;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfZipCode;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfState;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfCity;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfStreetNumber;
@property (strong, nonatomic) IBOutlet MVPlaceSearchTextField *tfStreetName;
@property (strong, nonatomic) IBOutlet UIView *profileView;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (strong, nonatomic) IBOutlet UIView *numberComplemetView;

- (IBAction)btnCameraClicked:(id)sender;
- (IBAction)SaveClicked:(id)sender;

@end
