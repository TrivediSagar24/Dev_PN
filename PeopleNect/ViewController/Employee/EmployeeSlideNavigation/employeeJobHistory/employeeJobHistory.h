//
//  employeeJobHistory.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/7/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "FZAccordionTableView.h"
#import "AccordionHeaderView.h"
#import "onGoingSectionCell.h"
#import "workhistoryCell.h"

@interface employeeJobHistory : UIViewController

<UITableViewDelegate ,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *jobHistoryLbl;
@property(strong,nonatomic) NSArray *jobHistoryOptions;
@property (strong, nonatomic) IBOutlet FZAccordionTableView *JobHistoryTV;
@property(strong,nonatomic) NSMutableArray *WorkhistoryArray;
@property(strong,nonatomic) NSMutableArray *declineJobArray;
@property(strong,nonatomic) NSMutableArray *otherJobArray;

@end
