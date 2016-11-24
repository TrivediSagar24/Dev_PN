//
//  EmployerSecondScreenCtr.h
//  PeopleNect
//
//  Created by Apple on 29/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "AFNetworking.h"
#import "PN_Constants.h"
#import "employerViewController.h"
#import "SubViewCtr.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MenuCtr.h"
#import "responseDataOC.h"
#import "CustomPlaceHolderTextField.h"

@interface EmployerSecondScreenCtr : UIViewController
<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *obj_scrollView;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfComplement;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfCity;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfCompanyName;
@property (strong, nonatomic) IBOutlet UITextField *tfState;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightForContainerView;
@property (weak, nonatomic) IBOutlet CustomPlaceHolderTextField *tfZipCode;
@property (weak, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btnImage;
@property (nonatomic,strong) NSString *countryId,*stateId,*cityId;


- (IBAction)onClickImage:(id)sender;
- (IBAction)onClickRegister:(id)sender;

@end
