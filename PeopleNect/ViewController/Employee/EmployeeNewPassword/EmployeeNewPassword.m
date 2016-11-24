//
//  EmployeeNewPassword.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "EmployeeNewPassword.h"

@interface EmployeeNewPassword ()

@end

@implementation EmployeeNewPassword
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"Gray_right_arrow_"];
}
#pragma mark - Navigation Bar Back Button
-(void)barBackButton
{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
    {
        if ([viewControllrObj isKindOfClass:[employeeVerifyOTP class]])
        {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }

}
#pragma mark - IBAction
- (IBAction)resetPasswordClicked:(id)sender
{
    if (_tfNewPassword.text.length==0)
    {
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Password is Required" Message:@"Please enter Password" AlertMessage:@"OK"]animated:YES completion:nil];
    }
    else
    {
        if (_tfNewPassword.text.length>0)
        {
            NSString *passwordRegex = @"((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%?_!^&*]).{8,})";
            NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
            [passwordTest evaluateWithObject:_tfNewPassword.text];
        if([passwordTest evaluateWithObject:_tfNewPassword.text])
        {
            kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];[_param setObject:@"resetPassword"forKey:@"methodName"];
       
        NSString * userId = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"];
            
    [_param setObject:userId forKey:@"userId"];
            
    [_param setObject:_tfNewPassword.text forKey:@"newPassword"];
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
        {
        
            [kAppDel.progressHud hideAnimated:YES];
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Password Changed" message:[responseObject valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
          
                if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"] isEqualToString:@"Employer"])                        {
                EmployerLoginCtr *EmployerLoginCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployerLoginCtr"];
                [self.navigationController pushViewController:EmployerLoginCtr animated:YES];
                                          
                    }
                                      
            else{
            employeeLoginCtr *obj_employeeLoginCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeLoginCtr"];
        [self.navigationController pushViewController:obj_employeeLoginCtr animated:YES];
                                      }
                                      
                                  }]];
                [self presentViewController:alert animated:YES completion:nil];
            }
       
 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
        {
        }];
    }
    else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Invalid Password" Message:@"Password must contain an alphabet, a special character, a capital alphabet  and a number" AlertMessage:@"OK"]animated:YES completion:nil];
        }
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
    
    if (theTextField == _tfNewPassword){
        [theTextField resignFirstResponder];
    }
    return YES;
    
}
@end
