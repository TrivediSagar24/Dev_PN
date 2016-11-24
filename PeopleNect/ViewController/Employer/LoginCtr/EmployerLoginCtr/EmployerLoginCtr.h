//
//  EmployerLoginCtr.h
//  PeopleNect
//
//  Created by Apple on 11/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PN_Constants.h"
#import "SplashEmployerCtr.h"
#import "EmployerSecondScreenCtr.h"
#import "responseDataOC.h"
#import "EmployeeForgotPasswordCtr.h"
#import "GlobalMethods.h"
#import "MenuCtr.h"
#import "CustomPlaceHolderTextField.h"

@interface EmployerLoginCtr : UIViewController
<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPassword;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfEmail;
@property (strong, nonatomic) NSString *loginEmployerId;


- (IBAction)onClickLogin:(id)sender;
- (IBAction)onClickForgotPassword:(id)sender;
@end
