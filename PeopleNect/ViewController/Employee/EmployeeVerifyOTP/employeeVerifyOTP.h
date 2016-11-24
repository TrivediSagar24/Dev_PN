//
//  employeeVerifyOTP.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "CustomPlaceHolderTextField.h"
#import "PN_Constants.h"
#import "EmployeeNewPassword.h"
#import "EmployeeForgotPasswordCtr.h"
@interface employeeVerifyOTP : UIViewController
<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfOTP;
@property(nonatomic,strong)NSString *EmployeeOTP;


- (IBAction)verifyOTPClicked:(id)sender;
@end
