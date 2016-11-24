//
//  employeeViewController.h
//  PeopleNect
//
//  Created by Apple on 27/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPlaceHolderTextField.h"
#import "TPKeyboardAvoidingScrollView.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@class GPPSignInButton;
@interface employeeViewController : UIViewController

<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource ,GPPSignInDelegate>

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollObjMain;
@property (strong, nonatomic) IBOutlet UIView *mainContainer;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *middleView;
@property (strong, nonatomic) IBOutlet UIButton *googleSignInBtn;
@property (strong, nonatomic) IBOutlet UIButton *facebookSignInBtn;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfName;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfSurname;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfEmail;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPhoneCountryCode;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPhoneNumber;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfZipCode;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfStreetName;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfStreetNumber;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPassword;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *heightForMainContainer;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;
@property (strong, nonatomic) IBOutlet UIButton *btnPrivacyPolicy;
@property (strong, nonatomic) IBOutlet UILabel *lblGoogle;
@property (strong, nonatomic) IBOutlet UILabel *lblFacebook;
@property (strong, nonatomic) IBOutlet UIView *registerView;

- (IBAction)btnRegisterClicked:(id)sender;
- (IBAction)btnPrivacyClicked:(id)sender;
- (IBAction)googleSignInBtnClicked:(id)sender;
- (IBAction)facebookSignInClicked:(id)sender;


@end
