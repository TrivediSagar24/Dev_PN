//
//  employerTransaction.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "transactionCell.h"
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "addBalance.h"
#import "MenuCtr.h"
@interface employerTransaction : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblTransactio;
@property (strong, nonatomic) IBOutlet UITableView *transactionTableView;
@property (strong, nonatomic) IBOutlet UILabel *YourBalanceLbl;
@property(strong,nonatomic)NSMutableArray *transactionHistoryArray;

- (IBAction)AddBalanceClicked:(id)sender;
@end
