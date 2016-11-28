//
//  EmployerLastDetailsCtr.h
//  PeopleNect
//
//  Created by Apple on 11/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PN_TextViewGlobalMethods.h"
#import "PN_TextFieldGlobalMethod.h"
#import "PN_ButtonGlobalMethods.h"
#import "subCategoryCtr.h"
#import "APRoundedButton.h"
#import "repostJobEmployerCtr.h"
#import "CustomPlaceHolderTextField.h"
#import "CustomPlaceHolderTextView.h"
#import "PN_Constants.h"
#import "GlobalMethods.h"
#import "MVPlaceSearchTextField.h"
@interface EmployerLastDetailsCtr : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate,PlaceSearchTextFieldDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addressViewHeightConstraints;
@property (strong, nonatomic) NSString *jobId;
@property (strong, nonatomic) NSString *repostProfileURL;

@property (strong, nonatomic) IBOutlet UIView *addressView;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfJobTitle;
@property (strong, nonatomic) IBOutlet UIView *profileView;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfStartDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCounter;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfStartHour;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfEndHour;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfEndDate;
@property (strong, nonatomic) IBOutlet PN_ButtonGlobalMethods *btnCheckBox2;
@property (strong, nonatomic) IBOutlet PN_ButtonGlobalMethods *btnCheckBox1;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfHoursPerDay;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfMoneyPerHour;
@property (strong, nonatomic) IBOutlet UILabel *tfTotallPay;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextView *tvJobDescription;
@property (strong, nonatomic)  NSString *subCategoryId;
@property (strong, nonatomic) IBOutlet APRoundedButton *addBtn;
@property (strong,nonatomic)    NSString *categoryId;
@property (strong, nonatomic) IBOutlet APRoundedButton *subtractBtn;
@property (strong, nonatomic) IBOutlet UILabel *companyAddresslbl;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfStreetNumber;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfComplement;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfZipCode;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfState;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfCity;
@property (strong, nonatomic) IBOutlet MVPlaceSearchTextField *tfStreetName;
@property (strong, nonatomic) IBOutlet PN_ButtonGlobalMethods *noEndDateBtn;
@property (nonatomic)  BOOL isFrominVitedScreen;
@property(strong,nonatomic) NSString *employeeName;
@property(strong,nonatomic) NSString *employeeID;
@property(strong,nonatomic) NSString *employeeProfielImage;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UILabel *lastDetailsLbl;



- (IBAction)noEndDateClicked:(id)sender;
- (IBAction)onClickAdd:(id)sender;
- (IBAction)onClickSubtract:(id)sender;
- (IBAction)onClickCheckBox1:(id)sender;
- (IBAction)onClickCheckBox2:(id)sender;
- (IBAction)onClickFinishJobPost:(id)sender;
@end
