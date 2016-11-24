//
//  EmployeeForgotPasswordCtr.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "EmployeeForgotPasswordCtr.h"

@interface EmployeeForgotPasswordCtr ()
@end

@implementation EmployeeForgotPasswordCtr
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tfEmail.delegate = self;
    
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
     if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"] isEqualToString:@"Employee"])
     {
         for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
         {
             if ([viewControllrObj isKindOfClass:[employeeLoginCtr class]])
             {
                 [self.navigationController popToViewController:viewControllrObj animated:YES];
             }
         }
     }
   else
   {
       for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
       {
           if ([viewControllrObj isKindOfClass:[EmployerLoginCtr class]])
           {
               [self.navigationController popToViewController:viewControllrObj animated:YES];
           }
       }
   }
}

#pragma mark - IBAction

- (IBAction)ResetPasswordClicked:(id)sender
{
    BOOL email;
    email = NO;
    
    if (_tfEmail.text.length == 0)
    {
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Email is Required" Message:@"Please enter your Email" AlertMessage:@"OK"]animated:YES completion:nil];
    }
    else
    {
        if (_tfEmail.text.length>0)
        {
            if ([GlobalMethods validateEmailWithString:_tfEmail.text])
            {
                email = YES;
            }
            else
            {
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Invalid Email" Message:@"Please enter a valid email address" AlertMessage:@"OK"]animated:YES completion:nil];
            }
        }
    }
    
    if (email==YES)
    {
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        [_param setObject:@"forgotPassword" forKey:@"methodName"];
        [_param setObject:_tfEmail.text forKey:@"email"];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
        {
            [kAppDel.progressHud hideAnimated:YES];
            
            if ([responseObject valueForKey:@"OTP"]) {
                employeeVerifyOTP *obj_employeeVerifyOTP = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeVerifyOTP"];
                obj_employeeVerifyOTP.EmployeeOTP = [responseObject valueForKey:@"OTP"];
                
                NSString * str = [responseObject valueForKey:@"userId"];
                [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"EmployeeUserId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.navigationController pushViewController:obj_employeeVerifyOTP animated:YES];
            }
            else
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Error" Message:[responseObject valueForKey:@"message"] AlertMessage:@"OK"] animated:YES completion:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
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
    
    if (theTextField == _tfEmail){
        [theTextField resignFirstResponder];
                }
    return YES;
    
}
@end
