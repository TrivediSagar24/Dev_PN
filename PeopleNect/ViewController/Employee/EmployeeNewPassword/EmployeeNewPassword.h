//
//  EmployeeNewPassword.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "CustomPlaceHolderTextField.h"
#import "PN_Constants.h"
#import "employeeLoginCtr.h"
#import "EmployerLoginCtr.h"
#import "employeeVerifyOTP.h"
@interface EmployeeNewPassword : UIViewController
<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfNewPassword;

- (IBAction)resetPasswordClicked:(id)sender;

@end
