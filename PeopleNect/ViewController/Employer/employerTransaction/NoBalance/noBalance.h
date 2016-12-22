//
//  noBalance.h
//  PeopleNect
//
//  Created by Narendra Pandey on 30/09/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "NoBalanceCell.h"
#import "PayPalMobile.h"

@interface noBalance : UIViewController
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PayPalPaymentDelegate>

@property(strong,nonatomic)NSMutableArray *packageCredit;
@property (strong, nonatomic) IBOutlet UICollectionView *PackagePriceCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *addBalanceBtn;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

- (IBAction)CloseBtnClicked:(id)sender;
- (IBAction)addBtnClicked:(id)sender;
@end
