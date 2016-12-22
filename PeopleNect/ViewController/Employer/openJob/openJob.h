//
//  openJob.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/23/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "openJobCell.h"
#import "openJobSelected.h"
#import "FZAccordionTableView.h"
#import "AccordionHeaderView.h"

@interface openJob : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet FZAccordionTableView *openJobTableView;
@property (strong,nonatomic)NSMutableArray *currentJob;
@property (strong,nonatomic)NSMutableArray *guestJob;

@end
