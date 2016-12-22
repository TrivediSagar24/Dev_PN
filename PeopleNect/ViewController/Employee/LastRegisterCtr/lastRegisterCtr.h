//
//  lastRegisterCtr.h
//  PeopleNect
//
//  Created by Narendra Pandey on 8/3/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PN_Constants.h"
#import "GlobalMethods.h"
#import "CustomPlaceHolderTextField.h"
#import "CustomPlaceHolderTextView.h"
#import "employeeJobNotification.h"
#import "subCategoryCtr.h"

@interface lastRegisterCtr : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>


@property (strong, nonatomic) IBOutlet UIButton *btnCamera;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfExpYear;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfHourlyCompensate;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextView *tviewDescribe;
@property (strong, nonatomic) NSString *categoryId;
@property (strong, nonatomic) NSString *strsubCategoryId;

- (IBAction)backBarButtonTapped:(id)sender;
- (IBAction)finishRegisterClicked:(id)sender;
- (IBAction)btnCameraClicked:(id)sender;
@end
