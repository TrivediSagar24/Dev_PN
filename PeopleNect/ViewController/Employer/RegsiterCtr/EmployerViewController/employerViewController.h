//
//  employerViewController.h
//  PeopleNect
//
//  Created by Narendra Pandey on 27/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "PN_Constants.h"
#import "EmployerSecondScreenCtr.h"
#import "GlobalMethods.h"
#import "SubViewCtr.h"
#import "responseDataOC.h"
#import "CustomPlaceHolderTextField.h"

@interface employerViewController : UIViewController
<UIPickerViewDelegate,UITextFieldDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightForContainerView;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfCountryCode;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPassword;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfName;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfEmail;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfSurname;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@property (weak, nonatomic) IBOutlet UIButton *buttonPriviceProtection;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *obj_scrollView;


- (IBAction)onClickContinue:(id)sender;

@end
