//
//  EmployeeForgotPasswordCtr.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "CustomPlaceHolderTextField.h"
#import "PN_Constants.h"
#import "employeeVerifyOTP.h"
#import "employeeLoginCtr.h"
#import "EmployerLoginCtr.h"
@interface EmployeeForgotPasswordCtr : UIViewController

<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfEmail;

- (IBAction)ResetPasswordClicked:(id)sender;

@end
