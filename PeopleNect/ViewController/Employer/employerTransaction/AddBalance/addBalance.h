//
//  addBalance.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "PN_TextFieldGlobalMethod.h"
#import "employerTransaction.h"
#import "PayPalMobile.h"

@interface addBalance : UIViewController
<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource ,PayPalPaymentDelegate>

@property (strong, nonatomic) IBOutlet PN_TextFieldGlobalMethod *tfBalance;
@property(strong,nonatomic)NSMutableArray *packageCredit;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;


- (IBAction)AddBalanceClicked:(id)sender;

@end
