//
//  employeeLoginCtr.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PN_Constants.h"
#import "CustomPlaceHolderTextField.h"
#import "GlobalMethods.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "CategoryEmployeeCtr.h"
#import "employeeViewController.h"
@interface employeeLoginCtr : UIViewController
<GPPSignInDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblWithGoogle;
@property (strong, nonatomic) IBOutlet UILabel *lblWithFacebook;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfEmail;
@property (strong, nonatomic) IBOutlet CustomPlaceHolderTextField *tfPassword;


- (IBAction)GoogleLoginClicked:(id)sender;
- (IBAction)FacebookLoginClicked:(id)sender;
- (IBAction)LoginClicked:(id)sender;
- (IBAction)forgotPasswordClicked:(id)sender;

@end
