//
//  onGoingJobs.h
//  PeopleNect
//
//  Created by Narendra Pandey on 06/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZAccordionTableView.h"
#import "AccordionHeaderView.h"
#import "onGoingSectionCell.h"
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "seeDetailsNotification.h"
@interface onGoingJobs : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *ongoinglbl;
@property (strong, nonatomic) IBOutlet FZAccordionTableView *onGoingTV;
@property (strong, nonatomic) NSArray *onGoingArrayOptions;
@property(strong,nonatomic) NSMutableArray *nextApplicationArray;
@property(strong,nonatomic) NSMutableArray *pendingApplicationArray;
@end
