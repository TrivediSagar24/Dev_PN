//
//  employeeVerifyOTP.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeVerifyOTP.h"

@interface employeeVerifyOTP ()
@end

@implementation employeeVerifyOTP
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tfOTP.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"Gray_right_arrow_" ];
}
#pragma mark - Navigation Bar Back Button
-(void)barBackButton
{
    
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
    {
    if ([viewControllrObj isKindOfClass:[EmployeeForgotPasswordCtr class]])
        {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }

}
#pragma mark - IBActions
- (IBAction)verifyOTPClicked:(id)sender
{
    if (_tfOTP.text.length == 0)
    {
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Enter OTP" Message:@"Please enter received OTP" AlertMessage:@"OK"]animated:YES completion:nil];
    }
    else
    {
        if ([_tfOTP.text isEqualToString:[NSString stringWithFormat:@"%@",_EmployeeOTP]])
        {
            EmployeeNewPassword *obj_EmployeeNewPassword =  [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeNewPassword"];
            [self.navigationController pushViewController:obj_EmployeeNewPassword animated:YES];
        }
        else if (![_tfOTP.text isEqualToString:_EmployeeOTP])
        {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Wrong OTP" Message:@"Please enter Valid OTP" AlertMessage:@"OK"]animated:YES completion:nil];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSRange spaceRange = [string rangeOfString:@" "];
    if (spaceRange.location != NSNotFound)
    {
        return NO;
    } else {
        return YES;
    }
}
#pragma mark - UITextfield  and textview Delegates -
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    
    if (theTextField == _tfOTP){
        [theTextField resignFirstResponder];
    }
    return YES;
    
}

@end
