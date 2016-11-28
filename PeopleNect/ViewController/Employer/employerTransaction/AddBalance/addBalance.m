//
//  addBalance.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//
#import "SubViewCtr.h"
#import "addBalance.h"

@interface addBalance ()

@end

@implementation addBalance
#pragma mark - View Lifecycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self packageListing];
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"Gray_right_arrow_.png"];
}


#pragma mark - Navigation Bar Back Button -
-(void)barBackButton{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers){
    if ([viewControllrObj isKindOfClass:[employerTransaction class]]){
        [self.navigationController popToViewController:viewControllrObj animated:YES];
    }
}
}


#pragma mark - packageListing -
-(void)packageListing{
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        _packageCredit = [[NSMutableArray alloc]init];
        [_param setObject:@"packageListing" forKey:@"methodName"];
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _packageCredit = [[responseObject valueForKey:@"data"]valueForKey:@"amount"];
            _tfBalance.text = [_packageCredit objectAtIndex:0];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];

    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}


#pragma mark - Picker -
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [_packageCredit count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%@",[_packageCredit  objectAtIndex:row] ];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _tfBalance.text =[NSString stringWithFormat:@"%@",[_packageCredit  objectAtIndex:row]];
}


#pragma mark - Picker ToolBar Next button -
-(void)next{
    [_tfBalance resignFirstResponder];
}


#pragma mark - textField Delegates -
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == _tfBalance){
        [self rightArrow:0];
        _tfBalance.inputView = [SubViewCtr sharedInstance];
        [SubViewCtr sharedInstance].obj_PickerView.delegate = self;
        [SubViewCtr sharedInstance].obj_PickerView.dataSource = self;
        [[SubViewCtr sharedInstance]
         toolBarPickerWithSelector:@selector(next) Target:self];
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self rightArrow:1];
}


#pragma mark - IBActions -
- (IBAction)AddBalanceClicked:(id)sender{
    
    if ([GlobalMethods InternetAvailability]) {
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        payment.amount = [[NSDecimalNumber alloc] initWithString:_tfBalance.text];
        payment.currencyCode = @"USD";
        payment.shortDescription = @"PeopleNect";
        payment.items = nil;
        payment.paymentDetails = nil;
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                    configuration:self.payPalConfig
                                                                                                         delegate:self];
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }else{
    [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}


#pragma mark - PayPalPaymentDelegate -
- (void)payPalPaymentDidCancel:(nonnull PayPalPaymentViewController *)paymentViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)payPalPaymentViewController:(nonnull PayPalPaymentViewController *)paymentViewController
                willCompletePayment:(nonnull PayPalPayment *)completedPayment
                    completionBlock:(nonnull PayPalPaymentDelegateCompletionBlock)completionBlock{
    NSDictionary *confirmation = completedPayment.confirmation;
    [self addbalance:[[confirmation valueForKey:@"response"]valueForKey:@"id"]];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - rightArrow -
-(void)rightArrow:(int)edit{
    UIView *paddingRightImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tfBalance.layer.frame.size.height, _tfBalance.layer.frame.size.height)];
    UIButton * btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 0, _tfBalance.layer.frame.size.height, _tfBalance.layer.frame.size.height);
    if (edit==0) {
        [btn setImage:[UIImage imageNamed:@"Rarrow"] forState:UIControlStateNormal];
    }
    else{
       [btn setImage:[UIImage imageNamed:@"down_arrow_"] forState:UIControlStateNormal];
    }
    [paddingRightImage addSubview:btn];
    _tfBalance.rightViewMode = UITextFieldViewModeAlways;
    _tfBalance.rightView = paddingRightImage;
}


#pragma mark - addBalance -
-(void)addbalance:(NSString *)paymentid{
    
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        [_param setObject:@"addBalanceFromPayPal" forKey:@"methodName"];
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        [_param setObject:paymentid forKey:@"paymentId"];
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [kAppDel.progressHud hideAnimated:YES];
            [self presentViewController:[GlobalMethods AlertWithTitle:[responseObject valueForKey:@"message"] Message:[NSString stringWithFormat:@"You have added %@ $",[responseObject valueForKey:@"amount"]] AlertMessage:@"OK"] animated:YES completion:nil];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
   }
@end
